Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA281F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeCZVFX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:05:23 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:40656 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751160AbeCZVFW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:05:22 -0400
Received: by mail-yw0-f175.google.com with SMTP id r145so6580234ywe.7
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=f4wBbgjIKLGuZO5FG/Ob6mPhT1LGwWbB9a0l6W14Pfo=;
        b=EsWAODX53uANJArC0o6L9ikCjNSV1n6Nhe+hGE15pW/cSaOBbq6Pd3juanyXHNdoJW
         K9umY66VlxgwVl/9E0MoJupsgeRK0XhIrjZfBy6n5IdQIQmgR4WfVf4Up8BR+nUTsJk3
         GvsQejzg+NQT3F2ljOeIAKpJ2p63xzagK4OSJzAbzi/LoLeK4myXaEYzlz7h+FONosVL
         xEc6k7JUsq7C2V5xfoSqD0p3YbDT1prvFTgIf/rlU2LDoJ9y/3mNDPW4itSPpxUTTGc4
         /CuZdPqF9794oqIEbiMbX99Ak7GjADQMCW9Rw0dj1iuvOLnOpPxrRfMYOHbUPXlJ9aW8
         9zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=f4wBbgjIKLGuZO5FG/Ob6mPhT1LGwWbB9a0l6W14Pfo=;
        b=lwuau7MCV+U9rthxSxL8ICATVbg0vSAaukwfvkjGyMjbFFTvzb2xsmrGYcbJ0+7jBV
         bDIA9ArXYmIHn8e8AGSp57VJ6HWqdXQ5z1LgFvodz8QaKj6K6Fuo40BSbM1XygZXR0Ev
         jvbX8vb5sqCYtxW7SRbtZQuFr1PEeQB5AGEOjrTgDISxGqowv0ZG7CiYsMUCUJPQPNvP
         61TKjRIlynKtmoeHDeIDqosnfqn7GlzQJf+pm2hgp93Uc/IJkIISGivNaP7JtFEDKqOL
         5JfI0ro59rtbBnlR9UFLOak76hcz5ffsVWVQzcQ8qIwXSJsKfH0BBGyrrz8whN7z+KDk
         CDYQ==
X-Gm-Message-State: AElRT7FJK4DahYW8OdVE0RmVC5yvldiMuhfdRpUDT+otIbMxMNsoAXTE
        p0V++LYXu42zLVJH1+Dp7bnKaNu72FrNsMws9e+E3mPR
X-Google-Smtp-Source: AG47ELtD/IHcJkDbIWAI84TOljo+1zj9pqBcK5CwpN2YcRWgHZs9QYxNboqLydGnbgOs1EqR6Ui5S5XylbyvDgiICAc=
X-Received: by 10.129.108.67 with SMTP id h64mr24250949ywc.500.1522098322009;
 Mon, 26 Mar 2018 14:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180303113637.26518-1-pclouds@gmail.com> <20180323155523.22269-1-pclouds@gmail.com>
 <20180323155523.22269-2-pclouds@gmail.com> <CAGZ79ka0ptbwHU0Ym7aGm86o+YG27goHR6iS3uf5yUkj0Uj15w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Mar 2018 21:05:11 +0000
Message-ID: <CAGZ79kZp-oxowhguARiaSY713-k5NLpMPVFA8G2GD2Vy4KxoTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] repository.h: add comment and clarify repo_set_gitdir
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 2:04 PM Stefan Beller <sbeller@google.com> wrote:



> On Fri, Mar 23, 2018 at 8:55 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com>
wrote:
> >
> > The argument name "optional" may mislead the reader to think this
> > option could be NULL. But it can't be. While at there, document a bit
> > more about struct set_gitdir_args.
> >
> > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>

> Reviewed-by: Stefan Beller <sbeller@google.com>

Uh, not so fast. Is it worthwhile to align the parameter name in
the c file as well?
