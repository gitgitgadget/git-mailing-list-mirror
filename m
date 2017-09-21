Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B97C202A5
	for <e@80x24.org>; Thu, 21 Sep 2017 17:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdIURxB (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 13:53:01 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:51462 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdIURxA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 13:53:00 -0400
Received: by mail-pf0-f173.google.com with SMTP id b70so3562883pfl.8
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ciE/AR5ziVHQGlQIictHgyvf6ip3+95wXfSTJJOMbgk=;
        b=nDzXzwsmnyRIk7EihpGM8WWt/vK1XOdeiygOdfMevuE3vvvl5Zm8HEJUb+ueCVigsW
         FRpjPgeHsynE7oy+wwYHEyqfFfwEx3MlmI+/9Wr5qKntf5TTm+J+c3DuCatdQHuOzAab
         8xYMms9AZz82LFoGN0yHgg8DC2Hqz/QNCpwjNv09qkrRcnn6pmGf6RNhQ75ZIxKsmE91
         q9siDoQBDyER/rLf+a18XM6fZaMuTNU6Haec7byhfUzA0soHrKv+poKefMPAg8xSrHB7
         yZTDdauM+IGLS0iUBl7OKHUH5pk94pcUFOduccKRybQPRrTC7GGAC/9VviPMTrdbT/c6
         IPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ciE/AR5ziVHQGlQIictHgyvf6ip3+95wXfSTJJOMbgk=;
        b=CodIi3aMdO1Cb4YEXI1RprsRwjRRgKYEBjDmLsvus11w5+OaXGntI7k+iD/4mHg1G9
         1yicfEDDr7oQvWQw5e8a4VDbnld3CkcwYmIX6STzbBuHDtq+5lbeoOqE0d7a8sIK20AU
         TTG1sFZbdV7WdhVh3fYk56ShT8+saZtdibGRjmznvXPJt/kMwlnWdJVUOvp3Mzn8RPRj
         JAIz3UNdWlLjapQ41aib8JTQelgEzdBojBKBbcdCj6lj7XHCfaseUEi5TCo5cR6HSL4O
         AlSMdMynHfcWl0habkY0OV8jOuTTF+3Qrzy2s2LbJSPHT2cVwQNa+EZZM0mGH3rUWohH
         5DdQ==
X-Gm-Message-State: AHPjjUgOPLfs1yLyqRPXfyLdbD9c79v2erm0hm+btRe8yRO7/5nebOLr
        bUUmUo40zy3EEjNSUA1UUwZuAA==
X-Google-Smtp-Source: AOwi7QCRmipdWfNj62emwou1S8BFjUOOH0jA/HsBUP8X1jqkHebvAvwDz7jPebnLT38b1ZFy82iywA==
X-Received: by 10.98.238.16 with SMTP id e16mr6365866pfi.157.1506016379893;
        Thu, 21 Sep 2017 10:52:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:e9ed:d044:a32d:2e34])
        by smtp.gmail.com with ESMTPSA id r11sm4526593pfg.180.2017.09.21.10.52.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Sep 2017 10:52:58 -0700 (PDT)
Date:   Thu, 21 Sep 2017 10:52:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] Document the string_list structure
Message-ID: <20170921175257.GA72184@google.com>
References: <20170921124338.26626-1-hanwen@google.com>
 <20170921124338.26626-3-hanwen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921124338.26626-3-hanwen@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/21, Han-Wen Nienhuys wrote:
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  string-list.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/string-list.h b/string-list.h
> index 29bfb7ae4..08b534166 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -8,6 +8,12 @@ struct string_list_item {
>  
>  typedef int (*compare_strings_fn)(const char *, const char *);
>  
> +/* A resizable array of strings. The strings are owned if

nit: the start of the comment block should be on its own line:

  /*
   * A resizable ...

> + * 'strdup_strings' is set. It can be used as a sorted array, and a
> + * custom comparison may be given in 'cmp'. The field 'items[i].util'
> + * may be used to implement an array of pairs. In that case, the
> + * caller is responsible for managing memory pointed to by 'util'.
> + */

The util field can be freed if 'free_util' is set when calling
string_list_clear() but yeah, in general the caller is managing that
memory especially if a complex free function is required (in the case of
allocating a struct with dynamically allocated fields to be stored in
the util feild).

Just pointing that out, and I'm happy with this and the previous patch.

>  struct string_list {
>  	struct string_list_item *items;
>  	unsigned int nr, alloc;
> -- 
> 2.14.1.821.g8fa685d3b7-goog
> 



-- 
Brandon Williams
