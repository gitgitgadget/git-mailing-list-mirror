Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF2C20988
	for <e@80x24.org>; Sat, 15 Oct 2016 16:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753255AbcJOQMr (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Oct 2016 12:12:47 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:32910 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbcJOQMp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2016 12:12:45 -0400
Received: by mail-pa0-f49.google.com with SMTP id vu5so53831770pab.0
        for <git@vger.kernel.org>; Sat, 15 Oct 2016 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LmqCTtfZyDj4y7hJIvpAoOkETtA7s1yCbbLSDwpjnpw=;
        b=HX3t1iOzf6Rb0oecI4/NSbtqgE3SeJO9Bp4/bA7b4ndrccIV/CBEiyRb+DFBC1CWYc
         yKwXa34w8EzvWSM9UPhTPWHKmT3aUtb5wbmd4i99dm+vwxkiQXDvS5RNX84/7gJqotMF
         N8C5lunAYV9p/RMyeVRA+qk+7FhuVPoG7oEd8n1pPOC5SzIPf35Nb/ogteVUcqf6sh08
         Z3QjPWYRb1hxUqaFlisUHuODPA8CQLbt4YECrMq8Q6OlyhunA5S+lGhthiy4430Pjkdo
         Zryg6DxozlRkjgUMwxZhFlMgiXeDihRQAiM2zem5id8eM6Pr3UQCi4HcltzV8mqPLHW8
         v6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LmqCTtfZyDj4y7hJIvpAoOkETtA7s1yCbbLSDwpjnpw=;
        b=CO3CemTJA6rkfLexaCaCxIWsu9W0KvPh/gGUsDb6z+bdM5ttaLolzfZSWj9aN6nPOl
         oq4uJyhYVIc/bEaPzCqVqzU2uoUWA8ePYirsNlR1MVwwVmXFtliANmyWF3aA66jj50DI
         uqzom/eUOj0V+jtNGeetAp+x0200NW/43vXzV9Y9T4RWfr+HrDLr7RoBd6qTiAyCmvxK
         DXtopGK8YiM+uRmakPUlz/lUln6cL8IZNfTOC/CyL8+AMGpyA8UvKZjLzEilIl/klO97
         wZpCqufJBC6W9sphiQrm3ibzoBDc8EIihxKRnWhqe7y+kQkwFegCstVUKkmNr3dWS9Kl
         TAwQ==
X-Gm-Message-State: AA6/9RmwFkkcQ1FkcraALaYy/5rqA9w0jZBi4pxpH/k6Jf5uXgHWSgGaWkKOKrPSB5iU1Q==
X-Received: by 10.66.50.40 with SMTP id z8mr21897359pan.109.1476543948782;
        Sat, 15 Oct 2016 08:05:48 -0700 (PDT)
Received: from mtl3z26wz1.ads.autodesk.com (adsk-nat-ip11.autodesk.com. [132.188.71.11])
        by smtp.gmail.com with ESMTPSA id q12sm13468498pfd.7.2016.10.15.08.05.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Oct 2016 08:05:48 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] convert: mark a file-local symbol static
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
Date:   Sat, 15 Oct 2016 08:05:47 -0700
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Oct 2016, at 16:46, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> 
> If you need to re-roll your 'ls/filter-process' branch, could you
> please squash this into commit 85290197
> ("convert: add filter.<driver>.process option", 08-10-2016).
> 
> 
> -void stop_multi_file_filter(struct child_process *process)
> +static void stop_multi_file_filter(struct child_process *process)

Done! Do you have some kind of script to detect these things
automatically or do you read the code that carefully?

Thanks,
Lars
