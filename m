From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Feature Request: Passing a number as an option to git tags for
 displaying latest tags
Date: Thu, 23 Jul 2015 10:21:39 -0700
Message-ID: <CA+P7+xpasr7gOYiSsdAyCgh6+D8nYQf9vuEhRna8k7HWMu1Rcg@mail.gmail.com>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
 <xmqqbnf4rohs.fsf@gitster.dls.corp.google.com> <xmqq7fpsroc1.fsf@gitster.dls.corp.google.com>
 <55B0B667.6000103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?SGFsaWwgw5Z6dMO8cms=?= <halilozturk55@gmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:22:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIKC4-0006TT-87
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbbGWRWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:22:00 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36244 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbbGWRV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:21:59 -0400
Received: by oibn4 with SMTP id n4so170570262oib.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S1ot3kqGIPJagImewGllg8W3SMaqpXx7Kgk/WqXsQ0I=;
        b=FUDL0qu71TFyEMrcKHueKu30MtgoJv/vfwPQnEKmT4RcADGKyS+3FO1ES4oyr+/sSL
         AlJwCSOmnDPAW+K0+J/RRNsY15jrA+durogI+JDgr4LqVMqIuOlpybTV9UViQ81+MMfA
         iRkqWx2oUv8E6kyXgmd8qiPkFQaP+iGDO4MgkB/5cJCs9u0mKyZd+WWZj8cJAQ4ZXs2q
         n8/HvBxzrJPNpQ0RAR2eTjSgbCqrFzv59aTouZ2M9LkZrWK12M8AqTHVHRnKFUKseiDD
         HhJwdHNX97tDtKRZ+OHVbpVNm8g40GDDtH/oF62Q/kdOOnZK9wDmLK63Y0FbQgl6iH1n
         ft+A==
X-Received: by 10.182.143.5 with SMTP id sa5mr9918812obb.62.1437672118960;
 Thu, 23 Jul 2015 10:21:58 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Thu, 23 Jul 2015 10:21:39 -0700 (PDT)
In-Reply-To: <55B0B667.6000103@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274510>

On Thu, Jul 23, 2015 at 2:39 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> While not quite being intended for that purpose,
>
> git log --oneline --decorate --simplify-by-decoration [-n] --tags
>
> (or with a custom format instead of "--oneline --decorate") may come
> close to what you want.[*]
>
> Michael
>
> [*] As Linus once described it (iirc): oooh, evil. I like it.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Yep, that's pretty much how a build system I've had to use does it.
Sadly, this is quite slow, and I'm not sure if doing it built into the
tag via for-each-ref would be faster? I mean obviously having to look
at each commit is slower than just the tag name, but it might be
faster than parsing through the log process? Though the log output has
the advantage that it only shows you tags "on" a given branch.

Regards,
Jake
