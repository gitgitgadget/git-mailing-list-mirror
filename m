From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aw: Re: [PATCH v3 3/6] Change 'git' to 'Git' whenever the whole
 system is referred to #2
Date: Thu, 31 Jan 2013 16:46:02 -0800
Message-ID: <7vzjzodfp1.fsf@alter.siamese.dyndns.org>
References: <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 01 01:46:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U14lw-00064F-9k
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 01:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab3BAAqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 19:46:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918Ab3BAAqE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 19:46:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6488ABD1E;
	Thu, 31 Jan 2013 19:46:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iZVawLuweY8eAsJRXvYmVMx+Imc=; b=aN7EgD
	iYTG5hRKC03rYiaYWdJJN3OQ9fo+kiEh9UPfI+KA9DV+R5vckQIgLTIhW7TRG1z0
	XqNsUYSiKGgtuRgiqqkl/Svh9/va7Va2HMt/QP5HqajFV80MFVaDoRsEACbGiQZT
	pjlnV827ss0G1XwlYvkNH3YXPDubHHIZ0yeBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O5ZmDVaZIUOEJoPOSnAqkGG6lXCSa0+Q
	z5SMoJGWTVc6V2eSFYhZSMiR/iVHYeR9uUCZJrGLJw3wVPXpLi3HtFHKDr0yX39q
	5QSWRiercrHQkLkwhiqe6AO+c0bJyfYxQKxdgz0H+/znOSOzWpYifOI8rSgNcuFj
	2mZCk6wT+iQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59421BD1D;
	Thu, 31 Jan 2013 19:46:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA8AABD1A; Thu, 31 Jan 2013
 19:46:03 -0500 (EST)
In-Reply-To: <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
 (Thomas Ackermann's message of "Wed, 23 Jan 2013 09:58:22 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C19D0D36-6C08-11E2-9141-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215193>

Thomas Ackermann <th.acker@arcor.de> writes:

>  > 
>> Thomas, I do not want to see many rounds of entire rerolls of this
>> series on the list (nobody will look at the whole series multiple
>> times with fine toothed comb).  I do not think you want to do that
>> either.  Can you collect remaining fixups like David's message, turn
>> them into patch form when you have collected enough to be reviewed
>> in one sitting (say, a patchfile at around 200 lines), and send them
>> over to the list to apply on top of the tree of that commit?
>> 
> Sure!

I think we have waited long enough and as far as I recall we didn't
see any reports of misconversion or forgotten conversion, so I'll
squash the fixes parked on the topic branch, whose tip is at
bfb8e1eb6375afb (fixup! Change 'git' to 'Git' whenever the whole
system is referred to #4, 2013-01-22), and merge the result to
'next' sometime tomorrow.

Thanks.
