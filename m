Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42B71F424
	for <e@80x24.org>; Fri, 30 Mar 2018 09:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbeC3JCf (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 05:02:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:39105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeC3JCe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 05:02:34 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lngv5-1eL33I3sit-00huLE; Fri, 30
 Mar 2018 11:02:08 +0200
Date:   Fri, 30 Mar 2018 11:02:06 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        William Chia <wchia@gitlab.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Draft of Git Rev News edition 37
In-Reply-To: <CAP8UFD0wWiivjzJ29-RPVyOxkmbFACXTwHLyPrMdsUsW__RsYQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803301059450.5026@qfpub.tvgsbejvaqbjf.bet>
References: <CAP8UFD35QP0jwQ22jfUaNgo92o3vG8bV5n=iYnmn1ichxndphg@mail.gmail.com> <CA+P7+xoL6TRP0NZJR7gQrVeLoQwK_1D_iDmG18Y=_i=U4uttgg@mail.gmail.com> <CAP8UFD0wWiivjzJ29-RPVyOxkmbFACXTwHLyPrMdsUsW__RsYQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4akwoHVeWHakUcOpUQtt0fZevYdNSfnNuZBLhB94q1aU74UM0Ba
 bK8jjqUK/i4LgfKmI/J0ZanOHlQUQN+MoQTb1nlOrcwab6o+D8jr7xF/L4goAf0BqR4p/fv
 eGgvjgKQHu7L9anR74ywH2OMa7m9GuorR1PaYnnTV1Fyo88KCBXGffq+3JHBzIdX7AApumz
 1R21F1PEdQcMJ8Ryzqd5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bTke+oonAJw=:5CrQ88xDmpF1mW53qGz0ST
 cibYnfnq05RN6b0yeIiZmVDE2JVCCBLZ5KrmURW3pG2XTBmXY7hA8Kec2dbz5/jZCfZfejhOg
 gpsGq+rY/IEzQbLcI9Yad6b6ctuT1VgIkkbGAMK2/Ae5AwvV1gyOky6zAyjUl6iaTFBrkr7al
 1XhF7I+t28c2OuosETEeysa12Vksrp3RY2Bagx7/UBUYYJ+QvP6vAdGeWxDBZoQguSD9UGP0j
 CnlP1SEwctiJq373YP27s30oWZ1qGgb/eIkgB9J0WBavxFe4PjwuCKxBHAXTk82XICVh2A9CZ
 iPd5GP1nb4xmsRo08u0zd4Qzj8fL/XoZdZNtV5u0YV7ZenApkC/+lY1WSaDqOq+4b2qby5fkP
 jWTtm33vKNfJJKOEiBmse9YqVihm4rFH8p/M/oLqRniFtyirqHmixTThE7ZZRNE9B6+9yXNI6
 r+pkBSeoYpl+7K+OTa7CTrvL4IP1p5tFIDB1928nJ+UuiCYZYp+6mWrtFGAAiP23QBpYYh6ne
 LXQCkq+4khtYQlpfyqJHIhfXmiZ+Iu+Jgsd3T8mOtxJDWNy58cr7BSyyATbc60+NWw1v5+GIu
 n30h1EnTZVf/nCAPxjczWXluVNqRBh+N7yctn2KllUmhLbdtwAhoQNuoQPPAEb4tJ9hF6wJwZ
 P7lAvVi9+oGoEQHtLb7mo8DyQnY59YMgqvoNQVAfiuyXkFT5fQePQCVGLEjvgPAj+mJYDrOte
 aUbxE2JphTiA9tiPdcsfr7oeLT4vBeBpNM6DwRw5v4wktgSyrwEMsbzJjVUrHPHIQNPyZOYwg
 OVxTb3drf8GYktbNzZQmZEpATwhnqkGKetmhFEttFIS4CcNnHwNUogwxHadKHDaRyYPQOsR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 19 Mar 2018, Christian Couder wrote:

> On Sun, Mar 18, 2018 at 11:41 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > I don't have a good summary yet, but I think a section about the
> > discussion regarding the new recreate-merges and rebasing merges
> > that's been on going might be useful?
> 
> Yeah sure, we would gladly accept a summary of this discussion.

I would *love* a summary of that discussion, especially since it got
pretty unwieldy (and partially out of hand, but that part probably does
not need a lot of detail apart from the adjective "heated").

> > a lot of that discussion occurred prior to git-merge (tho it's been
> > ongoing since then?).
> 
> If you want to take the latest discussions into account, the summary
> could be either split into two parts, one for this edition and the
> other one for the next edition. Or we could wait and have the whole
> summary in the next edition.

Jake, I do not know about your availability, but I would love it if you
could take a stab, as I trust you to be unbiased. I would not trust myself
to be unbiased because (as everybody saw who cared to read) I got a little
bit too emotional and should have stayed more professional.

Thanks,
Dscho
