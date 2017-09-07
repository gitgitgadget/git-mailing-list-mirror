Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD5E20281
	for <e@80x24.org>; Thu,  7 Sep 2017 01:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbdIGB0Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 21:26:16 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35179 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdIGB0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 21:26:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id f199so1104957wme.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 18:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=diS5eipbyMZ/WYAWqafi+CSfqhBMKRbWM0T2r/NGObk=;
        b=ijrurIzv6v5oU2Fnua/sFDWnxVkNkydxIlagkobp+/sjKpMll68rmHXauGfA427CPH
         Yyje2/U5MI9NgcgxJDuhWL+6xQYFc+ZspK2iMLS5Y/S5X2OAYVI/pRYk7KZo/eNEEc9g
         8WsMRVbv3Yf5U2OhTHjTg11eTfYTXDOGWdsgSWOnIa5YKWjjl4p5UL3BUv/JBtahi9ru
         Y+pjBBeLPbtuHqOU2x81J8MzJ8/0/OTJBsMj9O4UPb7UAHruv1APAaKejdVmbu8uqq7r
         9hPEmXv3QTRmZzLHzFo0a9e2LtMuWf6BcAl1EAjwlxWedDidf31Vpp2IzHsRmKjfvBGl
         Q5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=diS5eipbyMZ/WYAWqafi+CSfqhBMKRbWM0T2r/NGObk=;
        b=OOicYIqoI/a2WRSCDML2sFjDuoo61TI4dmOmVnxTHPMGwxkHeg18opkp1+wSeqOeo4
         V/qGuSbLZhom1QbEtSoLk1pmCKMqPuZaXXMaHkP60Pm0QspJ5iLO2TiLA8CLYgO4TILn
         U3RLTl+Dn5EWYr2yIiPKR+hyaxWjf2yhjyGnFHcOHV8yRhvcFtaohN2UC/eOCW/WOVi0
         V6v7tqNgqkMVHl21p2G/zb7YLi4j1Chrl+YkFnHv59k9XTGGOtNuYZoRbn//Iz229gd1
         bX2h4nQXFeFG9yLQor+i/YycBtSxwjewm0Fe/JlQo2oXgg6ejklPD/PGvp388XpdiWoX
         KB6w==
X-Gm-Message-State: AHPjjUh7IkkgYJ5VpK2zM6o9EqGH9a1nF9r7JIlO/TPlqtac41hPmsW0
        gD3sSb9Zb+bEhhjvdT25dtshFmzECw==
X-Google-Smtp-Source: ADKCNb4AQ9rMGSQPtrcAmNy/HLdDUSOQE6gl7/XhMK1qwFvafYZDg8dHv+ZBbbiazDYKlTYbuf3q9vWg+WcO20w5ETY=
X-Received: by 10.80.169.43 with SMTP id l40mr1160966edc.187.1504747574155;
 Wed, 06 Sep 2017 18:26:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.199 with HTTP; Wed, 6 Sep 2017 18:25:53 -0700 (PDT)
In-Reply-To: <xmqqk21b4n0k.fsf@gitster.mtv.corp.google.com>
References: <CAHd499AuoZ-89mpnVkMhxaDT44SRNT2xWE7sykcaP8n5xTRd-g@mail.gmail.com>
 <xmqqk21b4n0k.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 6 Sep 2017 18:25:53 -0700
Message-ID: <CA+P7+xrbmx7JaCfxKLwKqCTXVBMd4mSg8zpxDLqRoxVAJDwhtw@mail.gmail.com>
Subject: Re: gitmodules below root directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 6, 2017 at 12:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The current gitlink implementation records only the "what commit
> from the subproject history is to be checked out at this path?" and
> nothing else, by storing a single SHA-1 that happens to be the name
> of the commit object (but the superproject does not even care the
> fact that it is a commit or a random string).  We could substitute
> that with the name of a blob object that belongs to the superproject
> history and records the information about the submodule at the path
> (e.g. "which repository the upstream project recommends to clone the
> subproject from?", "what commit object is to be checked out").
>
> When you see a single tree of a superproject, you need to see what
> commit is to be checked out from the tree object and everything else
> needs to be read from the .gitmodules file in that tree in the
> current system, but it does not have to be that way.
>
>

IMO, this approach described here, (point the gitlink at a blob which
describes the full contents, URL, etc) would make more sense. The
trickiest parts I think are (a) it really requires tooling to change
the git module vs just editing a file, and (b) we'd need to prevent
the blobs from getting garbage collected.

I think it makes each individual submodule a bit more robust, since
the actual submodule pointer always points directly to the full data
about that submodule (it's recommended URL, it's path, etc), and
changes to those things *are* changes to the submodule pointer.

Thanks,
Jake
