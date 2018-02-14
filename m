Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719401F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031848AbeBNWlT (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:41:19 -0500
Received: from mail-yw0-f173.google.com ([209.85.161.173]:40161 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:41:18 -0500
Received: by mail-yw0-f173.google.com with SMTP id y186so8012813ywf.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LrGt4gNpU6g9glsBae+Iu96PkpHDPsLFi1ba51nHDIM=;
        b=iCb4/wy94c5QD4c021QiFin+ZjBNYkhJVv7jeHnZUFaLDdAOXcb00QnZTXz6+tjQGn
         GNzZGdQYWedkM9QT45l+uiAblJXcrMi+QYzaywJ4UvoJ1oDC9KRUrwZDUjwbGsaP5CRk
         jyIIXs/y8F5nN65pOwBsF8bK0eaKlaD088XENRKoqfaYqyKNDYiZ4VhLWfIAn4xWB85u
         7gkgbxSAZuXZQHiCy/M1AaK5KpACOPYCPLJuZTDYSLY+V72ssoOAZQvYTJ57ck9Lt7nN
         KblTAhLov4SxNFQBs2yNIubJTjvrI2/goGTWEmS26uY6Kr3d8fETLgmFnn+n1EG4roLc
         3pgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LrGt4gNpU6g9glsBae+Iu96PkpHDPsLFi1ba51nHDIM=;
        b=TeA4UnixUyuYVgmQUIksfEAlg8+BLy2yZhRNPdjKiof8TIxWDcCa3BiNcawbt8Dexi
         /neRBmGlnblnRgSsCZBbQujl4ZYJHEmbpE9ya6IOV6dO/wlxqpi/e0ZQNyxjRXiaxWCR
         SgxDlSLZh/8pp2oiOBrb3zKvdqzl3pB+FSsa87BBNCXhsq1BYUVfgdlcz2BNhVhT3R3w
         fPZEbufdLGUGLM2FzJJsT4B/gySJ3QzFcjTfRNl3IIDzQqdCiEAnjuyiudYGqCQNOTrH
         Cb1o9PnG/qwF0num7ELda/EBMomgGzBquuf7L+vonAhKOdcFoagN+SwlSEtZMNEtvIJg
         hN4w==
X-Gm-Message-State: APf1xPBaG7bAtYnlckRkrO0KdEeARSkb4iliVyqrW+fixYrVZ20yVrME
        rvHvIO0crmc66uS0YF7kKBbFtr+BMXm5glIrtDap4g==
X-Google-Smtp-Source: AH8x226KdCucxEMHd+d3lmVI4xjzJzjokvx3MNkhie+yVj/JbeDR5jt6It+tMR97otbzKRHXBYEa8VtDAq8VrhXZFhs=
X-Received: by 10.37.180.65 with SMTP id c1mr626378ybg.438.1518648077181; Wed,
 14 Feb 2018 14:41:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 14:41:16
 -0800 (PST)
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 14:41:16 -0800
Message-ID: <CAGZ79ka7b_+o3p9P5oGmCoh6dJdqYx6Rwv=fetKavcgBhztgSw@mail.gmail.com>
Subject: Re: [PATCH v2 00/37] removal of some c++ keywords
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:59 AM, Brandon Williams <bmwill@google.com> wrote:
> One person was interested enough for me to go back through and also
> rename all the paired 'old' variables to match the new names for the
> variables which were named 'new'.

The patches are:
Reviewed-by: Stefan Beller <sbeller@google.com>
(apart from the 'this' nit Junio had)
