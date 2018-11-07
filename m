Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E071F453
	for <e@80x24.org>; Wed,  7 Nov 2018 11:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeKGUt6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:49:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:59915 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeKGUt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:49:57 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbaS9-1g442l2H8X-00J52k; Wed, 07
 Nov 2018 12:19:58 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbaS9-1g442l2H8X-00J52k; Wed, 07
 Nov 2018 12:19:58 +0100
Date:   Wed, 7 Nov 2018 12:19:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <CACsJy8D47sDgdpmPSqVbBu7Omc1=4yAn895-PE91-PLs9+83bw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811071219350.39@tvgsbejvaqbjf.bet>
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com> <CACsJy8D47sDgdpmPSqVbBu7Omc1=4yAn895-PE91-PLs9+83bw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XKNLGNOHXCCT4cepBoT4KAp44LlMgz5C9UqqtDzhNNbPbjJosXB
 rDfgWdzgKOoucHhHlaVmkOursvhW2qVq6jxIvZhKT5dm4WK26rQhC6h6Pp+JClat2O7ygXW
 0Zr0rz0FDoz8FtxYHaV8zm+QQkgmzPg8FaGiXpADxedbQHXo1Et/8dT22oUg3WGDMnq3WJj
 mdCBrajV/1NqMVHnEfxyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I4wCDVqtSb8=:ictkF2th0cW6CpSYaJYo3P
 +LCiN5Ft4AXfGRkZcDVAW8rWiz8jlgYsBX7/5w+XeHPSqtned+ja2PmMAB35tOlIYQKAwD6c3
 8j08uCDW6kR4ios5sHHNBkolNPv3hX+J5FMChaxgoNOrmVgJ57qnG25+Ffo+FlBKPFWgCeVFr
 shCYWdEfZpamUMQh72mnmjGgnCwZdpFAMBk6njJF9KhxeyiiMXVQSroUz5sMMyPvrvb+L9nlg
 CtyG2TQHwfVyGilw1jTC/FhhWRsJGOUDR+MC65LeNTIwi+MEHJcZRY8JBMicGjTrQeXYK2Zsz
 Vt5ZI4DYRDg+oj12xpXDHm7eYyMhw/M5uwMCOHO1M1RYbUcW1wGTRIDNcri253n0R3vYw3Mj4
 /Upelpfe5ER1thqNlm2UY+oz92oa9uar4a3W9ad8ppF+BmAUDnTW2EV3FRegaoXvD3xBVZ1ok
 8TAwjXYXE7CxZ913Ab5MaV293cccaWQQ02PqI/ffQbip/deGzVETFzxixX3Fs9vsL45/8DTRv
 weAYbmlSX8woTGazq4a6U/pfikF2PbUCmSiYwUcOtcLQNc8pMjelaqAW44zRBd9byY7KP23Qb
 T6xWXkwTUChmcDhBsjBk6vFDCs4/s63k3iigenCEcv0MOYT9LQcG5rRLayjx1TKulhkkeCssS
 eA1+vUcVct6G/PuJxnsBr8Dy6fmNDMSiAZQfOHQdd8kKxMroCgggivGhTOjpClmfwqwHG3ssZ
 K1U6YVfMhzCib3Cxi4IrR4vuHsUmEPwwotbaSO9PyVEXsFMxCb3lZm/Iuc+LrGarTWtOYlvE9
 s30j8QZ9crQTgCiCLUFi6lpiuIYr4cjtGT7Fd0xUu3C4TNJqWE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 6 Nov 2018, Duy Nguyen wrote:

> On Tue, Nov 6, 2018 at 3:55 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On Windows, an absolute POSIX path needs to be turned into a Windows
> > one.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  path.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/path.c b/path.c
> > index 34f0f98349..a72abf0e1f 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -11,6 +11,7 @@
> >  #include "path.h"
> >  #include "packfile.h"
> >  #include "object-store.h"
> > +#include "exec-cmd.h"
> >
> >  static int get_st_mode_bits(const char *path, int *mode)
> >  {
> > @@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
> >
> >         if (path == NULL)
> >                 goto return_null;
> > +#ifdef __MINGW32__
> > +       if (path[0] == '/')
> > +               return system_path(path + 1);
> > +#endif
> 
> Should this behavior be documented somewhere, maybe in config.txt?

First we need to find a consensus how this should work.

Ciao,
Dscho

> 
> >         if (path[0] == '~') {
> >                 const char *first_slash = strchrnul(path, '/');
> >                 const char *username = path + 1;
> > --
> > gitgitgadget
> -- 
> Duy
> 
