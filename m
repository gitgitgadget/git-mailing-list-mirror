Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC821FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 13:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbcFUNvm (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 09:51:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:64515 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbcFUNuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 09:50:46 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M936L-1b5DjI35kD-00CTp3; Tue, 21 Jun 2016 15:50:17
 +0200
Date:	Tue, 21 Jun 2016 15:50:15 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Lars Schneider <larsxschneider@gmail.com>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] perf: accommodate for MacOSX
In-Reply-To: <CD0404AE-529B-44B7-AE05-022D3062E596@gmail.com>
Message-ID: <alpine.DEB.2.20.1606211548230.22630@virtualbox>
References: <ae429d2481111f7ad1927ef22e3a691d4c99ebd7.1466254995.git.johannes.schindelin@gmx.de> <9A11C3D1-3DAC-489F-BDF9-F4D409E8D3F7@gmail.com> <alpine.DEB.2.20.1606200840350.22630@virtualbox> <xmqqa8iftzex.fsf@gitster.mtv.corp.google.com>
 <F67587B5-0EA8-4F2F-AADB-4343B4FEEA21@gmail.com> <alpine.DEB.2.20.1606211350470.22630@virtualbox> <CD0404AE-529B-44B7-AE05-022D3062E596@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sQ/SLDG8s8j45mnHZvSbS4AqUaoHiEX6rdd+7gYUYD/TSdm4CtC
 9zR2gnE2XqjUiuJNCUBu9tbeOGK/FjWsktdEnH2k6mGGPh4fxvDVlg+sdxyucNHj5dDXrKD
 llihr88exLXEHeGnqV3heBzyjq/R+TTc4nl0vmwtEJf6EbF2hUHTvPgJVn/0wJWsFxTdjBG
 n2VUQkXtYoDQazZtaDxuQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uz32JEdb348=:J0rcvThmHHHXMqEtxk63bB
 04dcSQgfPfytxIu+D3s4QR/HrkEFf27EL1iCBbROrD29KeWPgNaIXud0ziurFw2ChS/lnoTlF
 D1qLszURFtQBEeOJXGeL+kcUWHpae9AyqgsYroqbtgTpXqHAtWDCREgO3KCVS5i7kYBnksyV6
 yhokeRlvxMSHiFgMcV+erMnaV/hZgc06363HBBmfbRnFOvFvRWpEy+zH0ABixMXajikELDcqF
 VwfJ01aGMF295yuzXAfuzGmv6BMcL0lnXe8ubsA+D0rLoBPO3pTCd3dQVjQXTfhwtZsu5JPNx
 J/f6ZcqKU3Emge6yXQq2jNfYmFA/Je/ByOg8rEDgFXMknkw4HJ3mEXkUIyHifGf0IE7ySjDH2
 Ojfs7jMCAa61r/awjfnoT3QV03dRrH6tuXpaUAKOzwgy/AFTAeprkXhXUZhYjEYdhzSTUlBjL
 6VB8bWGoAkfSgyst5SxhNE6rj6d8K61GpyAzWZAuCrQI2HcGkOBJ5ht50qY1Lp5FsBVXMkYEz
 QopE3tnuwldYeUcGin7OUGvSViY4R8FV3EozAcu29824tIPL5w3DfpeRHi/Jm1ZFiwF7D/LHI
 7h3FGNoRRPGepEdJ0w8vDJwjo3I2yTZapBsOCkKA+ewRwoOksTE8zQhkpjJlSuOSFEEFUlWPp
 kkaQ2twWTiQxFUIGymxzIMTVRzZVZP4wWFV+PnQp/U0rP5XswsjvljehLyr6vhEvVvfS9VeoY
 KTN6OOTDiahsBg+evWnujv0hw+aPJcnU1Zy1pLLQG7XiGgw1O+rJ6bsrHrJ3ca6+IanaJKZAF
 fCdc9K8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Lars,

On Tue, 21 Jun 2016, Lars Schneider wrote:

> > On 21 Jun 2016, at 13:55, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> >> ...
> >> If we don't run any perf tests by default on Travis CI then I wouldn't
> >> take the ".travis.yml" part of the patch just to keep our Travis CI
> >> setup as lean as possible.
> > 
> > Maybe commented-out, so that people like me have a chance to use Travis
> > for MacOSX perf testing?
> > 
> > Could you let me know whether a commented-out
> > 
> > 	# Uncomment this if you want to run perf tests:
> > 	# brew install gnu-time
> > 
> > would be acceptable? I will reroll the patch accordingly.
> 
> Commented-out would be fine with me!

Okay! Updated patch coming in a moment.

> >> Running perf tests on Travis CI is probably bogus anyways because we
> >> never know on what hardware our jobs run and what other jobs run in
> >> parallel on that hardware.
> > 
> > While I agree that the absolute timings cannot be trusted, I have to point
> > out that the relative timings on Linux at least are consistent with what I
> > could test locally.
>
> Given that the relative timings are consistent for you. Maybe there is
> value to run the performance tests (e.g. only on the master branch)
> in a separate Travis job. Then we could chart the timings over releases.
> I dunno.

Sure, that would be a fine addition, if there is a way, somehow, to chart
the timings (keep in mind that Travis runs for each and every iteration of
each and every PR, in addition to the branch updates).

I do have enough on my plate, though, so I will have to hope that somebody
else picks this up.

Ciao,
Dscho
