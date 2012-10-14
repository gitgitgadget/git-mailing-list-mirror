From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why git shows staging area to users?
Date: Sat, 13 Oct 2012 21:38:07 -0700
Message-ID: <7vtxtx1xe8.fsf@alter.siamese.dyndns.org>
References: <CAFT+Tg-g6KOs3YUKV_GWbZiO9qUG3LP8-T3Tdyd3LinnheQZ8A@mail.gmail.com>
 <CAJDDKr7tUJ59jYDM-jhFnGMEB18taT7FsTJ24Hr=iBUgXXeYdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: semtlenori@gmail.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 06:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNFz8-0006mb-5p
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 06:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab2JNEiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 00:38:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52875 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab2JNEiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 00:38:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95FA79F97;
	Sun, 14 Oct 2012 00:38:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=x5zfJVqjPkjCBMkBYaCdsUS0C7c=; b=v5p1PJ
	34MEVFdcrlFTcJZka4h3UeWOmmd3tRJaZ/LQVHiTdP9NDnnP0aN+0Jy94iRmRsll
	CQsHtOUK4w3QmXZxssOBRQC5URENqDJFejsktnmGuudYkD1ZRdZOmkoGvR0Xq9Jz
	KAClFeRRdxtT0sSqhNIEABY/VAGaytBY7BnOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CjITEeCC3o1g/6ulsUKTYcvehRHutj5T
	AnMbwqlDLC2ucSvJW59UUBkXO6SmicnoWcGaGGKq6i9MfmmlHcl/0Wcnsiq8pbCw
	dY+ypyvoQB92LX+LY9/GD6cAua2hN2yU3jQ1DgXXN3UVNl9yjC1AcdoOstQoglGk
	WUUNtyrtxSQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8345C9F96;
	Sun, 14 Oct 2012 00:38:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB6189F93; Sun, 14 Oct 2012
 00:38:08 -0400 (EDT)
In-Reply-To: <CAJDDKr7tUJ59jYDM-jhFnGMEB18taT7FsTJ24Hr=iBUgXXeYdg@mail.gmail.com> (David
 Aguilar's message of "Sat, 13 Oct 2012 17:56:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F43386A4-15B8-11E2-92F9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207605>

David Aguilar <davvid@gmail.com> writes:

> On Sat, Oct 13, 2012 at 2:08 PM, Yi, EungJun <semtlenori@gmail.com> wrote:
>> Hi, all.
>>
>> Why git shows staging area to users, compared with the other scms hide
>> it? What benefits users get?
>
> http://thkoch2001.github.com/whygitisbetter/#the-staging-area
> http://tomayko.com/writings/the-thing-about-git
> http://gitready.com/beginner/2009/01/18/the-staging-area.html
>
> Other scms do not "hide"; other scms lack this feature altogether.
>
>> I feel staging area is useful, but it is difficult to explain why when
>> someone asks me about that.
>
> See above.

Very well said.  Thanks.
