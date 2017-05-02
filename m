Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 015311F790
	for <e@80x24.org>; Tue,  2 May 2017 18:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbdEBSIt (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 14:08:49 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:34203 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdEBSIt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 14:08:49 -0400
Received: by mail-yb0-f178.google.com with SMTP id 8so36963845ybw.1
        for <git@vger.kernel.org>; Tue, 02 May 2017 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=im7psurlfsoXoJ2v5iJN/9f8FzZOl6GLPsUIVQIpUu0=;
        b=vYhC7QwpkKJClDwjAdvdypKufmzuhDqimc4lZZGKubf3MobeXgsV0giAcJ1y1gK5p5
         5EGwLX60vs40FZ1WTpX22UXbWmxr7ZjWmsM/uMftx/IOEQvejGotQ+vJyKSjC59YHxva
         46DrRAUOQ9VnIvkpHyhoGFkHV2fA7IQBYrAvi2keC2xECgy2Rjy670hWJY/qCr9ulPWf
         zwkdmM6+AZLrj33FAmVH5GnoTlxBaqVeBVmHROXho+KtIUKr1N9ORy/aioJqDXtHaUio
         TrA8u/vXtvOo3Tt1yI3jOOC74gPPazPEfI/Qc6C/Bu1Ba0J8wW/dUWx7dPbY0kzrgK88
         ad2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=im7psurlfsoXoJ2v5iJN/9f8FzZOl6GLPsUIVQIpUu0=;
        b=QZZdjjt+OJluhSbyUyxTeI71xKrxeI6ynJBFQIDC2nCd6HFtjsIRq1GGYS17klq3Y6
         mweaSjmgIgbOT8OuYEfgsKopgGiSaiKQwszrSEkXSgdr1Ez/7vq6s5/dpumjPmVBdytm
         DEUJZUBCcGAX1PlyWG+0nsuo3Uh7tRiN3Y8jBFeJaen0h9x4yQijcyaW6HpGUDqP5Mya
         uvwV6mcxtoofSYkQfhgYPmD3c/yb8AXHCLZF3RnzI43++GSckP3fDvakSvkT7NOqzdQt
         HSWLcd5Nqaui0rO3an51UVeg5jyypHpCQ34uWmv+BfwN6vVILLL0JJKPxmAVcojzJoA4
         luzg==
X-Gm-Message-State: AN3rC/7imowUyyIh1brTIndS8bDBNSHof5uOBzCBzHqOguy3t37kHC5t
        UiXixLhbM2KFUDzGJntmRYqf3xOLD0tH
X-Received: by 10.37.161.104 with SMTP id z95mr17462171ybh.111.1493748527934;
 Tue, 02 May 2017 11:08:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.161.228 with HTTP; Tue, 2 May 2017 11:08:17 -0700 (PDT)
From:   ankostis <ankostis@gmail.com>
Date:   Tue, 2 May 2017 20:08:17 +0200
Message-ID: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
Subject: CYGWIN git cannot install python packages with pip
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, with Cygwin-git 02.12.2-1 the python command:

    pip install git+https://github.com/...`

fails to work with the following error:

    $ pip install git+https://github.com/ipython/traitlets/
    Collecting git+https://github.com/ipython/traitlets/
    Cloning https://github.com/ipython/traitlets/ to c:\users\username\appdata
\local\temp\pip-kjwxq_oy-build
    fatal: Invalid path '/cygdrive/d/Work/ALLINONES2/co2mpas_AIO-v1.6.0/CO2MPA
S/C:\Users\username\AppData\Local\Temp\pip-kjwxq_oy-build': No such file or di
rectory
    git clone -q https://github.com/ipython/traitlets/ C:\Users\user\AppData\L
ocal\Temp\pip-kjwxq_oy-build" failed with error code 128 in None



Git-2.8.3 had no such problem.

Any ideas?
