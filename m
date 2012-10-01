From: Howard Miller <howardsmiller@gmail.com>
Subject: Re: "submodule" mistake and a problem
Date: Mon, 1 Oct 2012 22:16:18 +0100
Message-ID: <CAHVO_90pLFWb87mFfDpC1ZDQR=jm2YYFj597=kwVPTEv4AA+yg@mail.gmail.com>
References: <CAHVO_92=5u-i+-d__5k7Uoq5pF4iACq9GuBSj4U5MepbKV_jdA@mail.gmail.com>
	<506981C1.3030504@viscovery.net>
	<CAHVO_93d92Ert35z1popk+X8HAAHX_jwTVdRCjrhNHrhTsvx2Q@mail.gmail.com>
	<5069C760.2020603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 23:16:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TInLv-0003Er-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 23:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456Ab2JAVQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 17:16:21 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50668 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777Ab2JAVQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 17:16:19 -0400
Received: by ieak13 with SMTP id k13so13259175iea.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ykqyz2KZkmR9xyYzJ/rB2ovsKr6gvKFQYurEt8UfbSE=;
        b=MDW88JILZCusbWnIbJL60vJEEfJkrBYWJrvPmpEbKGk18nsCHZmofKSZP9atHa3LqE
         G04afzcS0PzEloNYbyQNG0H1ML+Er4KogKI4EtO4dTEB7GBrZd05CBcFqzeTr9XrtEgS
         TBuWUGlQV75wLY1MpLZ2ij1sSEt8pm0Y9tCAFfA0QHc6Cdk9XgOxvSJLqOHohLZCMKyZ
         8MF9HxWu/sRWL5i9u7raGr/zmRPrDGsJ7CH8jEphEC1W+3Cepf3LPfagqkNgJJr5XVDW
         QzADEAT45TEmgUgnB1K6Qg+wxU6i45sbmFktjcq5EON8uBjXPSPVmWw1OdYaLOh/Uxzj
         s6uQ==
Received: by 10.50.185.230 with SMTP id ff6mr7692145igc.0.1349126178583; Mon,
 01 Oct 2012 14:16:18 -0700 (PDT)
Received: by 10.64.13.110 with HTTP; Mon, 1 Oct 2012 14:16:18 -0700 (PDT)
In-Reply-To: <5069C760.2020603@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206769>

I was not aware of git subtree. I'll go and do some reading. Thanks
for the pointer!

On 1 October 2012 17:40, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
> Am 01.10.2012 14:05, schrieb Howard Miller:
> >>
> >> Perhaps:
> >>
> >>   git rm -f --cached path/to/subdir   # remove from index, keep files
> >>   git add path/to/subdir
> >>
> >> -- Hannes
> >
> > Fantastic.... worked perfectly.  I'll write that down somewhere for
> > the next time I do it :)
> >
> > Is there a better way of handling sub-modules like that? I've looked
> > at git submodules but just got into more of a mess. It would be nice
> > to push a project complete with a (git) submodule upstream but it
> > seems tricky or impossible.
>
> Git submodules are distinct repositories by design, so you'd have to
> create an upstream repository for the submodule too to make that work.
> But I have the impression that you want to import another repository
> into a directory of your repo, so maybe git subtree is what you want.
