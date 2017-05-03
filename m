Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F559207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbdECKWB (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:22:01 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34449 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751491AbdECKV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:21:59 -0400
Received: by mail-yw0-f175.google.com with SMTP id k11so82367123ywb.1
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eBkkD185fU5thn5iabzvm4Yp4JCrlJUZSzMGY8cQPFs=;
        b=d5C0T+HTqVJZmUzTCa0GW/OFW1vufo9gHF3oVp1eVJurdWLJ39MwPUD8RoBqPknCkG
         49wMFiPUIw+lSYrtEZtqsfmOLZ9rZ22r6/nO9qQhi4YElU2INXF5Y9qWauRUQrezxpPo
         j5X/sZQivjQ/7iA8d+nCPoNcChn2pOvKGnNqFd2LrmLATXF4nfj7geqdyj6ujx5E1uOW
         ah/TDSEW09iD+8b0jV15usKBqG8tUG7pwwNih0CIu0NLg0JQ1gH3cYebUFyb4CCc2H+v
         w3hmVMDDwJNBm4GQgfPU0fheoNIRgCcNKdwEZonHcGILq8c3+xjrLo7Llcl4MTj5jJRA
         7oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eBkkD185fU5thn5iabzvm4Yp4JCrlJUZSzMGY8cQPFs=;
        b=jXkyPdXJd3ORDBqBEvt+l0rtC6evZg8tDddTnw5YYOmspNQqxGOAI1vnZ+pvdsMWDv
         9CnTkbaNL7uamWkpZgGB0D9sqE6tQUG9retKnnpKN2xELqFsPgQ2RMLJioPX6QH+txG3
         S3jxLtsv5xaAaX0QoihmATg9UBTIBEWqmvCc65NIYeiWA/mwdDOKL6IN2utqeTDxpWWs
         1QNIdHGuPF/r2ESu/Z3PDrmhXFGbLLCDM5jNUuURMKdVMKckAxziXYPtL7wkQT4xUma8
         zbc8e8DObN152KWoU1QgedpCEh7hiEDcDo1vmWWV0JhPg2Lb+tILqZhNGcy9MOEoXZ+C
         ybEQ==
X-Gm-Message-State: AN3rC/5P7Wk5WRafwsOEMYrjKAGpHG6GRpjuYCJZ7ZrnV+XyDJNUpAH4
        Vd5U5N6oDFHB5hhrokuNPD5OfO4OlA==
X-Received: by 10.13.216.132 with SMTP id a126mr31102065ywe.5.1493806918119;
 Wed, 03 May 2017 03:21:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.161.228 with HTTP; Wed, 3 May 2017 03:21:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1705031147040.3480@virtualbox>
References: <CA+dhYEX+GgEHnVBnLQqnNW99xpf9kWcataTTt3Ya6ivGFgscMw@mail.gmail.com>
 <alpine.DEB.2.20.1705031147040.3480@virtualbox>
From:   ankostis <ankostis@gmail.com>
Date:   Wed, 3 May 2017 12:21:27 +0200
Message-ID: <CA+dhYEUCJghqDQyBrL71Q=JKokcH-nhQ9WZzBb19-gonxi7o=Q@mail.gmail.com>
Subject: Re: CYGWIN git cannot install python packages with pip
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 May 2017 11:47, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 2 May 2017, ankostis wrote:
>
>> On Windows, with Cygwin-git 02.12.2-1 the python command:
>> [...]
>
> You forgot to mention what python/pip you use (is it the Cygwin one, or a
> standalone one?). Intentional?

I have tested it on using WinPython[1] 3.6.1 & 3.5.3.
WinPython is built out of the "standard" python on Windows.

Judging by the error, the problem is on the temporary folder
used as target.  For some reason, Git uses $HOME
as a prefix to the temporary folder selected by `pip`.

My home in the above case above is this:
/cygdrive/d/Work/ALLINONES2/co2mpas_AIO-v1.6.0/CO2MPAS


Thanks,
  Kostis

[1] http://winpython.github.io/
