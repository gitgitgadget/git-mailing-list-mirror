Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8FC20D09
	for <e@80x24.org>; Sat, 27 May 2017 16:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbdE0Q5b (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 12:57:31 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35910 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdE0Q5a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 12:57:30 -0400
Received: by mail-it0-f50.google.com with SMTP id o5so10517396ith.1
        for <git@vger.kernel.org>; Sat, 27 May 2017 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Sok3myqzXJRrVC7dKhdFh6phNErIkm169BNSzhEJO/U=;
        b=QfpMxGvqdALyDVgDvGgfxvXjJFbiJpoHQWcvjcq8mdvUHkwU/F8zMifM2MQF5vEvPU
         U1f55lejApteenzCIdZar9ATeSbqwzAlkTbAaT15xQJ0g62DLzq2SwPraUVipn/EADtu
         5QxyFlL1hRXXdu5VFSz9qW4mGQdbZKdCIMpsQh2EFAQ1fDWbxqs/av4mXLhcI4DYb23I
         HmlaSVMG6Aw8GPsMEpDRDWvxQt3GMvkyK7nWx5kMjJF6xR6NxHKhaZTKtzBOpqD+eRCv
         S6L1JH2LpsOPpMjKdw9a3qC8v16m1XGlyNlULFWZUhpShmqCSXaJGmbcdON6f1qgXIuw
         ygIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Sok3myqzXJRrVC7dKhdFh6phNErIkm169BNSzhEJO/U=;
        b=SzvMEIDCLxMxfflHWkCKXdSUsJOkJlqrxsjWeLOvB0chPSzAggpWKJsGfxaT9cnsdH
         tARteJFcPLHEBl1hvaypEzVACt06bF+JnSBx2cln4GdvumRcG+izqdWeg9NWd/YhRPSA
         hPtJipYkmYf+XeJWVltNa2/hRDMyoTksIIJHNBYvz6kBVVNlAsVWb9fLeu21W/tSheYX
         zaVi/AulCLU0JyQTmbJeFmOw9fgjvP9pQUfFifWu+xAcIgYZYH7kYvjZxXZJNm3CoFhM
         914jjXTG3a5KkkbqMaMBDjQzkxX56O+oeX7pP+j3r1ERPrBnIsKP5LiChfzgPBmITWK5
         gnbA==
X-Gm-Message-State: AODbwcCBx91dTsnLYw91+hiDpGnaCdRxrAh+p/QCMq1Ps3GNycKAq/QD
        ugzEmrTnc0Yzkn+zWkLPqqQ7sQbQfUD4mgw=
X-Received: by 10.36.29.150 with SMTP id 144mr1829046itj.71.1495904249250;
 Sat, 27 May 2017 09:57:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Sat, 27 May 2017 09:57:08 -0700 (PDT)
In-Reply-To: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 27 May 2017 18:57:08 +0200
Message-ID: <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
Subject: Re: git-2.13.0: log --date=format:%z not working
To:     Ulrich Mueller <ulm@gentoo.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 8:33 PM, Ulrich Mueller <ulm@gentoo.org> wrote:
> The following commands work as expected (using commit b06d364310
> in the git://git.kernel.org/pub/scm/git/git.git repo as test case):
>
> $ export TZ=Europe/Berlin
> $ git --no-pager log -1 --pretty="%ad" --date=iso b06d364310
> 2017-05-09 23:26:02 +0900
> $ git --no-pager log -1 --pretty="%ad" --date=iso-local b06d364310
> 2017-05-09 16:26:02 +0200
>
> However, if I use explicit format: then the output of the time zone is
> wrong:
>
> $ git --no-pager log -1 --pretty="%ad" --date="format:%F %T %z" b06d364310
> 2017-05-09 23:26:02 +0000
> $ git --no-pager log -1 --pretty="%ad" --date="format-local:%F %T %z" b06d364310
> 2017-05-09 16:26:02 +0000
>
> I would expect the output to be the same as in the first two examples.

This patch solves half of your problem, i.e. makes the latter
format-local case work:

diff --git a/date.c b/date.c
index 63fa99685e..469306ebf5 100644
--- a/date.c
+++ b/date.c
@@ -70,6 +70,12 @@ static struct tm *time_to_tm(timestamp_t time, int tz)
        return gmtime(&t);
 }

+static struct tm *time_to_local_tm(timestamp_t time, int tz)
+{
+       time_t t = gm_time_t(time, tz);
+       return localtime(&t);
+}
+
 /*
  * What value of "tz" was in effect back then at "time" in the
  * local timezone?
@@ -214,10 +220,14 @@ const char *show_date(timestamp_t time, int tz,
const struct date_mode *mode)
                return timebuf.buf;
        }

-       tm = time_to_tm(time, tz);
-       if (!tm) {
-               tm = time_to_tm(0, 0);
-               tz = 0;
+       if (mode->type == DATE_STRFTIME) {
+               tm = time_to_local_tm(time, tz);
+       } else {
+               tm = time_to_tm(time, tz);
+               if (!tm) {
+                       tm = time_to_tm(0, 0);
+                       tz = 0;
+               }
         }

        strbuf_reset(&timebuf);

There's another test which breaks if we just s/gmtime/localtime/g. As
far as I can tell to make the non-local case work we'd need to do a
whole dance where we set the TZ variable to e.g. UTC$offset, then call
strftime(), then call it again. Maybe there's some way to just specify
the tz offset, but I didn't find any in a quick skimming of time.h.
