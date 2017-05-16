Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 277801FAA8
	for <e@80x24.org>; Tue, 16 May 2017 13:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbdEPNPg (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 09:15:36 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36381 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdEPNPf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 09:15:35 -0400
Received: by mail-yw0-f173.google.com with SMTP id b68so52551646ywe.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=BMvu778cnHH8olEyM921bvnpxPF/h6Rzhqyrb9/seSM=;
        b=MS3moWVXD5ulAOFP9gwR+b7oEWQTnuo6SgEHtqvKOV8aw4Qqx0iPuvrrhahRZ2JtBo
         5sOGG9rMTIOOB/LI+mOxEi1veMexnlI1gegANDMAEemyknGpRcz3DA5HFQ+DTWh5ukVp
         WrLzI56NcU6k9At6WXH3Bu/e3j1raixlhfhIkOrJ1NP3p1r38c88LeqCzQE0axRKAxkD
         K7ZF9NTB59hUx4dsCEI4IRqmGM10woEixDpUyxNjmzbaKo+FOVIdcTLP7619bS+PRKSJ
         JqPURVbxeLCrmJgYMXXyrFV8BN38aRf9yI8SGINp+1P5OPiKEtwGDyMUcDUrtgUqE4lb
         usIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=BMvu778cnHH8olEyM921bvnpxPF/h6Rzhqyrb9/seSM=;
        b=tiQsf/pauBCyd/BnsVkmRsMCjktAZfJt8uSRVQAl1+BVG3kuMdlLt0a7jxjWLPUl/F
         khovD85CT5hyT4UN46UsIDIiI9eC2gV03mhS/DXkLPt1H/wxv/A9MMFpYyAkyL4pn8Ej
         M++09hAKfqtgD6KZ8ENfWDvdAYRF5tuNDJSd2dG7tyDPU82AT6Mjf7KWxye/0LBVW+c3
         iG3vF07skYqam54u6FLTxCv75THUJx/ILL/JdE7B5Tj4HfCK52gN6DVmmgyfilfJ6cgu
         +f6eCutqKRVosGZuhMj/7kmQC74bnFZ+tp++SZWZJG6tFr92y60OkrNkdPS9HgFLtezc
         M3gw==
X-Gm-Message-State: AODbwcAcog+5hIPdCQC8tBtVq2oeTzeHuD16FNgHfk2SOzmhK2ZtQ+R2
        yR+1AfO7Om2hseZa4UufuUD3qGEDhz0e9tQ=
X-Received: by 10.129.166.18 with SMTP id d18mr9421606ywh.100.1494940534098;
 Tue, 16 May 2017 06:15:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.161.228 with HTTP; Tue, 16 May 2017 06:15:03 -0700 (PDT)
In-Reply-To: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
From:   ankostis <ankostis@gmail.com>
Date:   Tue, 16 May 2017 15:15:03 +0200
Message-ID: <CA+dhYEWyyK=L7mHuYhyEc78FDs4fksMBwgY6mAErfGRL3mzu-A@mail.gmail.com>
Subject: Re: CYGWIN git cannot install python packages with pip
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 May 2017 at 20:08, ankostis <ankostis@gmail.com> wrote:
> On Windows, with Cygwin-git 02.12.2-1 the python command:
>
>     pip install git+https://github.com/...`
>
> fails to work with the following error:
>
>     $ pip install git+https://github.com/ipython/traitlets/
>     Collecting git+https://github.com/ipython/traitlets/
>     Cloning https://github.com/ipython/traitlets/ to c:\users\username\appdata
> \local\temp\pip-kjwxq_oy-build
>     fatal: Invalid path '/cygdrive/d/Work/ALLINONES2/co2mpas_AIO-v1.6.0/CO2MPA
> S/C:\Users\username\AppData\Local\Temp\pip-kjwxq_oy-build': No such file or di
> rectory
>     git clone -q https://github.com/ipython/traitlets/ C:\Users\user\AppData\L
> ocal\Temp\pip-kjwxq_oy-build" failed with error code 128 in None
>
>
>
> Git-2.8.3 had no such problem.
>
> Any ideas?

Reporting for those bitten by this, latest working CYGWIN timemachine
release is on 16 March 2017:
  http://ctm.crouchingtigerhiddenfruitbat.org/pub/cygwin/circa/2017/04/16/142104/index.html
