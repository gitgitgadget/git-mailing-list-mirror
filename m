Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A421F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752633AbeFZVyP (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:54:15 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40066 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbeFZVyP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:54:15 -0400
Received: by mail-io0-f195.google.com with SMTP id t135-v6so3639654iof.7
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dana-is.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xOtFMMD8qEfSIxNT0z4+IFOnf4hicD5gtbQr6beQ6iU=;
        b=GXHOGLQNm45rhk30RbsGeheazbLyPCU7p9QvD/3T/MBJAdX9mfsKe7sHkyrTpNakRF
         e+VFcI4qcqHgotnb+pgpZ7vfN0Z4BD7rNsW2cit9ii3d7fkfZLKsBXeVZOsKiUcuOFxB
         8TsTvRCLJG4Dy9+4UfLhAqhvEaIXYyBOYxuwPtbZWwQ6XVgYhepcNel2jAob+Gvl6kEe
         OAjQaoB7gPgQTV5HRxKzV2Hg/nLwxpX3JbLuH9PEQEJcVfKEphrDbrdzyFwEg01E4MhW
         cvq/5gBtSswDEQgMjD6S6wR7lV3f9uxg7uOicN0Irzb4T+GdAG7tYVt6zvSPjWECfRcv
         xSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xOtFMMD8qEfSIxNT0z4+IFOnf4hicD5gtbQr6beQ6iU=;
        b=k1lFHgC1mxSSywZCrRQF+3xyr7gr+LSHih8cCofB4VnZ4/3q9bwC/+MCqkrEJIdY0A
         dmhjJPoUPErNqBcTs5l0sFq/YXb9192cp8auSTWxBtbSotnf0EwJgmDBFN5FgLdt+Jwb
         jDTmeQtWl8Q4jx/sllynhE0D45qsyKdtAMYW0cX1mFJUOMG+nMp6YtS3yqIgeDW3jkuH
         aFUrHBekr0fpfGUjVI4QpdYXvcnAFEuX20txrdQTAUtUFByEckJdi6EeSJrlmx7QqnIi
         VHYY8zlhpA0Fidc+CgO8viPVr1Bo/ZwAWhkIjtZCNP9C32rE2NPoEZwr0f+g5cloXgLY
         tyQw==
X-Gm-Message-State: APt69E1yL96oKd4SWie4+93+t5O77lCrCstJJPeo+x2pjq7jDFLWGbcH
        MnhHpyaoF9uHgGHNAf14w150hQ==
X-Google-Smtp-Source: AAOMgpfphJukiGX5jJN0cvkXMLPRBZExvuHgdCumt44XO++nPz6qBSQTMYXA3mZp8s6Q+wnu3ODGog==
X-Received: by 2002:a6b:f608:: with SMTP id n8-v6mr2773705ioh.162.1530050054425;
        Tue, 26 Jun 2018 14:54:14 -0700 (PDT)
Received: from proserpina.cipafilter.local ([216.24.127.7])
        by smtp.gmail.com with ESMTPSA id x8-v6sm1425401ith.17.2018.06.26.14.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 14:54:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] rebase -i: Fix white space in comments
From:   dana <dana@dana.is>
In-Reply-To: <nycvar.QRO.7.76.6.1806262343410.21419@tvgsbejvaqbjf.bet>
Date:   Tue, 26 Jun 2018 16:54:12 -0500
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5941A31-B9B3-4EB1-9D55-D5E86A541D2C@dana.is>
References: <614F0C12-7173-48BD-9212-71AD6FBBDAA7@dana.is>
 <nycvar.QRO.7.76.6.1806262329390.21419@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1806262331340.21419@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1806262343410.21419@tvgsbejvaqbjf.bet>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26 Jun 2018, at 16:44, Johannes Schindelin =
<Johannes.Schindelin@gmx.de> wrote:
>There is of course one other way to fix this, and that is by rewriting
>this in C.
>
>Which Alban has done here ;-)
>
=
>http://public-inbox.org/git/20180626161643.31152-3-alban.gruin@gmail.com

Oh, i'm sorry, i didn't see that. That change does appear to solve the
same problem, so i'm happy to defer to it.

Thanks for looking!

dana

