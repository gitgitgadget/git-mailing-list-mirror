Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1029E20248
	for <e@80x24.org>; Thu, 11 Apr 2019 20:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfDKURX (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 16:17:23 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34646 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKURX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 16:17:23 -0400
Received: by mail-wr1-f52.google.com with SMTP id p10so9030114wrq.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5E1RMSxU23BSbso01P8uW1hdInp7LkqeGyEZr3G+Ovk=;
        b=LOR9d/0yJaORulZp7Tf+BnfooP2GkJtOQ3n5K4SlXlK1oyOyFDr7xiIxlJERMGZUAt
         CyPDvDrcst+yp7hXS4bcR9c0eJzKlKvdB5enjR6iXphZixNm/zKi4r1DI4YfpjmLbray
         er8lYO4r2RnoVotbx3uvoIQUiIQkmilXrJ9MFx1Czi0yhT/2zWUhy5SVdDxIDkKX6nZP
         u4TzdJ5clmVoPq0y8EyqJRKcewH4Ja9Z6WK3YJEmBYI6cciCoygy05IQAgjfZYXSITf1
         xGxTuc7UXn4Eaqs4MZeoYlOQO4rlVeeZu4nszmhCVJpUebFE/iBlAyqcli8deObi1Iqt
         GtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5E1RMSxU23BSbso01P8uW1hdInp7LkqeGyEZr3G+Ovk=;
        b=VA3BED6gOFDG1D4Wh7bUKAdh2RkdNSHaQzDaEA6+DUyMlK+rkiAtemtM2QqNUvNASK
         jzvdyDteXtfx3qc3laE7QoxYFjlIcWhhLfAnQmEiwICG35DTUOc2BDMOJUazdqPLLAl7
         66gUqZWs0iAwNwys/M9DwOjxUFKTMdsFcmqltbrZgb7xy3WG9w5K160/sdhL5t3T3Cc9
         d3cSvHtNL6bmimklTbL+Sk2AXQ+S9ffmQefFo8zb3PDqkqqGnIEXEwM1n3rsgho2VOXG
         HmRvcHqP0t4kKyhfjXyRyDIvpM2hKzve8Q0wm+4QG1WQKhUkedioNYFPpWTt2DiNM/TS
         E3og==
X-Gm-Message-State: APjAAAW+/sLoxnHdIgiDLSsREA6kq4BzfpKmOM5jDxbEJ4irizqWU+C6
        0+7X7FZ8oVQYKp+VmxDp0nLw0XH/
X-Google-Smtp-Source: APXvYqz2VMy63K1LCOz60p6JA+RgO0YeE4h1v5aB1f8QQbOmfK1/eOLcQibvVWRf/ho2oUjtB8C32Q==
X-Received: by 2002:a5d:458f:: with SMTP id p15mr32119797wrq.188.1555013841785;
        Thu, 11 Apr 2019 13:17:21 -0700 (PDT)
Received: from szeder.dev (x4d0c7202.dyn.telefonica.de. [77.12.114.2])
        by smtp.gmail.com with ESMTPSA id x205sm8949906wmg.9.2019.04.11.13.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 13:17:20 -0700 (PDT)
Date:   Thu, 11 Apr 2019 22:17:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Can Gemicioglu <cgemici@ccs.neu.edu>
Cc:     git@vger.kernel.org
Subject: Re: Bug Report for git apply
Message-ID: <20190411201718.GJ8796@szeder.dev>
References: <408662419.10955610.1555010182939.JavaMail.zimbra@zimbra.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <408662419.10955610.1555010182939.JavaMail.zimbra@zimbra.ccs.neu.edu>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 11, 2019 at 03:16:22PM -0400, Can Gemicioglu wrote:
> I noticed a problem when trying to apply a patch file that contained
> many separate patches in a single file.

To quote the first line of its manpage :) 'git apply' is meant to
"Apply a patch to files and/or to the index".  Note the singular "a
patch"; not multiple patches in the same or multiple files.

Use 'git am' instead, that is its job, and as you noted, it works.

> Trying to apply this patch gave me a "No such file or directory" error for one of the files in the middle and after looking around I realised this file was also created earlier in the patch. I tested this myself with these steps and saw a similar error:
> 
> 1. Create a new file and commit.
> 2. Move the file to a different folder and commit.
> 3. Create a single patch for these 2 commits by using git format-patch and concatenating the two resulting files (01.patch, 02.patch) into one (combined.patch).
> 4. Roll back to 2 commits earlier.
> 
> At that point if I try to use 'git apply combined.patch', it will
> throw the same no such file error. However, if I use 'git am
> combined.patch' instead it works. If I apply the first 2 patches
> separately instead, using 'git apply 0*' it also works but if I
> first try to check if it will work with 'git apply --check 0*' it
> actually throws the same error again.
> 
> I'm guessing there's something like a check to make sure the file exists that throws an error even if the file was going to be created by previous commits.
> 
> Tested on git version 2.21.0 on Ubuntu 18.04
> 
> Best,
> Can Gemicioglu
