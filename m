From: Vincenzo di Cicco <enzodicicco@gmail.com>
Subject: Re: Reference to a commit inside a commit message
Date: Mon, 28 Apr 2014 22:43:04 +0200
Message-ID: <CAKOJyXd4eAt5120WnEj6VeRfOG_tz5uYiEDw5cqGpDaQd6bzow@mail.gmail.com>
References: <20140428183552.GA9709@workstation.Belkin>
	<20140428195544.GN9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:43:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesOL-0001bp-W1
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702AbaD1UnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:43:05 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:46415 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbaD1UnE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:43:04 -0400
Received: by mail-vc0-f182.google.com with SMTP id lf12so6787848vcb.27
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Dm1rSZaP8R+YLz3aMn7fKs5hkPAYCdwo1Sv2dZjXTwE=;
        b=f/saZC4SsMiXCkOhaoVuSKjUgThUsUpDrAQzO+MUbPsbAJSvs768VYd7J/c2wx+uVF
         /Zci2PDVa0O9d0pk0wZaJV+1wSsf+qh7G4vxUaoi/8YJlrh5yZXQNZUKZT8p2OpF0wyX
         riWqTQ530lik1VPJVzcKNz5zj7z9TKEcxS8lGVMLwa1PdmwU0n8BY773d6CxkZYOhokm
         RyXvC3T0b48ts00Xkvo3c0dqB1ry8rP4ff4a5kIrxMH1nMGl/ZYShoeeEfTR4JFCvIML
         aou6+AXefNGdUOCPeSWK36DHNkJxfGMsGnCoD/6LYv4jJXNspK3ve78NVGMt2dMkiajD
         A1Wg==
X-Received: by 10.52.124.66 with SMTP id mg2mr1721208vdb.50.1398717784298;
 Mon, 28 Apr 2014 13:43:04 -0700 (PDT)
Received: by 10.220.177.198 with HTTP; Mon, 28 Apr 2014 13:43:04 -0700 (PDT)
In-Reply-To: <20140428195544.GN9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247441>

Thank you very much

> Why not?

the reason is to avoid mistakes with the hash. An automatic approach
can verify the existence of the commit.

> See the output of
>
>         git log --grep='In commit '
>
> and
>
>         git log --grep='In v'

I've just tried the commands and noticed that this can be a common practice.
This increases my curiosity to know if there is a better way to handle
this situation, if you know other thread where was discussed, please
tell me the link.

Thanks,
NaN
