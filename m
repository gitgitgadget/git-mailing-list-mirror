Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07156207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbcJDFxB (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:53:01 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:34100 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbcJDFxA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:53:00 -0400
Received: by mail-yb0-f174.google.com with SMTP id e2so57878307ybi.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VDr4wfkxw2apemCvk6jSuAc00EjbXQ93pONPX2Jedvw=;
        b=rHa7EBoHpYtB484p/+Rjt9GJY4jwO9ddIcoTVibndzLnTw7xUpPMVayJVPh+tR8geU
         Qh7tFmwE+DpVDMdI5R8pV1wvCT6CFCbLcFUTaiHVPTumsq0CJIDOCL7FVPr9jmXb/f31
         9JpzuGLCuGe3tl3pDRpZweRRSuT9b3s/tSX3IgRVFNoxP3jZHn/l20R0DZEiwGesLTBo
         Cio6S7UWT/sPLCjUke6Oa9Jc1p+hIVl8CAJhTMlkSXvF4psMzn1TxxS40y937FgNcuwA
         7BsCxtbBmBXCE3GhGEBt2V/mF9FKcW7YMAemA+p8z2RHsiYWt5F0jgzogXnIdFlML0DO
         A9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VDr4wfkxw2apemCvk6jSuAc00EjbXQ93pONPX2Jedvw=;
        b=GeIdf17DanKaBHSkE/apnlfptGTM4AOIKdyuJYX7cOZq56SGoi4LCJH5XaZbx1RZX8
         oWi56q4FKaFWqdrnOqs8Hl0YNncWlSaoAK7BmeqJcw2ZH1TBRyJ18UoXkupqlVq4cDDa
         gddu3gI1IiPqSkSxFr6geQ8goYhuprrZNbnPaCMORHzsDT46mP3k1qw6KCx+zNZcIS3w
         aNWtA72u8CzbY7YWQ9d2Tt4ER7ptp5WzQMh85QLQLjfAnQb17NVbU9rsKpcJWXeWvl8N
         6Ma+M97Cp8t1h4oHVfKJLCpSJjdVkx5u2vXYUlj4lz3zkbJ/teymRpRGDAqrIgy6nrsu
         58yw==
X-Gm-Message-State: AA6/9Rn+9Lk14qsBzBK58xGTzrtmOzqEIVQQSXF8JpPtCaMC8A/gJd9jL2QQTjTXXRTZLOnBUgBhSoY6EumHbA==
X-Received: by 10.37.111.8 with SMTP id k8mr1331496ybc.72.1475560380050; Mon,
 03 Oct 2016 22:53:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 22:52:39 -0700 (PDT)
In-Reply-To: <20161003203405.nzijl552nlqg63ab@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203405.nzijl552nlqg63ab@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 22:52:39 -0700
Message-ID: <CA+P7+xoX6XsKRFUCx+vhUo7ARYMEXktzcbFS=zh1NUTgRdhdUA@mail.gmail.com>
Subject: Re: [PATCH 04/18] t5613: whitespace/style cleanups
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> Our normal test style these days puts the opening quote of
> the body on the description line, and indents the body with
> a single tab. This ancient test did not follow this.
>

I was surprised you didn't do this first, but it doesn't really make a
difference either way. This is also a pretty straight forward
improvement, and I can see why you'd want to split this out to review
separately.

Regards,
Jake
