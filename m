From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Wed, 31 Oct 2012 03:28:05 +0100
Message-ID: <CAMP44s3WODA2Vru0Q1b5EWA6_1vdHnPmFfUmDg0Phh0S=76O9w@mail.gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
	<20121030044609.GA10873@elie.Belkin>
	<CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
	<20121031012730.GY15167@elie.Belkin>
	<CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com>
	<20121031021318.GB15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:28:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTO2Y-0003nI-3C
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 03:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756886Ab2JaC2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 22:28:07 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40987 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324Ab2JaC2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 22:28:06 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so977924obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Fl+q4BUTUbZUw6ZfnpBT+40uyyRr13T2damLARWQ1lw=;
        b=u2Bx/7YkybQrEAXfzzWqWQwWMo0zTv2wez9gOikb9B1sEMnJLv0xwAF/TEHJXPAVZ2
         iWc+WRgRqXGLfMo2HLcH4so78Y3oTWJOJ51CL0gE23zHsaDdjlDPQkGfZsUh6+jYi4sf
         y9Z4FbtaZIpGCS0Lt+/97jfRz5XDpHpyFOkKm2zcNH1eHEcIT4YlTzECMqIxPMW6cUmJ
         8OAaWt0clNrf+ybzqBWq0p1S6u0aHRt5quDgWhYOcQAHL4SEGJu5Cv7Ugk8g8gNpddc/
         oVNXTW2Sf6oYeIu+NS6t4+FXnpVE0CsU3ynJYNS3TXgzWvodg1FTEIbvRH1tAfJyNmuw
         9dbg==
Received: by 10.60.12.233 with SMTP id b9mr31051153oec.95.1351650485637; Tue,
 30 Oct 2012 19:28:05 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 19:28:05 -0700 (PDT)
In-Reply-To: <20121031021318.GB15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208788>

On Wed, Oct 31, 2012 at 3:13 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> It's all fun and games to write explanations for things, but it's not
>> that easy when you want those explanations to be actually true, and
>> corrent--you have to spend time to make sure of that.
>
> That's why it's useful for the patch submitter to write them, asking
> for help when necessary.
>
> As a bonus, it helps reviewers understand the effect of the patch.
> Bugs averted!

Yeah, that would be nice. Too bad I don't have that information, and
have _zero_ motivation to go and get it for you.

> [...]
>> Either way, if obvious fixes that are one-liners require an essay for
>> you, I give up.
>
> I guess it is fair to call a reasonable subject line plus a couple of
> sentences an essay.  Yes, obvious fixes especially require that, since
> the bug caused by an obvious fix is one of the worst kinds.

Yes, I've written essays for one-line fixes, in the Linux kernel,
where details matter, and things are not so obvious.

This is not the case here. This is as obvious and simple as things
get. If there was a problem with it, somebody would have found it by
now.

Let not the perfect be the enemy of the good. Or do. Up to you.

-- 
Felipe Contreras
