Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEFBF1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 19:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbdHVTon (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 15:44:43 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34957 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdHVTom (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 15:44:42 -0400
Received: by mail-qt0-f173.google.com with SMTP id x36so33523168qtx.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PkQrqI/jCTi9wwZdmJqNmcoOUtgb3LTJ6Fjga5czUEA=;
        b=XjWkju6BWw3HPeRVEJn7+8qPH6fWlBkiPGBo1c/n6ip/e6AeajBdPH1chg19fDJL4C
         nf9n6lUsYEHbT00pU9QSmjFFkqDlntHaMBMGi7qFJolHueW0V/vrgGaogrns27Jf+AGd
         7TDPncFaVGwYlIGGfsZ0trXUGLM9AxHWbiUbu2/S5F9H1nA6yCNI8jkFi31aPkhWnrEW
         K2xBf36R5P3U/gE+SInipThAB0387O3zX65lYmnEpDQBFI1vM+l93PwgTANt3lAT9icx
         BGkzC6CDgJwyvD99lYj9/ET9/FI86Uqe4W51AsIHLxprW636z0Kx0SwPJMEZvx0CFDoV
         ryPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PkQrqI/jCTi9wwZdmJqNmcoOUtgb3LTJ6Fjga5czUEA=;
        b=Q2Q9AF98oTGtAXWEKyBoq50KvY/1xmlhBYm3oTDw6S0A36yVDoofvVH+KYTFtI380b
         ztOSrUUzkCytv3LDYkxG3YP44rFxSukKIvqrVNjAYK9VS3kEBILi6qK5lLjNmbpfJgUZ
         5CQmpsw7SHf6edigaP5w9d+rp6UJGzhkxOVJN31UZXmFJkt9JRFjUnuy8l5zQsET7jfR
         oHqk5lYFd2nod/fb5tKrfanmKtovShefqZ+IFMD4ByxGOi4psUr9iOot9fCGjIB7UTyl
         4d/76ILRUWxvrF9byzKgi2cZV1JKYCr1ItQJ75qdlewj0cg/i+6FH/mHQPetECETfgZ9
         ghJQ==
X-Gm-Message-State: AHYfb5gn/iBe8t85H8UYTLGbWXT5XkLYKqAl2VCawczHisIqZAlRFf/a
        Md5DNPGNNECtKQ==
X-Received: by 10.237.56.170 with SMTP id k39mr350739qte.199.1503431082246;
        Tue, 22 Aug 2017 12:44:42 -0700 (PDT)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id m15sm10753945qtc.48.2017.08.22.12.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Aug 2017 12:44:41 -0700 (PDT)
Date:   Tue, 22 Aug 2017 15:44:41 -0400
From:   Ben Boeckel <mathstuf@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: Cannot checkout after setting the eol attribute
Message-ID: <20170822194441.GA25093@megas.kitware.com>
Reply-To: mathstuf@gmail.com
References: <20170822174918.GA1005@megas.kitware.com>
 <20170822191318.GA22118@tor.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170822191318.GA22118@tor.lan>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 21:13:18 +0200, Torsten Bögershausen wrote:
> When you set the text attribute (in your case "eol=crlf" implies text)
> then the file(s) -must- be nomalized and commited so that they have LF
> in the repo (technically speaking the index)

This seems like a special case that Git could detect and message about
somehow.

> This is what is written about the "eol=crlf" attribute:
> 	This setting forces Git to normalize line endings for this
> 	file on checkin and convert them to CRLF when the file is
> 	checked out.
> And this is what is implemented in Git.

Yeah, I read the docs, but the oddities of reset not doing its job
wasn't clear from this sentence :) .

> Long story short:
> 
> The following would solve your problem:
>    git init
>    echo $'dos\r' > dos
>    git add dos
>    git commit -m "dos newlines"
>    echo "dos -crlf" > .gitattributes
>    git add .gitattributes
>    git commit -m "add attributes"
>    echo "dos eol=crlf" > .gitattributes
>    git read-tree --empty   # Clean index, force re-scan of working directory

The fact that plumbing is necessary to dig yourself out of a hole of the
`eol` attribute changes points to something needing to be changed, even
if it's only documentation. Could Git detect this and message about it
somehow when `git reset` cannot fix the working tree? Or maybe it could
at least exit with failure instead of success?

--Ben
