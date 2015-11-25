From: Stefan Beller <sbeller@google.com>
Subject: Re: Git super slow on Windows 7
Date: Wed, 25 Nov 2015 12:42:06 -0800
Message-ID: <CAGZ79kYUor3Hx+ggaDvkc8MSH+nMtZrgGXRvgLz2qqHZmy5tCg@mail.gmail.com>
References: <EEA07A84-26D8-4709-97AC-2C4F3A0CC5BD@gmail.com>
	<0B47434E-00FE-463A-95F1-1F10537C9F7A@gmail.com>
	<CAGZ79kZQd4JrQsp6sk8x-OAWMxxbF+a8BXZb1VQSdJeiQ8jhuQ@mail.gmail.com>
	<CACsJy8Becrc57+56BCLSq8Pd9p5m2qpERqXwY2AN21H=BfADNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>,
	stephan.arens@autodesk.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:42:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1gtG-0002rR-Of
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbbKYUmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 15:42:08 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33621 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbbKYUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 15:42:07 -0500
Received: by ykdv3 with SMTP id v3so69222832ykd.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 12:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=C5WlFn2ITCU51y/SkHcC+shM05Dp23jSp1yjxg6viV0=;
        b=U5eo3FOpV7FEAXZbiupog/xWrAPzsF3BWC6FvaNjBfDV833wC4kL6lSKxVptPHYzh+
         ukkPgdV+wP14FJI6tStfIQdH9LDZCMlaTrE/dZmhLyD2z1iugzAlEougXstvKQEqdqTl
         JCaI1Le+NhsA7se82+OVVJcMMXJ5nhHta3NokpyH+uVr3iQv6fSeU/gdwy/pE8V+vBaU
         eXBvvAA7KE4Zr6kUKASvfPZVCkwkuu2GHO65bG30r5z15DbZrpmbeNZ+FiQsS8Qnr49j
         seRgXYXwpTj78rRX/3C6AooY9FjsgRPz5fwIjJKvYFf0Z0ukPsQn/LMDCwinr4d2hMdE
         W6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C5WlFn2ITCU51y/SkHcC+shM05Dp23jSp1yjxg6viV0=;
        b=X7A+C/2gRBTugkbNXPSMm8iUzOlGvQ7wW75um4y33AC6hL+qSPlkQCCRsfOfjqLjLT
         1O0UNB43a3mE7CpaQQ0VgH6N/otZmRa2BX1I2mvRQRPIs6Y4mtfMemdxeL/u6rqn5Snc
         ij8w321tspKedIjqHIk/KArQunQ1lcVEYJBT2XUITN1rX0zvXdoSAG19sJ05mKxjomQ+
         a7pioftuBxUwvywD32sProhuRCZA0DHK5lArAF0yh6QqUWN/HEdE7EMGfaa9/NyUV9/l
         cohZiSO8DHZP5+Os4Rzpr9SQwgCU6al15zj+Ik+izZeF7xXEG8Lu3qvCBLLTPlicVb8P
         7DwA==
X-Gm-Message-State: ALoCoQkzDGlROSuWWY/LfNqPc5Kq31KIoVFDiL5d1jFLYCNkrdg4fn0zFxuocyFj3KAFf/MIr9Ak
X-Received: by 10.13.214.19 with SMTP id y19mr34389767ywd.63.1448484126603;
 Wed, 25 Nov 2015 12:42:06 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 25 Nov 2015 12:42:06 -0800 (PST)
In-Reply-To: <CACsJy8Becrc57+56BCLSq8Pd9p5m2qpERqXwY2AN21H=BfADNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281741>

On Wed, Nov 25, 2015 at 12:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Nov 25, 2015 at 7:47 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Nov 25, 2015 at 10:42 AM, Lars Schneider
>> <larsxschneider@gmail.com> wrote:
>>> After some investigation I figured that ~50 Submodules are the culprit.
>>> Does anyone have an idea how to speed up Git on Windows while keeping 50 Submodules?
>>>
>>> Thanks,
>>> Lars
>>>
>>>
>>
>> Use the latest version of Git ;)
>
> Does it do parallel refresh yet? I think it would help.  I only looked
> at "git log --merges origin/pu" and nothing caught my eyes.

No. The hinted patch series only does a partial shell->C conversion, which
is the best guess for improving git status here.

I punted on parallel local operations inside "git submodule update" for now, too
as when things go wrong there, you need a human to resolve the merge conflict,
and as a user you only want to deal with one merge conflict at a time instead of
being left there with a ton of unresolved issues (according to the git
log of older
patches in the submodule area).

git status should require not human interaction if things go bad
within submodules,
so we may want to speed that up by parallelizing the submodule part. The status
command gathers all information of submodules by a call to "git
submodule summary"
and does some slight post processing on the output. "git submodule
summary" however
is written completely in shell code (200 lines, so I estimate 400 lines of C).

I will benchmark that later today and check if it's worth for us to
rewrite that in C for
our case (we plan to have lots more submodules, but we're a linux shop)
