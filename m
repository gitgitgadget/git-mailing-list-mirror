Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BD161F858
	for <e@80x24.org>; Wed,  3 Aug 2016 14:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbcHCOQx (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 10:16:53 -0400
Received: from mout.web.de ([212.227.15.3]:55551 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753254AbcHCOQw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 10:16:52 -0400
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MgOUY-1bsVq32PX4-00NkwX; Wed, 03 Aug 2016 16:08:01
 +0200
Date:	Wed, 3 Aug 2016 16:07:30 +0200
From:	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:	"jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: Making file permissions match
Message-ID: <20160803140730.GA2390@atze2.lan>
References: <CAKON4OyiG=ddx77Bn3h-YAh-3BYGd2rXPb9smwaooWxfBmtDKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKON4OyiG=ddx77Bn3h-YAh-3BYGd2rXPb9smwaooWxfBmtDKw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:3qWGD06RAS80YKxEjAz9SnCt31r7eS9h0IM8arV5WEL0cUZZYF+
 RPcGkrcO+N0L4vfYCgW+f5jluZzz47X5hRgslYmg+Ep5xNOOXyM5ZG1Wo77tPhmf4pR4V0q
 YzlhbBajnSJKgexoS4jKX13rDbZDX0u6UD/M2ESsp3W2BcO7oVcYxpvlDohTiCiniBbzT+I
 S7A72AZmHySfWPgSF5mng==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:vTxh1ELni+4=:clLThHbR3Pw3bnPHLJ1pu/
 JLntoT3Vdzba+7NIX2ZlSjmKo/U2f8N42aakIjd2BX9Mr1dbur8nxBRcXBdaHyt3BMF4xoIIY
 zStTE4qh3UW/6i35zhakMaDTKYdxSEcPz02ws8ZhZSolGQAf8whqVRBaLeOQ5y33GWSieEz4l
 Fkrsej100vZP+VvGgrsLhxbSyTgdEqmC1lRVmlfeXLl3H4J9f0a5kSM5cVkpzWOZ1NCmKrEl0
 ev9uBH3UoflrPV6g/AqxxTHCpLZRVquHYuOAb/2cm0tuupt+RvTF4eKXnKJ/UGrdh9N4eN29l
 rishElF1m9Z6gJipqXY0S4pKcU8tpoNYtfGYVdhKDMbWqwxBNRv5eiT8V/RLQXpM34N1x7bTq
 RLe+VbfRlA9VGQr619z6rljMdTtTMbxBKPyx1ivQ0I+or5Hop0HRK9za0mNYbg6bEcG52RTF/
 YtW2a9H4npQsFFNSXB5J0mLnrzDrb3liX2WDmn9iM22+qcGMQgHvwxbq2HYHEDM9J4zyrTvJ4
 Zq2ZvLaG0V1QdBjIFKCkTBsp3pCj1hIi93h+upm8js4Mnh/dcwPgRwfaKKzgdl86ERhb1G/li
 usSrfI88WIwFASkM+3b7qiSTiMZ0JNBh+fHck0QBb1ydO7yp9ZLv0XiKrrF0dHh329m3I4Kvv
 n1na10Tv/PjYCWgnOysnldjoEOB7Exw1SEm9sHwxn7mIoJ8GbVbyFof3nqGs3MOq+izPCHb7F
 C1nl73Eddns2zHZC483aU2xVxq4O7yHTG4s96BOoEkEG0YdCPAGiT8yERJo=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 09:46:06AM -0400, jonsmirl@gmail.com wrote:
> I'm working with some Windows programmers that don't believe in file
> permissions They keep sending me zip files of their source tree.  I
> have my copy of the tree in git on Linux with all of the correct file
> permissions.
> 
> So I unzip the archive they send me and to see what they changed. I
> unzip it on top of my git tree. But now all of the file permissions
> don't match. The code deltas are there but there is also all of this
> noise from the file permissions.
> 
> Is there an easy way to deal with this? I want to keep the code deltas
> and ignore the permission changes. Since there are about 100K files
> this is too much to do manually.

(I'm not sure if I understand "match" correctly)

You can ignore changes in the executable permissions:
git config core.filemode false

Please let us know if it works
