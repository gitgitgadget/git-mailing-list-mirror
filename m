Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D9F208B8
	for <e@80x24.org>; Mon, 14 Aug 2017 08:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbdHNIsM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 04:48:12 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:38804 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdHNIsL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 04:48:11 -0400
Received: by mail-qt0-f170.google.com with SMTP id t37so48064109qtg.5
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=05ra+0jpi1pSur6mS0xaoBsujeo117bVLSrNuXEa4tQ=;
        b=SV9H/jAuFPJdBQ097OD0q6a/hHapShC4TM1yu0rfYPhoQUAfu88DNNDGwsg7xvg8to
         G4MTqqYdcuwijjS/WdXQ1CJnSeI69eoutRFyZY9LQA7cbv/3cOAUh3u/ZMXgLeo4KZTS
         It0FG5Ni5NZSxUb3/bA0pd2ct1ZY9X5zDXIFQfq+FTdWE2L8qNAxa/LpfJtl2V5N6gvJ
         YgWCg7iTnJOYc5H7cR7qazJEDLU+gJUEKTHfh8pAyJUM/6yxP+jBvCso+8OWXGbKSI//
         FzFIgnUh8iAI++B9TSTbBXvGKw49RhZLA+GWvAbTQ5iCVBA5lqPsISMjtpZHB77IwSna
         6xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=05ra+0jpi1pSur6mS0xaoBsujeo117bVLSrNuXEa4tQ=;
        b=B8KqUI5UyPfnX6qJX61WMt4uN9IqWjq7OYSD6cyMym4ViYoO2tMbu87PHkYmJdReN7
         CnNzXs3koRRGrWN4d9jzi8IdZIyvqoPEfQsgAkIR5PdI07wtATDT0EXXYmFbjCvrnfJB
         GAw+DDCTXxy/V6nXmJDQTUsgCMnudRzVxNZLlDnSgB38J2C8cFnINhvmlFZ7DdGNWyp1
         yl/ZrP7Tiv4UiWIbJBlECyVt6fk6gqnEmkZNTgS/RJ3oSbMC1hkjJZDKm0qTpkMeCnMr
         O6JpcBdmXUa5uPfB0BWdQgrAXQIAr8ua/ZsuYTvYL+WsXfbniAZqX+4A3CzHp99b13ru
         Fbbw==
X-Gm-Message-State: AHYfb5gBH+G0a4zTSmI9oM4MUnvBB0EBCxn+tFCwAeGe//t1YRgYzdvi
        k4uLkPoS8BdWnaTDb088iHsffv7kz37H
X-Received: by 10.237.49.194 with SMTP id 60mr30760599qth.73.1502700490763;
 Mon, 14 Aug 2017 01:48:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Mon, 14 Aug 2017 01:48:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 14 Aug 2017 10:48:10 +0200
Message-ID: <CAP8UFD1pYNBY+AcX=goMFQDyugT18G+cxkOKWbN9ihQcA-3HoA@mail.gmail.com>
Subject: Draft of Git Rev News edition 30
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Shawn O. Pierce" <spearce@spearce.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dave Borowitz <dborowitz@google.com>,
        Howard Chu <hyc@symas.com>,
        David Turner <David.Turner@twosigma.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Sixt <j6t@kdbg.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-30.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/255

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Thomas, Jakub, Markus and myself plan to publish this edition on
Wednesday August 16th.

Thanks,
Christian.
