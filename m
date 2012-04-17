From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 17 Apr 2012 15:49:59 -0700
Message-ID: <CAE1pOi2FQtyahcJUJ+CZRLLYN7vxGaOmUiBJ-_AfC-T-ZEY_Sg@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
	<CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
	<CAJsNXTmfRZvpO=ooB8yKUqGqbU4g5A78=dzt2vPPrs1q+J4ZrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: dag@cray.com, Git Users <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:50:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKHDu-0001lk-8N
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657Ab2DQWuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:50:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56874 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab2DQWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:50:00 -0400
Received: by ghrr11 with SMTP id r11so3414648ghr.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dhqbXf6kt6KqjDQMPjfmZ4a4jitSoXfxcmC7MXASias=;
        b=EnUpwaOBPF+yOYWT/FPE3n1QdiamSZ1LQ39Q6DdjwBU+0R28j/BG+wG3vM0BDv8818
         bxDa1ciPTxDHrCubOYFn8Kre7UfoMChYokKzpMMX+HX2heQSMUSGV6gK3J3y2WIWc1Rc
         6QC9GDZWKfycNFK1sLs2jwZQoIQHwAJHAWX6ULaVbDwoo4b9wKj9IXycSlzzz54LO4Bx
         A7ctO275PyOdpVAoai2TLfTSrb0q9LZWL3J7d0za0hWBmpsWIfjEelEJ502BRqIz5yQb
         1H2EGNhTD5QbpbaWjwDjdft0k4luDpIxTMpYBzctgq7K0LHy3ipsW1+j/4Wmat87N7fy
         +QGw==
Received: by 10.236.136.99 with SMTP id v63mr32565yhi.27.1334702999924; Tue,
 17 Apr 2012 15:49:59 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 17 Apr 2012 15:49:59 -0700 (PDT)
In-Reply-To: <CAJsNXTmfRZvpO=ooB8yKUqGqbU4g5A78=dzt2vPPrs1q+J4ZrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195824>

On 17 April 2012 15:25, PJ Weisberg <pj@irregularexpressions.net> wrote:
> On Tue, Apr 17, 2012 at 2:43 PM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>
>> I'm assuming that if you have subproject S in umbrella project U and a
>> branch "topic" in U then that same branch should exist in S. Any
>> changes in S's topic should show up in U's topic (probably after some
>> sort of update command like git fetch/pull). This should be unusual,
>> though, you should be working in U, not S. If you want to work on
>> something in S that you don't want to see in U, then you should not be
>> working in S's topic.
>
> This paragraph makes me wonder why you want to use submodules at all.
> Wouldn't a sparse checkout be a better fit for what you're trying to
> accomplish?

No, I don't think so but I could be wrong. I want to be able to easily
build and release the individual projects separately (manually and on
the build server). I believe that with a sparse checkout I still get
the entire directory tree. This just doesn't work well. I can make it
work but then I lose other nice features (unrelated to Git).

Basically, I want things separate for release management but together
for development.
