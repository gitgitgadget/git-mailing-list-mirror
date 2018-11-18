Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EA21F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 16:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbeKSCoM (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 21:44:12 -0500
Received: from mail-yw1-f43.google.com ([209.85.161.43]:37921 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeKSCoM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 21:44:12 -0500
Received: by mail-yw1-f43.google.com with SMTP id i20so4638550ywc.5
        for <git@vger.kernel.org>; Sun, 18 Nov 2018 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cGjIa/vT2PB40Lnqb+X/ER7N2bjavCv1zdnuopbaem0=;
        b=Sjdjzu8PO2db2deo22EUR8BYKZZGk08BojiFw/AdO3Qv5DNvRzMTRp16nbPaCLYWEu
         rJEpJzcAQtxsmPWwovJVeS8WAKggtDb7wVYrArdW3xGYUIatqVgnCI+0xMfbbgdlbazh
         Fghn+xE2lND5dhjGYkPq+tEU1fZDlAqkX5ODy+13WfdPo16hUs7RJJGTqdDoLVDgUqQW
         IsmR5CTmP3swIII/GA/LgI7N/VxrPTLrvReFLbMDLaW9YTyi1PhYsLXy9U7iAbxpu4hM
         9t5fSNZ5bnnwgvQxB44kODSwlu2zgtKtstrbkBPUkSN1/HsHPMHQpP/se6vGJqLTvqdI
         24CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cGjIa/vT2PB40Lnqb+X/ER7N2bjavCv1zdnuopbaem0=;
        b=Kx45hFOE7NGopOe+Atmx/wWY080KzQLBcqr2vWDyzKbMwgIKYgvvDqC+GR4hqkFwcf
         jHGLiePTEc1ZtpVCuMyfCY5talpCISF+kjUg9bM4SJBp32VVjqksqOj6FxwlENkbTsBc
         v096I3NXS0dJ+lzbKPvQvZcjkHWV4CbWRW4xzEDNs2QYz2OWk95iIawWunSDQVxur9Yk
         1sTawgi/YRdQAj/KF+OtHrvUfu3slgemtoqPJvmn8vtCJDQXnQ0elrcX1WDcFgvxSG4x
         XjRN7E6PQufnsDgxI0LRsbVDdAFn5aIIp1fx78x1T8c7FvS3MKlmw8WWusqrI2MCP3tv
         UvSw==
X-Gm-Message-State: AGRZ1gJeP7gDljx/IrLS9HisDYIdY+f0fQLGemD5u2qpf6UUrAPVdZb4
        c0j8G18cezggNpNR3yzDGBsvgLyi2m/rW8izBSU=
X-Google-Smtp-Source: AJdET5d0VQNKQpQOGDYkGuf78rVcf/Kn5RcpGaB5lZQkeLjhfDBGsac8U7U/s0OHAKNs9JZIr+Pkbb48zWuAmR6vE7w=
X-Received: by 2002:a0d:f483:: with SMTP id d125-v6mr17616488ywf.299.1542558210577;
 Sun, 18 Nov 2018 08:23:30 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181118154124.GA21680@tor.lan>
In-Reply-To: <20181118154124.GA21680@tor.lan>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Sun, 18 Nov 2018 10:23:19 -0600
Message-ID: <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
Subject: Re: Cygwin Git with Windows paths
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 9:41 AM Torsten B=C3=B6gershausen wrote:
> Thanks for the report
> It seams as if "C:" is not recognized as an absolute path under
> cygwin.
> May be it should ?
>
> Does the following help ? (fully untested)

that looks promising - but its not getting pulled in where it needs to be.
perhaps another file need to be modified to utilize that macro?
