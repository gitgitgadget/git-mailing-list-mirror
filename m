From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Re: importing two different trees into a fresh git repo
Date: Tue, 5 Feb 2013 16:35:54 -0800
Message-ID: <CAPKkNb494MvSETOS+1R+dbxKzcwZhbz7jEB-W=z-XuLBKDJWeA@mail.gmail.com>
References: <CAPKkNb6+ojb+uvBW+AkhGrhjR85LrJEbmR0KmvaKYb2Cj5Aa4g@mail.gmail.com>
	<7va9riqtro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 01:36:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2szv-00035u-8M
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 01:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696Ab3BFAf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 19:35:57 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:64915 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034Ab3BFAf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 19:35:56 -0500
Received: by mail-la0-f42.google.com with SMTP id fe20so827504lab.15
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 16:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=YXCpABcGlQJV/AadWBYDqGGmjMWX34QEvA4UWksfbqU=;
        b=RejC16il9ZdcyFN219oFvmKfk1IXKLuGIaD+bzbXxm3t5/XE9XrPeFEodkR4/n2f8u
         hsn4ljKGXb08/crbC7MRnBTDR3Hpt/Me2NnJH9D+polJiSAvVmiEwYu81AGNucNaihXZ
         Yxhpy1wWkOItDCRm0654RoN1DQnYJNJbyHHhnk+1oOC+7pN7tqIrjXALO8GCrK/LdZjt
         Sd5rR7iVENM/OIthmM7wwBcU/dGRJ6Eq51Z9gIUx0TlI9Y6p6EB5XX8fJKt+hQ/CRTQQ
         i0lzFz9pH+/H0GNiRqY9PR1VGl+Azq+WVvtw3nOqXlBzN28gjHRUR8JQmGyw1Lh9Joyq
         wCQA==
X-Received: by 10.112.17.166 with SMTP id p6mr5069527lbd.41.1360110954609;
 Tue, 05 Feb 2013 16:35:54 -0800 (PST)
Received: by 10.114.98.168 with HTTP; Tue, 5 Feb 2013 16:35:54 -0800 (PST)
In-Reply-To: <7va9riqtro.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215555>

On 5 February 2013 14:29, Junio C Hamano <gitster@pobox.com> wrote:
> "Constantine A. Murenin" <mureninc@gmail.com> writes:
>
>> I have two distinct trees that were not managed by any RCS, and I'd
>> like to import them into a single repository into two separate orphan
>> branches, then make sense of what's in there, merge, and unify into
>> 'master'.
>>
>> (To give some context, it's /etc/nginx config files from nginx/1.0.12
>> on Debian 6 and nginx/1.2.2 on OpenBSD 5.2.)
>
> As these come from two totally separate sources, I'd find it more
> natural to do two repositories, deb-nginx-conf and obsd-nginx-conf,
> each with one commit and then pull one into the other (or pull both
> to master-nginx-conf if you really wanted to), to me.

Yeah, I guess it might be more of a git-style to have two/three
separate repositories here.  (The sources are just a couple of files,
so I think my specific example still calls for merely two orphan
branches.)

Still, is it really expected that you can't create an orphan branch in
an empty repository?  On the outside, this sounds like a rather benign
bug.

C.
