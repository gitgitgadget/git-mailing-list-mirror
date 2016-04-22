From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: 0 bot for Git
Date: Fri, 22 Apr 2016 10:19:21 +0200
Message-ID: <7F130640-40F1-454F-BC00-ACC5364404B8@gmail.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com> <CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com> <vpq60vnl28b.fsf@anie.imag.fr> <CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com> <vpqoa9ea7vx.fsf@anie.imag.fr> <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com> <88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com> <xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com> <BF9D5A7E-CB73-4F82-8D5F-42E120D07A3B@gmail.com> <CAGZ79ka4WmT8NjD-04WqwczuCuJZcoKMyDRQKkRH1sT5xoqRhQ@mail.gmail.com> <DB5772D2-89D4-4D14-8FD1-4AF6DDFD77AC@gmail.com> <xmqq60vh77pt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 22 10:21:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atWLY-0000F6-Lt
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 10:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbcDVIVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 04:21:48 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37691 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbcDVITa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 04:19:30 -0400
Received: by mail-wm0-f43.google.com with SMTP id n3so14646636wmn.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 01:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J5p8nAgH1zKp9Z/SVRHeHc9O2EtoJjCCvvGJOlbNlno=;
        b=zhExxkxPS+Q6Im1rOF1DvZrjDZH/fNWTjgNV1G1wLb7yS+tHzH5mQSM3BODiHiZiS5
         X1/5G/Ci9eVSLR+QCD0+N/+MWzhZgYn8g7wmzKm6110S9haw8668Jp9K+ydbESlUNHDz
         jkCw99Xx9/z6k2T/GZWGAkQMG7L9L7nAYM1CXXTDmeFMzZb+a9+6dyjTdZZiQUvm4Oxs
         z0Xf6GMuMu6I6m8Twhn0dzeYW2DoeQCKDfgPpuQ066/vs3CxiBsjH5MPcn7uiUVc0o9z
         K49DxjrpdYrLoC5sdq1t8+d5v1gxnOtH4OFvxblSba3vHfWBB+8kgR5kNo0u3IZA0bXi
         0/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J5p8nAgH1zKp9Z/SVRHeHc9O2EtoJjCCvvGJOlbNlno=;
        b=PtOdke/6CdPT5bjvej0JAVsUo62HxwEfod9pROyIv4ov70TUNF6kjKL7Q1sZgFetP/
         g6ppiDxwSmoAxl+B9d+lWVjcJcJhmQ01nGqHx1aggz/Lu499fwD2s53olfwmDjXFjp0e
         PdKp+GrSHAZaWgj0g1rkTKGtX/R6ycPhEosck9fkIiYyUchtCPs4idLPWmB0ryKJRuFL
         zxY5i+TvOhSDp16hUqtivjdcrdVROUGust33M1pRqEmROXu02XYhgv2p2WOBa2XK3iSE
         8ADs6tfe8E8Ge1CCaB+rMCME9YwZhzEd0fYOrwHPtWkKXSiGiFV8953aHw3sntk9DATb
         kBhg==
X-Gm-Message-State: AOPr4FUtDVsugtqO7td1yqizHLCz/Zor3Yh/FM+5APsZmHY6eON0kmqrPGf0TXP0ayXUGw==
X-Received: by 10.28.128.83 with SMTP id b80mr2349791wmd.41.1461313164180;
        Fri, 22 Apr 2016 01:19:24 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB43AA.dip0.t-ipconnect.de. [93.219.67.170])
        by smtp.gmail.com with ESMTPSA id p67sm2091652wmp.17.2016.04.22.01.19.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 01:19:23 -0700 (PDT)
In-Reply-To: <xmqq60vh77pt.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292180>


> On 16 Apr 2016, at 20:02, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> Also this would incur wait time on Junios side
>>> 
>>> 1) collect patches (many series over the day)
>>> 2) push
>>> 3) wait
>>> 4) do the merges
>> He could do the merges as he does them today but after some time
>> he (and the contributor of a patch) would know if a certain patch
>> brakes pu.
> 
> Read what you wrote again and realize that your step 1. does not
> require any expertise or taste from the person who does so.  Anybody
> could do it, in other words.  Instead of demanding me to do more of
> mindless chore, why don't you try doing that yourself with your fork
> at GitHub?
> 
> I suspect you haven't read my response $gmane/291469 to your message
> yet, but "as he does them today" would mean _all_ of the following
> has to happen during phase 1) above:
> 
> - Look at the patch and see if it is even remotely interesting;
> 
> - See what maintenance track it should apply to by comparing its
>   context and check availability of features post-image wants to
>   use in the mantenance tracks;
> 
> - Fork a topic and apply, and inspect the result with larger -U
>   value (or log -p -W);
> 
> - Run tests on the topic.
> 
> - Try merging it to the eventual target track (e.g. 'maint-2.7'),
>   'master', 'next' and 'pu' (note that this is not "one of these",
>   but "all of these"), and build the result (and optionally test).
>   Then discard these trial merges.
> 
> Two things you seem to be missing are:
> 
> * I do not pick up patches from the list with the objective of
>   queuing them in 'pu'.  I instead look for and process topics that
>   could go to 'next', or that I want to see in 'next' eventually
>   with fixes.  Queing leftover bits in 'pu' as "not ready for
>   'next'" is done only because I saw promises in them (and that
>   determination requires time from me), and did not fail in earlier
>   steps before they even gain a topic branch in my tree (otherwise
>   I wouldn't be able to keep up with the traffic).
> 
> * The last step, trial merges, is often a very good method to see
>   potential problems and unintended interactions with other topics.
>   A fix we would want to see in older maintenance tracks may depend
>   on too new a feature we added recently, etc.
> 
> Also see $gmane/291469

Thanks for the explanation. My intention was not to be offensive.
I was curious about your workflow and I was wondering if the
Travis CI integration could be useful for you in any way.

Best,
Lars
