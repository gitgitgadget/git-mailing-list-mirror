Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6DAC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 15:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiGZPmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbiGZPmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 11:42:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A98A2C64E
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658850119;
        bh=5c/JCsQdGN6l9H/6Bd0tzuvu8C8Dt/v7526T656EC0c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BSxsjW9QZBamHpMTmYXl4OLd8fYldd4DdQK37d3ALPyJyH8OBgE7HSK1U/9yWZeUi
         pyF5ZIAx36GOhjZFZ86oLnBcTgDVbIp+De9gaC//zldqdJG53YRvsI0eUzEe9Q9krz
         cfw2Scj9P2ho3J8nzBryZaLWb+n8g4miQGAC4la8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.189.231] ([89.1.214.237]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1oG8O81I47-00HPlo; Tue, 26
 Jul 2022 17:41:59 +0200
Date:   Tue, 26 Jul 2022 17:42:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/20] parse-options: handle subcommands
In-Reply-To: <xmqq5yjl5b4y.fsf@gitster.g>
Message-ID: <1p04q351-9938-r0r7-snr6-9s8237s27459@tzk.qr>
References: <20220725123857.2773963-1-szeder.dev@gmail.com> <xmqq5yjl5b4y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2124512843-1658850123=:211"
X-Provags-ID: V03:K1:fDdgm3zqnMe4bjoiLLRnLgLmfsqGikiZSCEleutgMAMeADcXoee
 IdX1nmCApCYAUFp2I/5Q9GRG8TrDd6uWxW+l1R01FtGxFYHLxncNbuFbVXpiG2ewucfh9j+
 zzBlQbUn5aSAzkVrlzVGi5CfwExURkb4KlnuxuGB07+6j/IG4Vp/f766ldCJnWatnV6NWTG
 X2mgamDXI5w/lOEXKJUDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U5ls8b31ChI=:U44l2T+7JVqtATJplYDmuv
 u6ywEI82hskzVrYCeY55eAzbvEcr/qsSZHpMvmsOFp1mCOUKW4auFZDpW11JhCjcCUci+ers5
 2qTSG2JCE1T3BJTTVtX3puAChG/k7oMQFApRQY9jK1G9Og7T9QRDx8nIWRFibKQCOvww5ADjh
 p0zshXW8jVrB+gSVqpKckeAq9pN+dpvMrGYiINgWAx8/Ss7OEkB2FIM3pRLFSZWwHN4VkvVMQ
 reFmZBuF2ChVXt78ZofIpYuE/PVmUslcJVjmqFbho8UOztFCz1gntlCZKBOv/M/qUBANLtsR/
 h++fLsmkscOpJxgihZDa2OfJJrNvlIoSOkIouGKee1OR1pCFsgPm86O2RTAZATxNUh41iAzR/
 SVSCLw6FJt7IfE3u52eUeGDFGRQdUV3wBv5K0cF01v88ev+x2NX5xh1e3lyWsN0WXlLyo7e1U
 zKbcUTYw6+RX5utxXENFI7po2SPtBr4dT2+HqAV7uKohl2KgVszvNcnnZy9ewcxOAeUGSkqaJ
 UuIVN6YcJ/aLL9kTpBk09r+jfRi2g+Ps8R1pbMkKhFCNcAfZZPDrDU5XN427Ak0dE7A5NPQQS
 8h2g3qpTZdX8r1CmMG0Solgqm7DoXid/eo4zFNgp1QSVJl4+oMtMVPpXgIHB1IvpHK2T51VC5
 jMtejFSzCDqetKdzd69qFLMEXUHYNDaPSCuHZJewUkZ/g8OfD1iuEbRMQPe1S8I93CcjXT3xo
 KBkI1K77rLLlXk7GV23e6MBMXxRTkd8NvvvcLfgSdH2mM//1YspOqOtQ60kL1CsQWSISs4kVr
 u+bE4TaMb4BRXLlN/AFvjqkWbaDZT6MEQboXhNDy/S5/+MHqhaoNzJy3sU5qvLkF/HiEiW7Ct
 ASxA8pI7MVQDGzOdpon/NFIqlOZaL4wI3IZxh92wID8T7fORFlDV9avvJSfCQ4bqXNwSU/ovZ
 soPhuoOvl7by/qO/g06RRqS5rAn8PavAQD0yYJNMwT0jY36c0Y/ywWNyOHkCc/lXYnUWlpdLb
 7nwfkp1Iy+JGTQLbozVxpVE/HuPEemqIEi2xnXKydSsmxgd/gb6eD01SjysKA4PnBHv/6PCqW
 z7BV/wsCdi9KVPSI7YadMmvdbS3Z3NQPmAxS0ZilU9ckcWt6QQSHwhi/Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2124512843-1658850123=:211
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 25 Jul 2022, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> >   - builtin/bisect.c: after the conversion/rename from 'bisect--helper=
',
> >     cmd_bisect() doesn't use parse-options anymore.  Take what's on 's=
een'
> >     to resolve the conflict.
> >     Note that the conflicting topic should have marked cmd_bisect() wi=
th
> >     the NO_PARSEOPT flag in 'git.c's command list.
>
> I was wondering about this one.  Does the new "subcommand" support
> help implementing the dispatching to subcommands better?  If so it
> may not be a bad idea to redo the cmd_bisect() on top of this series
> once it proves to be solid.

The built-in `bisect` code carries around some local state, in a somewhat
futile attempt to keep things in a state that would be more amenable to
libifying.

The `subcommand` series does not accommodate for such a local state, the
signature `typedef int parse_opt_subcommand_fn(int argc, const char
**argv, const char *prefix);` requires all pre-subcommand options to be
parsed into global (or file-local, but not function-local) variables.

This implies that moving `cmd_bisect()` on top of the `subcommand` topic
would require the `bisect` code to become less libifyable, which is an
undesirable direction.

Ciao,
Dscho

--8323328-2124512843-1658850123=:211--
