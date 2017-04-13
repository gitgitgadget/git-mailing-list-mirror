Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 181FB20960
	for <e@80x24.org>; Thu, 13 Apr 2017 17:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbdDMRZz (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 13:25:55 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34579 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbdDMRZy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 13:25:54 -0400
Received: by mail-pg0-f53.google.com with SMTP id 21so33535389pgg.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N9aPLppmDnEEgJR+nbSfG14vofhEoCoEafyimsPHzIY=;
        b=ehkC1seDpMwhrPx9O2YaD3VqLhfqZvC84+DUTr/r/wmHBxF6bbDYk/o9zITO+f4Lpm
         9I3v5/zBD+k4bnzILryghBlPuZrURm4a21o6EBVlia54Q2KNucRCOuQN5xKGZ6CT8OU8
         NORk0Q1NzSAyj2mx4qa2/fHymT80XtYK7BGkazAs+24MtKpRpov9b/SkeeKC7tXtwhNq
         zpmGyVa1PxQxJyz2JtACm7c60JSrjgRGbzp2XsOouOKe0c5XkQWKcOmlAoBOfgRRbIbT
         70sOfKPatkS3shzgj+AhA8BBsENHd9xbG4/zfSIAM4j29mjg4Ug/xWs7k9pXLOgOXNJ7
         vJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N9aPLppmDnEEgJR+nbSfG14vofhEoCoEafyimsPHzIY=;
        b=sYUWaPbwlFsAQp/AIOWJZr02uEz7J/7cThNr0cOsEVRaZUJ70aDelY+qXDvlUIWdak
         4CmzW5Ih6fNPAjTJUymsnoodQn4zjB0TEIfbPhZt1X1VL+4JP9JeRi5O33+uWRrwQ9Od
         v0OOanDFej2tAl6IfOKnLCum88s600BqMfzGQqFgn+bXrYRwNpOJmYtrB3TXhG7wjavw
         PwJj+Ay3Ae4SvKsxjVHWTSliGqVPa7ibBrtTe1cof080r+cDfG8Z5rwvVICdebkZwec4
         jo5zIVHb3wvJdeChBlvhcwU5hA7gnb/sVl1BApmGygXQM/KeTQJirDIRPJ7TP0eSEyk7
         6CvQ==
X-Gm-Message-State: AN3rC/6TBKRfk/X6KeMW7uhI7xe4+CctOHb/r9XkfJxHKwabtZfy19id
        cbmjCTmOjW0AnLspqqAVgok0UqokPLLw
X-Received: by 10.99.44.140 with SMTP id s134mr4168929pgs.178.1492104353239;
 Thu, 13 Apr 2017 10:25:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Thu, 13 Apr 2017 10:25:52 -0700 (PDT)
In-Reply-To: <20170413164045.19570-1-ralf.thielow@gmail.com>
References: <20170413164045.19570-1-ralf.thielow@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Apr 2017 10:25:52 -0700
Message-ID: <CAGZ79kYoiV60a7jK6vcESR2KfCLzxDwUpsPXCch0qkd720byyQ@mail.gmail.com>
Subject: Re: [PATCH] submodule.c: add missing ' in error messages
To:     Ralf Thielow <ralf.thielow@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 9:40 AM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

Thanks!

Reviewed-by: Stefan Beller <sbeller@google.com>
