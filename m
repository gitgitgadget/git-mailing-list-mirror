Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1331F744
	for <e@80x24.org>; Sat,  2 Jul 2016 11:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbcGBLJu (ORCPT <rfc822;e@80x24.org>);
	Sat, 2 Jul 2016 07:09:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:54889 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbcGBLJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jul 2016 07:09:49 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lqm3a-1bnQov2gCI-00eOCJ; Sat, 02 Jul 2016 13:09:43
 +0200
Date:	Sat, 2 Jul 2016 13:09:42 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #01; Fri, 1)
In-Reply-To: <xmqqmvm0vry4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607021306320.12947@virtualbox>
References: <xmqqmvm0vry4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LUl1yjWbr5qZUygn4+dIXPoO1eYhwZtUouazblwo+qdtrKf1t5d
 3KqXA3a5lU9J1AxRYonFtGIVjJHC1fRwGsE82DS+deKU307V3qgKeWYcaTxaVsHV5Y6GL1Q
 2d/5xnoLj4n/QVcQii0b20R2IGUMHvSENARSsAiPT+FsNPKIZZo7P6jEwecy4hHD+Q8VnXW
 LxGnV8qbikcXAYYb9TeKA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:6Z1cRDYe2yU=:p+34puZgP0DM3oE9foamPU
 xosR00bsOfkyrRt5QqahaqSbj2M96ZGpfD6hCRJ322gp5A/6+tw5KnZPyGVvpPM8IlIvToaL2
 U7roh78SbXm/oYOuTtMaj2Ww6XC0xfK4rJ5NRruiSm6e2UmnaQ//7D+okdoTpMqKwXeV9KR61
 wdT+Ht014KQCp7VY0BmDle3TwQ94v+ESTO5t+LstxwYeURUHGRtohN/Ea+HBCz4ViBf57YtqI
 9EjA9WSct5gIgyw18OBuex6zu3lQZzmkbXZ0eOrxOTCBG3UMvq9cMRnONHrjH0rRIacbOEEmR
 X4ty4lP+cbRXnrG/W9eXxdZm88vFB1Bv5aA6kgRItTcuv5SaPGawc3JoTwheUGVxDvV6ZJzcU
 t9/YwcfBotSVN0IJg+Pv263Ww9Arvlel6FjXtnpys3DnEMbGag2tKjTAmc2nDkfee5koxYTbI
 kTpSFyLIuu5U6pL/l9O6zJY7bExDzvUTxSwCskUeBMqdMmxOjIsSHAqZfsWydI6imM9O4+puh
 0K2ViuT1OKqNlijgLfAqclZYx2eHB01JHhoAOSsnklXwZqmjm+9bAaTCY3SGASJM6ByKKmdEv
 4L1xKdocQYqJDD+sVXRe6EKXwOtXt4utUnt9k2WImoPqhhdz2KaG2ReXd1cr3MWVfXxKXlvF/
 nsU68u2qrwbCtkqURATdg0Y2vI5ouT7Vn7ngteo0t2zkX51HTRimMMo2MAm0GgDjR1eLPmzAj
 jpHg+cCTMdadf8frHuBDAz1XE/mCluDtSEwhowzj55ZLEhFG9peVC62TiwhkcQd+eifGrIjCd
 KECidoL
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 1 Jul 2016, Junio C Hamano wrote:

> * jc/t2300-setup (2016-06-22) 1 commit
>   (merged to 'next' on 2016-06-28 at 62b902a)
>  + t2300: "git --exec-path" is not usable in $PATH on Windows as-is
> 
>  Portability fix for Windows.
> 
>  Will merge to 'master'.

Would you mind cherry-picking this onto `maint`, too? I just noticed that
the test suite does not pass here because `maint` has fe17fc0 (t2300: run
git-sh-setup in an environment that better mimics the real life,
2016-06-01).

While at it, it would be nice if this patch:

> * js/mingw-parameter-less-c-functions (2016-06-20) 1 commit
>   (merged to 'next' on 2016-06-28 at e673c65)
>  + mingw: let the build succeed with DEVELOPER=1
> 
>  Some platform-specific code had non-ANSI strict declarations of C
>  functions that do not take any parameters, which has been
>  corrected.
> 
>  Will merge to 'master'.

... also found its way into maint; This would make it easier for me to
backport fixes (as I started to rely on DEVELOPER=1 to warn about issues).

Thanks,
Dscho
