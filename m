Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CD8201A0
	for <e@80x24.org>; Fri, 12 May 2017 00:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757266AbdELArf (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 20:47:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34827 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754998AbdELAre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 20:47:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so5028332pfd.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 17:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/YdiTn40gyG9UstZltN66CPRZ5NlCXx+l1XRGlsjfq4=;
        b=tQyfNdO5jKTKiY0Z0/ZlPUbEdiCjWq/Bxlt4yV7uAnAU8PoVLcegWxZzaRkTSPplru
         rdqP+DIxTC8poLnCFy3qOKw+d4/SPCvcXV/BxrQvySvZVmPFUeOvfi8K7wSQMEeYbCIv
         cEBMiRkvzHeJOl0V6grUqdF3FDXcUptBd+SqFld8OQBWNMqx6BACkrkRH2IZxhHqJcAE
         HnavtYRn+3MdBqqzFIa7TsX/Vi+N/+b9QDdu9op8p9u402TBAUrZPiXqmoKO5wYiz7+I
         xv2SpIYkXCXT0yyv9UN3st41ai/42On1aPQcFYgwhG6FqbAumn7El52DApZyVKeFZfv8
         BU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/YdiTn40gyG9UstZltN66CPRZ5NlCXx+l1XRGlsjfq4=;
        b=emrnqhSlc6AFWTeK7wB7Flf543veZPDyqAbTLFft68cqGOLC3bVEGDuyW+JJny2dkY
         x68E8iXTYGzr+6b0dmlmdXvFNYuwPkVwBlJ+QQktddesrkwnH3LfRajW9J9yn+yDgVTa
         hq9a85JEXIdce2KEbhxox9hF2Vza+//8UVn/uxNa9Q49hsG5oKEiTcifArhrv+WrwQyQ
         DJCrTw988U97Zen8XkR/qAIpfldiCfeGiVaEI+QT489m9Sb9q+r47BrBId9ocnoLOGWz
         jd8l9bJcHfTS8P/KsnMXdJv53rPtvlELVxSEkNRVei2DdopNyCy9c6kJbmQRvWUoBb0w
         lBoQ==
X-Gm-Message-State: AODbwcCopzAQhJuLYNJUrpxxmacIzslMeaMvPa66lwmkPrf/BZsU9Fyc
        lNkZRDUuE2qhfg==
X-Received: by 10.98.1.134 with SMTP id 128mr1434270pfb.199.1494550053227;
        Thu, 11 May 2017 17:47:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id x5sm2150409pfi.94.2017.05.11.17.47.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 17:47:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>
Subject: Re: [PATCH 1/7] compat/regex: add a README with a maintenance guide
References: <20170504220043.25702-1-avarab@gmail.com>
        <20170504220043.25702-2-avarab@gmail.com>
Date:   Fri, 12 May 2017 09:47:31 +0900
In-Reply-To: <20170504220043.25702-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 4 May 2017 22:00:37 +0000")
Message-ID: <xmqqwp9m99zw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/compat/regex/README b/compat/regex/README
> new file mode 100644
> index 0000000000..345d322d8c
> --- /dev/null
> +++ b/compat/regex/README
> @@ -0,0 +1,21 @@
> +This is the Git project's copy of the GNU awk (Gawk) regex
> +engine. It's used when Git is build with e.g. NO_REGEX=NeedsStartEnd,
> +or when the C library's regular expression functions are otherwise
> +deficient.
> +
> +This is not a fork, but a source code copy. Upstream is the Gawk
> +project, and the sources should be periodically updated from their
> +copy, which can be done with:
> +
> +    for f in $(find . -name '*.[ch]' -printf "%f\n"); do wget http://git.savannah.gnu.org/cgit/gawk.git/plain/support/$f -O $f; done
> +
> +For ease of maintenance, and to intentionally make it inconvenient to
> +diverge from upstream (since it makes it harder to re-merge) any local
> +changes should be stored in the patches/ directory, which after doing
> +the above can be applied as:
> +
> +    for p in patches/*; do patch -p3 < $p; done
> +
> +For any changes that aren't specific to the git.git copy please submit
> +a patch to the Gawk project and/or to the GNU C library (the Gawk
> +regex engine is a periodically & forked copy from glibc.git).

I am not a huge fan of placing patch files under version control.

If I were doing the "code drop from the outside world from time to
time", I'd rather do the following every time we update:

 - have a topic branch for importing version N+1, and in its first
   commit, replace compat/regex/ with the pristine copy of the files
   we'll borrow from version N+1.

 - ask "git log -p compat/regex/" to grab all changes made to the
   directory, and stop at the commit that imported the pristine copy
   of the files we borrowed from version N.  These are the changes
   we made to the pristine copy of version N to adjust it to our
   needs.

 - cherry-pick these patches on the topic branch; some of them
   hopefully have been upstreamed, the remainder of the patches are
   presumably to adjust the code to our local needs.

 - make more changes, while still on the topic branch, to adjust the
   code to our local and current needs.

 - once the result becomes buildable and tests OK, merge it back to
   the mainline.

This may break bisectability, but I think it is OK (you should be
able to skip and test only first-parent chain, treating as if these
are squashed together into a single change).  The patch files your
approach is keeping will become the individual patches on the topic
branch, and will be explained and justified the same way as any
other patches in their commit log message.

Having said all that, since I am not expecting to be the primary one
working in this area, I'll let you (who I take to be volunteering to
be the one) pick the approach that you would find the easiest and
least error prone to handle this task.

Thanks.
