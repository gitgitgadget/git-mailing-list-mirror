From: Chirayu Desai <chirayudesai1@gmail.com>
Subject: Re: "git tag --contains <id>" is too chatty, if <id> is invalid
Date: Thu, 24 Mar 2016 22:52:12 +0530
Message-ID: <CAJj6+1Fvei-iv3QgP+P8o-0XqxOFVPL=DP6GOa1VKEx04VfGUg@mail.gmail.com>
References: <CAJj6+1Fcp+Fjx9N6Mon1A5uP-_npnPL1Acu5-cR_bHVfs3EMWA@mail.gmail.com>
	<20160319175705.GA6989@sigill.intra.peff.net>
	<CAJj6+1HaVnRcmDHOTDdx=o8a+aXvSi8+LykWzrfx7knE-_3ocg@mail.gmail.com>
	<20160319181228.GA9115@sigill.intra.peff.net>
	<CAJj6+1H6L=LxnDRzuC6OzXgVvzXsngGJ5X=E5Fi6Fg7JXkEJaQ@mail.gmail.com>
	<20160323224113.GB12531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:22:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj8xe-0000Pq-7j
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbcCXRWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:22:14 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37380 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcCXRWN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:22:13 -0400
Received: by mail-ig0-f170.google.com with SMTP id l20so16771053igf.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ysGuYBe5Q5VzZaxt4aaZAN3xYvzAgGL+l5T0zbbRxI8=;
        b=FDLGtanmr+Y2pzHP+T8mGImRg36qg5cZMG3gtInSeiC9Ac/FOxHbYs0FtAylD89+5u
         Mprb/RelwOMj8i8iVJ7nuZdlV6akQGwrZ73Y5hoXG0j02NKPUy0k1SLuelMkjM6WqA8Z
         gF56izW0GiQpdoMjReCP0M/2WLOWPpq15ka5cKNb4GLUTVsxfudnhyUb1qt/sYekGsFR
         MFyV2lUXqA2UV5+7ouzj6R0UC3nu+XtuG0r6W5AM1wOwtQ8U7VgWU7lzDA+kUPd9i59U
         Nc6uMo+Sc7v/dYk9DqnmUdWOmUDB+q4l3kniEQMv+7f7gnm3IK6CuhJlH5OBkx7G6hSO
         hTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ysGuYBe5Q5VzZaxt4aaZAN3xYvzAgGL+l5T0zbbRxI8=;
        b=BmZCq3TZ/w2mRK7lPS3Pe10vq3xO7F2fQJ2C52GoHlEbxrD1crAl6oRA2MGjt9S7uY
         uyDrGpEKfBUqevvWixNNNbRiT6XD0naLMcsdscpL3BV3XSpHiMZADYVqdv4uc1DjuOpi
         7bFmejeFF5ZxzcwkURIxhQuJxRgwQdOoLdO5hqa1m1yHRv0f31O1IUQXzWrCGrcHX+vC
         mJl8Q103xInTuyOKh638D0obPDW2tmo3VF6qY/RdDR+6AGWMyeQ5Ip8j5Y2VZYwi1LBu
         RfWlAWP/D0mQdETX6axrw06mbISUSKfYJyQlkhxZhzNuGmA1Egm2eVs/Lyo1VtkxU78W
         AzeQ==
X-Gm-Message-State: AD7BkJJlHSZvrY6kMoe+JazwDphcJRzAssYHJe54GuiUE6QY80TjrVAnDQHX1FbL8kMVrR89Ju9nG+41xyKaVw==
X-Received: by 10.50.65.74 with SMTP id v10mr10019560igs.33.1458840132334;
 Thu, 24 Mar 2016 10:22:12 -0700 (PDT)
Received: by 10.79.31.7 with HTTP; Thu, 24 Mar 2016 10:22:12 -0700 (PDT)
In-Reply-To: <20160323224113.GB12531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289766>

On Thu, Mar 24, 2016 at 4:11 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Mar 20, 2016 at 12:19:46PM +0530, Chirayu Desai wrote:
>
>> I went for 3, and have sent a patch for that here - [PATCH/GSoC]
>> parse-options: Add a new nousage opt
>> However, it currently has one bug
>> Running 'git tag --contains qq' twice will first show an error, then
>> print qq, meaning that the first command creates the tag qq.
>> Running 'git tag -l --contains qq' works fine.
>> My first question is if 'git tag --contains' (without '-l') supposed to work?
>> If not, then I would fix that bug, otherwise fix the bug my code
>> introduced, and add tests for it.
>
> Yes, "--contains" should imply "-l", and we should complain if there is
> an attempt to create a tag.
Right, makes sense.
>
> This seems to work with the tip of "master":
>
>   $ git tag --contains v2.8.0-rc3
>   v2.8.0-rc3
>   v2.8.0-rc4
>
>   $ git tag --contains qq
>   error: malformed object name qq
>   [...and then the usage...]
>
>   $ git tag --contains HEAD qq
>   fatal: --contains option is only allowed with -l.
>
>   $ git rev-parse --verify qq
>   fatal: Needed a single revision
>
> but with your patch:
>
>   $ git tag --contains qq
>   error: malformed object name qq
>
>   $ git rev-parse --verify qq
>   e9cacb7f8231dd6616671f9bcdd0945043483064
>
> So presumably we're not aborting the program when the options fail to
> parse, and it continues to process the "qq" as a tag to be created.
Yep, it was because I was returning PARSE_OPT_DONE on case -3 in
parse-options.c::parse_options_step
Making it return -1 fixed that.
>
> -Peff

Thank you for the help, detailed explanations and code reviews.
