Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B737207E3
	for <e@80x24.org>; Tue,  2 May 2017 12:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbdEBMLS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:11:18 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35682 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdEBMLR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:11:17 -0400
Received: by mail-qt0-f176.google.com with SMTP id n4so11304958qte.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 05:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ayuiY+0LNrbQPJHQ3b+ZN9cHgtBJULafLQPcFophzLU=;
        b=IaxqeE/We1I+NYOmR+WSteheQnOLl+8DS6otwxD01vc9VyaJ5vtEoZ12CSUGt6X2Gk
         RZfX7yDAgX4xDLbwT6wH25i3MHrNbcods3S3+2uhTOXVMoSYo2S/phoGBFm2j3yAnE45
         22DPg3EgoOCLQUSaFq3Qc9fTVaCpMomjdD1e4fDWoBh1NOl8T9TrVZ1Pf7eDDy/wi3Li
         0p/wWlQhKVAkieBva4mNNNLQ+ElA60E2aCquvw+fTfYNOmu5tsAoKBWil5N6NilKbgT0
         Rw1ghsXts5tTJs2AhyaGianeTJa0UX24IeBW2bcJ89Jj4VGUomYbjmA9g7oyNwRPgDeO
         K3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ayuiY+0LNrbQPJHQ3b+ZN9cHgtBJULafLQPcFophzLU=;
        b=UwvuLFOzzCWWGYLYBQftvDeWTkGtwHBJWvDhjr5OlkhHSzJ8vayiHH2tCqlTE/Otl6
         C7xjKMATuz4s5ZcREfRMkZVu43Jr5Tm8oWIkeDI+5/KwgohreadzNgYuqK9Ini+h3w1n
         lDeiJtp8J9jWSI/ro9lp8bMpEtNO7Vk4uyhLRgkbgXKeWHcfrgHL0yQv5wcZbHRMrRr5
         RYhpL2gGD4s+dP0Eqna97w1vvkRAf/RqOQS9v7qMP4nUBkPhUOXgdjRznXRWByiiG8k0
         /6PK1p2g/cM+cGeHBo9L2Stivq+ZRJwqnCqulrKP9P3jmyeP9EQ3o03mZ3ju/jPN9/4j
         gBXg==
X-Gm-Message-State: AN3rC/60d8mOSgVJWHIOOkPku5Ktd5NRzukiuPeJQFooUlPVwG8ncV4L
        NGMkNQcCWFE32vKowaApjjI2DkaefQ==
X-Received: by 10.237.47.100 with SMTP id l91mr25790123qtd.258.1493727076677;
 Tue, 02 May 2017 05:11:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Tue, 2 May 2017 05:11:16 -0700 (PDT)
In-Reply-To: <135C7A92C7D64E488B830ADC2970C70132AE6407@SVGEA-EMAIL.gea.fr>
References: <135C7A92C7D64E488B830ADC2970C70132AE6407@SVGEA-EMAIL.gea.fr>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 2 May 2017 14:11:16 +0200
Message-ID: <CAP8UFD0NrTyGYgHeEOWpUH5v0ejKvcKu+Mzd8_scYbvzL4b4zg@mail.gmail.com>
Subject: Re: Could GIT manage revision headers embedded in code ?
To:     Delanoe Eric <e.delanoe@gea.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, May 2, 2017 at 1:48 PM, Delanoe Eric <e.delanoe@gea.fr> wrote:
> Hello,
>
> We need a great deal of traceability for our source, made of many scripts=
 in interpreted languages, spread in many "independent" modules, as far as =
can be ;-).
> In particular, somebody troubleshooting a script in production should be =
able to know exactly the revision or commit ID (or tag label) of a given fi=
le, and its location in the GIT source directory tree.
>
> Our old CVS... let's say it was its only advantage... was doing this with=
 keywords embedded in code comments: $Header$, $Id$, $Rev$, $File$ etc... W=
hen a file was committed, its $Header$ keyword was expanded into a rich pie=
ce of "version" information like '' $Header: /cvsstore/SourcesOracle/Instal=
l/COMMUN/CST.sql,v 1.69.2.10 2017/04/14 09:38:48 edelanoe $".
>
> Could this kind of "keyword expansion" feature be added into GIT ?

You can already do it with "smudge" and "clean" filters. Look for
"Keyword Expansion" in:

https://git-scm.com/book/en/v2/Customizing-Git-Git-Attributes
