From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: Aw: Re: [PATCH v3 3/6] Change 'git' to 'Git' whenever
 the whole system is referred to #2
Date: Fri, 01 Feb 2013 10:37:40 -0800
Message-ID: <7v8v77c22z.fsf@alter.siamese.dyndns.org>
References: <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
 <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 19:38:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1LV0-0006C2-5g
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:38:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab3BASho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:37:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360Ab3BAShm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 13:37:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20CE6C3A6;
	Fri,  1 Feb 2013 13:37:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M4dK5SXHRjntdri+QyeaVkpCek0=; b=Xsq1A8
	M4/S1k8BNrAN/lze6OfRkcEHzrd1rY0y+/XbntsW3A+V5mDMO+Ft+FvAX8U640GJ
	Exi/BBEoYQTIXkCMurI9piiLWBqLSvL/e/p9zCAwvi+UIVdGpuxf96z1CJjmQ8ku
	LkQu8SsrHWpkSReWjlaSTVXqzD02+6iOLNSYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wo8xbWLXpa1B6pvZ+iR06uKAmZpOMKJs
	6MVV3cb/xx6L5/bykkP7hro+qac/aqRM4OT6tt7HGlH0t0J46zPRFQgK/GAM4jNE
	qyGxC31QriNQPqUivvnM2BuBpid1gt0EjbtMuAVJctWbiYr2yU2xac/B4zM0NVnz
	+3R0BeSxyG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15E73C3A5;
	Fri,  1 Feb 2013 13:37:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F7D1C3A3; Fri,  1 Feb 2013
 13:37:41 -0500 (EST)
In-Reply-To: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
 (Thomas Ackermann's message of "Fri, 1 Feb 2013 19:04:00 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7610C74A-6C9E-11E2-96BC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215245>

Thomas Ackermann <th.acker@arcor.de> writes:

>  > 
>> I think we have waited long enough and as far as I recall we didn't
>> see any reports of misconversion or forgotten conversion, so I'll
>> squash the fixes parked on the topic branch, whose tip is at
>> bfb8e1eb6375afb (fixup! Change 'git' to 'Git' whenever the whole
>> system is referred to #4, 2013-01-22), and merge the result to
>> 'next' sometime tomorrow.
>
> Here are my final fixups on top of bfb8e1eb6375afb:
> I morphed the remarks from Junio and David into patch form and
> also did the reverse check for wrong usage of 'Git' instead of 'git'.
> While doing the later I also noticed some small glitches and fixed them.
> Squash at your will.

Thanks.

> [PATCH 1/6] fixup! fixup! Change 'git' to 'Git' whenever the whole system is referred to #2
> [PATCH 2/6] fixup! fixup! fixup! Change 'git' to 'Git' whenever the whole system is referred to #1
> [PATCH 3/6] fixup! Documentation: avoid poor-man's small caps
> [PATCH 4/6] Fix places where 'Git' should be 'git
> [PATCH 5/6] Add a description for 'gitfile' to glossary
> [PATCH 6/6] Use consistent links for User Manual and Everyday Git; Fix a quoting error
