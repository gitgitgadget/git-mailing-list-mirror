From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 02/16] t3020 (ls-files-error-unmatch): remove stray '1'
 from end of file
Date: Sun, 03 Oct 2010 17:56:25 -0700
Message-ID: <7v8w2edbd2.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-3-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 02:56:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ZMB-0004Rk-7X
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 02:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab0JDA4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 20:56:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0JDA4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 20:56:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DD66DB942;
	Sun,  3 Oct 2010 20:56:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SDYdw5pJy80jDSideweDsadWleU=; b=DeWExC
	YseZuh10TLehUh/INIbdWqYSwEO4glq6Wjyctf1uqhFar62kA30ggkQT3x4TrJw+
	Bt1FYR4BatO7FsARfVKEVVEWOGCEHVWyaY3xdG7jHSNPObaaEca8CTW7CRzL1CuW
	SeBGetoyLzPLaM/wJ242eppAL8iHClYmDKj80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a25g0dcoblLpYSwkf2YbUP7i6V5PsIPW
	AdIE38vwzBif3Li8th7sQG7K8RAVyPDEotSlFel15J+OMElmzilSYuwwDyLl491C
	qM3miMNbzJ83EImV6Kteb56D6/MICx3hnjm/jyux+H554XxWjzBwpsbTo9cU4pl1
	VcDIl2Q9/Yg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC6E2DB93F;
	Sun,  3 Oct 2010 20:56:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92D53DB931; Sun,  3 Oct
 2010 20:56:26 -0400 (EDT)
In-Reply-To: <1286136014-7728-3-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Sun\,  3 Oct 2010 14\:00\:00 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B0CA524-CF52-11DF-9777-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157957>

Thanks; I'll take this to 'maint' outside the context of this series, so
we will have one less patch we have in the review ;-)
