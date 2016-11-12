Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338252021E
	for <e@80x24.org>; Sat, 12 Nov 2016 18:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966660AbcKLSR1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 13:17:27 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38285 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966447AbcKLSR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 13:17:26 -0500
Received: by mail-wm0-f43.google.com with SMTP id f82so31896140wmf.1
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mqnyGTZV9sE9iRSRs/Afz8Bx8vYXQaxLVtAw0+IXsK8=;
        b=2AmLjtIH2lMhsIDH0z3Dz8zkiClFr2VRgikkuCpvweS3nnxNMqhgg8AAkiJCERn2B/
         gWN0Shgs9lsxtmDviRe3d29diSB0RLeruUqWuXQeTazxM4dZhJ8R2pM7a9fFuvwene+I
         9RkKTUbxvCiVwM+pL/ED9eGE7NJUmqCwqUxV946DiPwbalVCXcc4jMdHevUKGeIhduAJ
         IIa+AFOlL09Nsi/SyeF3S+B6zA7v58A+K5kdf+8juXqBHWT+0Bc7KX3NOcSw2xTIUR0I
         zYlJn0bFYUa5v72VCBNskfaG/h+1SIicvb1/jHoRLU9Or/TTQtWpITeYL5ulrp4Aa+QV
         4acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqnyGTZV9sE9iRSRs/Afz8Bx8vYXQaxLVtAw0+IXsK8=;
        b=XDrF69f50xruX0opd/lILeINkRMW+mm9vie6WCug6CCiPkSzeWU9gEl3O0PPjo5MnO
         1GeG6ZFPgfSQCf7HaFPC6JAlnWDKbbhV5S9++Z0hplr9PVQiVKxTwcTYPKsUd+rFMwx1
         2sNmQw9iQc2DABaY4xdWFRdLs7RBQfCVUl6w3thziH6mrljnZE7ZdF25FMnAPpVi46DA
         tQqnCXl7wsQHJHUttbVclkaAoEKEWctDZ2/HYXrL86Ng++xSXLJRJDb+XD2n9ZvvDzJQ
         yCmYAFfd6v21Xqo9KGcH3Oz7TImhBw5AutVjRYh727/U7eyXKI4csAR+WkvW1lgwbo48
         ytMQ==
X-Gm-Message-State: ABUngvfYQjC2nO0btplGq52GBgPcJdhSfaALNjb7+cKkTbPfokESfvTh9aVc/6vC1OPVBg==
X-Received: by 10.28.183.215 with SMTP id h206mr3560806wmf.60.1478974644687;
        Sat, 12 Nov 2016 10:17:24 -0800 (PST)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id wg8sm13500574wjb.42.2016.11.12.10.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Nov 2016 10:17:23 -0800 (PST)
Message-ID: <1478974642.3227.4.camel@kaarsemaker.net>
Subject: Re: Feature request - show result of URL rewrites
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Git User <git.user@mailfence.com>, git@vger.kernel.org
Date:   Sat, 12 Nov 2016 19:17:22 +0100
In-Reply-To: <284668531.626.1478972994238.JavaMail.root@ichabod>
References: <284668531.626.1478972994238.JavaMail.root@ichabod>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2016-11-12 at 18:49 +0100, Git User wrote:
> Hello
> 
> Hopefully this is the right place to submit feature requests - let me
> know if there's somewhere else I should use!
> 
> Git lets you rewrite URLs using "url.<base>.insteadOf"
> 
> https://stackoverflow.com/a/11383587
> https://git-scm.com/docs/git-config
> 
> Can you add a git-config option to show the result of this rewriting
> whenever this occurs, as debugging more complicated rules can be
> difficult/wasn't obvious without Wireshark.
> 
> E.g. you could have the option 'url.printRewrites [True/False]' which
> would print the line "Rewrote url 'git://github.com/git/git' to 'http
> s://github.com/git/git'" to terminal/stdout  when set to True.

Such a configuration would be superfluous, the GIT_TRACE and
GIT_CURL_VERBOSE environment variables already provide all the
debugging information you need here.

D.
