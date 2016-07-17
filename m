Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9723B2018F
	for <e@80x24.org>; Sun, 17 Jul 2016 20:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbcGQU25 (ORCPT <rfc822;e@80x24.org>);
	Sun, 17 Jul 2016 16:28:57 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37605 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbcGQU2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2016 16:28:55 -0400
Received: by mail-wm0-f52.google.com with SMTP id i5so91697033wmg.0
        for <git@vger.kernel.org>; Sun, 17 Jul 2016 13:28:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=N44midx4iqmtDJZDYcfKSIijF84wC+n2pUU7IRQUWX8=;
        b=Lmb9Tdd+u12w0ToTkTZQ9y6t6YPs1hdeh61wfpkcVs74vLZaB6TQczy8sp6VJQJ+Zk
         OBvon+pmxeY0FOSuqXjlUIRXe59YwFNyV2EY+4DHXtNH2a727cP5waHMs3dkuPC07nr8
         wMdjzzAjpttOBQqWonTQ0K4HPjSwzkcDphqBF7y4n3UB+/bN22o5oYNaheO5090lyA7V
         bs/Bs5eMRq+WXD7W0nHsWF92qHoVJu02WRpQiSJryVfMNb60FrMPn/W0vWxl6EUjdCcX
         GdwC7jFBnabrj4Q4yklzgqFlxD2MiR7Mq+EVKXlvclBBAhLE8iLogdfgNcrt72NUDSrG
         bdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=N44midx4iqmtDJZDYcfKSIijF84wC+n2pUU7IRQUWX8=;
        b=mMHTUagh1ZFBC2njDROiqA1zkysDktGSEWSepWK7xYXcy+uQ98gQ3hdokI/8vsRzRU
         IbZ+9UCTuBILfJv/2X/cg/yvivd9lp3h8nJO1UFIhj4z0kK/UJtxavV75ErynYoGTMeQ
         78pB/qtHeO0BKpRLFylPbrf4d2zCg9IhnH5551QFl9xInPqSj4saChxueNMa+3dJZ76i
         dmpwpTMobzfsqp+/d0ATQnm0YuCahiyCb6GJYbPtHLZOp1qAd4IiooGNSle7aYVJ/wqC
         euB4oMu9ZusW6z5y8O/Ez6SR5ZnDn0oYPASS4jFLWGvdod6HF3jmb6Hz/Be02ezHl+j9
         sQUg==
X-Gm-Message-State: ALyK8tKcjxjAlIYioAYjZokEhSQbrlr3YjSWTbqlaWRnm3rdEr9ZITCHUm/vKOg0ZfrLU7RxTYcCMcVjzreJ2Q==
X-Received: by 10.28.167.80 with SMTP id q77mr32568514wme.62.1468787334257;
 Sun, 17 Jul 2016 13:28:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sun, 17 Jul 2016 13:28:53 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sun, 17 Jul 2016 22:28:53 +0200
Message-ID: <CAP8UFD2zJEZn-hhzEEM15bNfgzT=4U1UwfUgYNbWCRcioHhSDQ@mail.gmail.com>
Subject: Draft of Git Rev News edition 17
To:	git <git@vger.kernel.org>
Cc:	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Greene <greened@obbligato.org>,
	Ovatta Bianca <ovattabianca@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-17.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/162

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
July 20. Sorry for the late draft.

Thanks,
Christian.
