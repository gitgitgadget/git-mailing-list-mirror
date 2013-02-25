From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/13] Documentation/Makefile: update git guide links
Date: Sun, 24 Feb 2013 21:29:25 -0800
Message-ID: <7vd2vp3qru.fsf@alter.siamese.dyndns.org>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
 <1361660761-1932-13-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 06:29:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9qdP-0003Yg-RW
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 06:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724Ab3BYF33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 00:29:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825Ab3BYF32 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 00:29:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF7B86F2;
	Mon, 25 Feb 2013 00:29:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bz8i0OBWzxkAD492I/AAeg1cwbs=; b=GiMbQd
	eel522Mb0TeX2lI811c8NSa/yove6SAU7DBjX/mBZ8VBp+kD0kdjFdKss6iKYm+/
	78EQ/KFkz5UqKEs6+ihQooAafR6ZvJwdPDHof0Y60usbZXmmWVH6wtwZwvlcodjc
	7qvQFUqAziyEgheDwQyM1mlyKVXakzOX/d3gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GgezrBhslDvipCj8MlyRzaVUC6i69CqN
	3L6LdOQzfp6MKUePy54/yXx/+6RXhQ7FvR69fScbgA2FIhZzQNycECRLMAr8NPDN
	bX0wl+rVMzAorUgPv4fozaZ/83Hkm5vHPykkDut8CntUGx5tUWjWE1A5TKbUd6IS
	APt90U8Don8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5523886F0;
	Mon, 25 Feb 2013 00:29:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADEB186EE; Mon, 25 Feb 2013
 00:29:27 -0500 (EST)
In-Reply-To: <1361660761-1932-13-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Sat, 23 Feb 2013 23:06:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52A1B398-7F0C-11E2-B679-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217027>

Philip Oakley <philipoakley@iee.org> writes:

> @@ -35,6 +37,8 @@ MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
>  MAN_HTML=$(patsubst %.txt,%.html,$(MAN_TXT))
>  
>  OBSOLETE_HTML = git-remote-helpers.html
> +OBSOLETE_HTML = everyday.html
> +OBSOLETE_HTML = user-manual.html
>  DOC_HTML=$(MAN_HTML) $(OBSOLETE_HTML)

If you are keeping track of inventory of "guides" in a new static
array, do you still need to look up "giteveryday" or "gituser-manual"
when the user asks for guide documents?

In other words, can't you change the side that launches the document
viewer so that we do not have to rename anything in the first place?
