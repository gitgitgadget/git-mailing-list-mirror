From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Option to revert order of parents in merge commit
Date: Mon, 26 Nov 2012 09:58:49 -0800
Message-ID: <7v8v9otfdy.fsf@alter.siamese.dyndns.org>
References: <20121123083550.GA702@camk.edu.pl>
 <7vfw3zzoye.fsf@alter.siamese.dyndns.org>
 <20121126124200.GA29859@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:59:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td2xj-0004S9-FZ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 18:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077Ab2KZR6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 12:58:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51857 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756933Ab2KZR6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 12:58:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C6139F91;
	Mon, 26 Nov 2012 12:58:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EuD+qayX5Cr0Y2Fje9mj9j0QMrg=; b=NnYmNi
	MsfbYyhfFgfdOuo/EEj9IZXRUfmi6VLhvKqZ9NldeS6iF+uiT7z2IPGCTIP08ZIV
	hk+5Xi7zA6yCFPpJ+UBu766XVZe53Gy+rNFmpdZ49s8rzsIoFqEer1Acc1i4qtf7
	vITw/z45VlqsaLJrb/OXQZj1jcxgWZRkgtkTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f06TJ1N9qJXZxtXcXlNxYMXEfs1NiwBI
	+aGZ1GsGCIHgbotqlJxU3gEAs7+w0WsceDIDrU7h2JII1xz1/DxGAGnAISXC9eB/
	dclBDJahoU5wa6ZAJACErQIye5vyHPT1m/YnMbSlkK5uXx2YfiEo0BQzst4C3pmD
	zSr+h3JInUE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19C4D9F90;
	Mon, 26 Nov 2012 12:58:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84B979F8C; Mon, 26 Nov 2012
 12:58:50 -0500 (EST)
In-Reply-To: <20121126124200.GA29859@camk.edu.pl> (Kacper Kornet's message of
 "Mon, 26 Nov 2012 13:42:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEFA01A2-37F2-11E2-8D59-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210461>

Kacper Kornet <draenog@pld-linux.org> writes:

>> Is there any interaction between this "pull --reverse-parents"
>> change and possible conflict resolution when the command stops and
>> asks the user for help?  For example, whom should "--ours" and "-X
>> ours" refer to?  Us, or the upstream?
>
> The change of order of parents happens at the very last moment, so
> "ours" in merge options is local version and "theirs" upstream.

That may be something that wants to go to the proposed commit log
message.  I am neutral on the "feature" (i.e. not against it but not
extremely enthusiastic about it either).

Thanks.
