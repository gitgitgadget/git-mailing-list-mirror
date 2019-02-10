Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0417D1F453
	for <e@80x24.org>; Sun, 10 Feb 2019 22:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfBJWqQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 17:46:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55825 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJWqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 17:46:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id r17so13863887wmh.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 14:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V0+QWfWAhERF91WzSgrbjt6TL5jZwJzhOL7+V/EuAHs=;
        b=QtZ68f2AuIZlF3Hl7TTZ8avP39OCczlnG9X16TH65zWZd/02ljXjhGjxN5jfYgj2Hc
         Q0HsO1sp8f/OAiwdg1KkYC0TWlOwuE+U/HtKF9y7R02S3QcEs1/EOPBXdXNQEt3fcdvD
         24KmA5yRPfrLUeytXLhBpEYZ2n13A+YRKqNkZ2dtTbR3zB3TYhapR1LGUumsMkYpMWJo
         aorV2XDKjJTOocSwYgVQkXM6jvTqCq9M0q30VUxuJpPVuYHiaD3Gx8A7iXk2rE4+unYw
         Pv5clNUwTw537EbPoyVWdXYLxUL5ngEvwSV/dHRcvOc+YGN4xxiCcHv8ooZt5mT9/aYm
         2Zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V0+QWfWAhERF91WzSgrbjt6TL5jZwJzhOL7+V/EuAHs=;
        b=S/e4/LXIKKbg/0L12v6B5s6e6ZUUQpaF8hlVATA15ercspY8RqENu7pNjcZ3OZ3Dkh
         rqd6IhoQ/WtWhe7zhJ3xUkJtvMGlCpkYTcqAQDF4TzLH2GdrcDH1sDvnBE0L+IMHrP+E
         vG8R2i0tlgLUFdlfvFtwW9YYPn1578RofCXNjaQnn+B1eBG+gCe4g6b/3ltnzxP0mg95
         KRRVh4ldvegaSoX1Tl/PPCjX4TPYgMEbHX0u0LANhK+KAD1RyJquFpD2b+t6+LZwxUct
         oTQWWDSPVX7mi32elfuFz+P8NiNI3Ma+pO1zbgF85h/gZmKmZ5AyWKDdt/QLiYSO02u0
         TDLQ==
X-Gm-Message-State: AHQUAuZP62cO3RihsN/xeHOVwJxUVoVa9ZpI0BUZru+iiMmWPw70uKjf
        pREsgoWKfcMv/wW9kktGsi+CVO5KuQs=
X-Google-Smtp-Source: AHgI3IYJru4d66EcwVeReG6ZzLwEunKXsB5yNqCrARMcRE0XnpNHkDbfdBXmV3rn3XbTMyee3ZGU+w==
X-Received: by 2002:adf:f40d:: with SMTP id g13mr3307131wro.18.1549838773876;
        Sun, 10 Feb 2019 14:46:13 -0800 (PST)
Received: from evil.localdomain (host201-92-dynamic.60-82-r.retail.telecomitalia.it. [82.60.92.201])
        by smtp.gmail.com with ESMTPSA id s5sm8733106wmh.37.2019.02.10.14.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 14:46:13 -0800 (PST)
Date:   Sun, 10 Feb 2019 23:46:08 +0100
From:   Giuseppe Crino' <giuscri@gmail.com>
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        tboegi@web.de, angelomelonas@gmail.com
Subject: Re: Possible minor bug in Git
Message-ID: <20190210224607.GA118@evil.localdomain>
References: <20190202063828.4kjtdmrsm7g4eyg3@tb-raspi4>
 <20190206221759.338-1-g@evil.localdomain>
 <nycvar.QRO.7.76.6.1902072040360.41@tvgsbejvaqbjf.bet>
 <788eefef-f677-f0ce-7e02-dd85b11da78a@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788eefef-f677-f0ce-7e02-dd85b11da78a@iee.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setting `true` as the default for GIT_ICASE_PATHSPECS_ENVIRONMENT, when git is built on a Windows system, solves the bug.

	diff --git a/pathspec.c b/pathspec.c
	index 12c2b322b3..906cf24e3e 100644
	--- a/pathspec.c
	+++ b/pathspec.c
	@@ -237,7 +237,11 @@ static inline int get_icase_global(void)
		static int icase = -1;

		if (icase < 0)
	+       #if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
	+               icase = git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 1);
	+       #else
			icase = git_env_bool(GIT_ICASE_PATHSPECS_ENVIRONMENT, 0);
	+       #endif

		return icase;
	 }

Unfortunately that fix introduces a regression too, tested in t/t3700-add.sh --- `error out when attempting to add ignored ones but add others`.

I already spent some time to understand why, but got no luck: I have to dive deeper into the source code.

In case I can fix the regression, is changing the default value of that env variable a good solution? Should I change the approach?

Like leveraging core.ignorecase somewhere ...?

On Sat, Feb 09, 2019 at 06:19:11PM +0000, Philip Oakley wrote:
> The root cause of the issues will most probably be use of a case insensitive
> file system on Windows (and Mac). There is a configuration flag
> `core.ignoreCase` [1] that is normally auto detected that can be used to
> decide when the checks should be done and advice [2] or warnings given.

Thanks,

Giuseppe
