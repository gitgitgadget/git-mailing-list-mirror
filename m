Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B53120899
	for <e@80x24.org>; Sun, 20 Aug 2017 21:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbdHTVuW (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 17:50:22 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:36295 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdHTVuV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 17:50:21 -0400
Received: by mail-oi0-f47.google.com with SMTP id g131so138361333oic.3
        for <git@vger.kernel.org>; Sun, 20 Aug 2017 14:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Yrr4ETJYZrA6FDhKDNfOIb5nY6K2MyESaGRivVPUFHw=;
        b=f1DICNq53MLPy0KUD+U079N13fpQfKONWYOSI+O/g/7H2UcjqKk63rl4bnMGc2DmNn
         rZwyAjMUSqVAr3osXAZNxmvo/6sbypthqumCKlpttrrq+rZc56KMCd7dE8XsfdYHuBPZ
         /nKqvGycvv8c56YC1t3MZ+RwO0YocRvf80osZAG1hSmMc4WpxUEMmlocyLTfSjYIkssH
         dtMELDCc+seqGU/61gn0+lbq9PZQQAKpQTm8OaOb+SABkHzpybYIqyb00qb95ef87Rfd
         FXqXavz0mfFFCtatz4c2AtKqilq2KBrYUzDBg11nEjQM4Shbn3KmL3khSkB4uJvrCy0p
         CMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Yrr4ETJYZrA6FDhKDNfOIb5nY6K2MyESaGRivVPUFHw=;
        b=dJp1WfPK+Kd/IFNCuPBrjUao5ftT+2Xw2MpbZHNnMOHrxSIY2ufJheXhg2zquD4ME2
         JglsWdjDhbN+j15FYaiKSuOJKg0RrDZIeZ1QTSf3WTy42DIv1xlFXadasK3v8yNGrgu1
         nVH1PxxDPhK4gXmnZiUa2pPQ+6vynp/DXdgbV7LSpvanh0kPf9vebKEdUYGyPKUauc9k
         ZeDC5XAFz4MOisq8xAwIfk7CtT6qMTTCh+y0ZEdH1+wGciy9YgtKjHOKp48NRFKhGNks
         HfslBWYrXzSEJaEar4Db0tD9ytAeBJZB4fE8L8D00bXecYVgb2s0o8CxRDF6lh2xbgmO
         oXwg==
X-Gm-Message-State: AHYfb5jmE6Bz7YnhwCyx4Dtq7npUCNN/mAGt/7CoQuCMglxvfXTRoya8
        +zRCVZZrlrrki49+OcOLIFtEr/uBmQ==
X-Received: by 10.202.170.73 with SMTP id t70mr9804946oie.78.1503265821032;
 Sun, 20 Aug 2017 14:50:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.5.107 with HTTP; Sun, 20 Aug 2017 14:50:00 -0700 (PDT)
In-Reply-To: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
From:   Anatolii Borodin <anatoly.borodin@gmail.com>
Date:   Sun, 20 Aug 2017 23:50:00 +0200
X-Google-Sender-Auth: jYpFsAdRBKNHT8j-hjbB3rap_xE
Message-ID: <CACNzp2k+QM8WZtQ5ROe_e9E-HVQa1znjO1HSY-g8nOVst-Bnng@mail.gmail.com>
Subject: Re: Please fix the useless email prompts
To:     noloader@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeffrey,


On Sat, Aug 19, 2017 at 5:10 PM, Jeffrey Walton <noloader@gmail.com> wrote:
> *** Please tell me who you are.

Which version of git do you use? Do you have user.useConfigOnly set to
true anywhere in the config files?

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatolii Borodin
