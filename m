Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F9841F731
	for <e@80x24.org>; Fri,  2 Aug 2019 12:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfHBMG4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 08:06:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:38309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbfHBMG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 08:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564747609;
        bh=xS+kvmhyYRjdkxxBA+MZeqAlL5o403ndmbDEm7SYuXk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CbqH/SaarWpibubYqWuKajAVIZS3/tZI7TTwvEujAh9n2ddkqsFSqbIhWgMrpRyXy
         AxBykmwAIjT61FkLUjVIJFmh5PYD1j7V3sOQW8jmD+pBzMUV8lBwq+X4BYFLWLYlOw
         YaZWE6yyXjf3mVVmgy6vJcRQy/pyah3J7AtHGx1c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MC4VE-1i2Hm51cy8-008t22; Fri, 02
 Aug 2019 14:06:49 +0200
Date:   Fri, 2 Aug 2019 14:06:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/visual-studio, was Re: What's cooking in git.git (Aug 2019, #01;
 Thu, 1)
In-Reply-To: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908021405450.46@tvgsbejvaqbjf.bet>
References: <xmqqv9vgmz2f.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nmHt5xyx4R6ds83ZCGJaZyWCC1xbU0/nahkzH7TAABf/xXGOKdb
 SSceCw+zLNHcIaUDvBV2OlwSL/ASrQckoKijHukKFLOsLIRYomxrAYy++i1XNBNX96a9IgM
 s8iOOQSWf38JmUN11v/rDzuehcvogF+MWN1l4QVz0Ule6e/v2M3zPvqHVrD/4kSXuUVFBCM
 jdz0oyeCUQNq09HxLXWVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VZ6aHsnrhlE=:hcbKtPQXD6kL2TDID+VcoB
 gN/KhfjkkmY8WwBTVEoCpWWNRP//WqF/vWFKJKAqQRcNwrgwHk44FafZQB31QWDosQL0IOQTM
 b9tdlL3XF4zDYCSIjEl15D7a09gODBh/aFiiqSMG6FOpmr08ltOj6GPPJ+hj0kmR9WyUpcN26
 kik6wJiLOKYbAmvZm33NKOkFMq24PwQNjTFwc5mPU6gSyHRO87Q64Z1nXxZWX/G2CYhrQQSPt
 PsORsQ/gHFrzEFcFgriUTrIq6h71/XTRNMVyfHc0oB1rFf0Bh/zsygJSMW1UpxaULMZ7N1111
 5LE0y8KJbb61qzYvPJ4z4POYc7DkjR1cTBDoUg2q3LePRbZoQQvjarvBODY2aLZ8dtpB8mLVD
 ZorfVkrHWz3XUeaH1dFihlnHpb681qo55rF29HRA3F1dvVAgXwBK5frUn24Oj1q2YYMePwHmH
 YPIvgIjFh47acdwEq2tGeW/yKXU0cieUpjy8rZwFgoIY2f5VeAR6dBW46EXuw2c/A7DEh1cb/
 gWx4M1BYofdGzMWeGjcuk4nE2lsAGVBr+tI7Ppbhr63WUEvVNwgKe7v3L6r+0/MzRF7gGcmEC
 RjQMiZhSELXeAG+sWPPtFqCBJx128ZiDGKqTFihhwHj0nhZK3qCZ+FOpbhXwbPE0HdrSV3G0S
 4manvEziqCYViKOeo5tjF61U30s3CZdjBL8EePE3tvBxU3N159hEj/1J1NAEZZ+c7HqZXWHZ0
 KNjzO0d7ix+SIsZmAqZs9K/FZ/ioziZi7max3zrqmg2zmJH7934nprklRsY5tRLzbeD9bjldo
 RmDD+B8bngWd7sykFb990xjULgBFC7x3XzXgTky+eX73IKu0UzPKyEGNoTJf46+6m58+1Frs5
 cUIk4QBJzr+stH2A8oEFK0Hh4Vf3iMiqKA/9s+1M7zxvtd6XzZUY7T4eZnOuBY5P92Cz1+QcX
 VsldAx1d4fcBTvzjsuN890W9C72BCHk92IDBvMUEKoIpi0Wy38FpGbZoN9GIcmOwPyhA55SPH
 kMN5SeOgnItFNM+HeGBt+OvZRSMoM1oAlJs3hzM1CPQiZb0LSJSBN2gEIkHKOiFrl+QPfNHLh
 y17yd4NGZQQonXSnHREVcjR2RLFnD/Q0BEfrBHTN3mMhtu6Rj49MR+QY4aenW9jvI5tDwkwy9
 XyR3U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 1 Aug 2019, Junio C Hamano wrote:

> * js/visual-studio (2019-07-29) 23 commits
>  - git: avoid calling aliased builtins via their dashed form
>  - bin-wrappers: append `.exe` to target paths if necessary
>  - .gitignore: ignore Visual Studio's temporary/generated files
>  - .gitignore: touch up the entries regarding Visual Studio
>  - vcxproj: also link-or-copy builtins
>  - msvc: add a Makefile target to pre-generate the Visual Studio solutio=
n
>  - contrib/buildsystems: add a backend for modern Visual Studio versions
>  - contrib/buildsystems: handle options starting with a slash
>  - contrib/buildsystems: also handle -lexpat
>  - contrib/buildsystems: handle libiconv, too
>  - contrib/buildsystems: handle the curl library option
>  - contrib/buildsystems: error out on unknown option
>  - contrib/buildsystems: optionally capture the dry-run in a file
>  - contrib/buildsystems: redirect errors of the dry run into a log file
>  - contrib/buildsystems: ignore gettext stuff
>  - contrib/buildsystems: handle quoted spaces in filenames
>  - contrib/buildsystems: fix misleading error message
>  - contrib/buildsystems: ignore irrelevant files in Generators/
>  - contrib/buildsystems: ignore invalidcontinue.obj
>  - Vcproj.pm: urlencode '<' and '>' when generating VC projects
>  - Vcproj.pm: do not configure VCWebServiceProxyGeneratorTool
>  - Vcproj.pm: list git.exe first to be startup project
>  - Vcproj.pm: auto-generate GUIDs
>
>  Support building Git with Visual Studio
>
>  The bits about .git/branches/* have been dropped from the series.
>  We may want to drop the support for it, but until that happens, the
>  tests should rely on the existence of the support to pass.

As of v2, the tests rely on that existence again.

Thanks,
Dscho
