Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE351F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 10:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbcHQKkv (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 06:40:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35823 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbcHQKkv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 06:40:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so22670072wmg.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 03:40:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WuaIE+JFDkGM42dnkjnzLFlRVgEyVCOQ5tGhM5Ebi68=;
        b=Eb0XAA54QTSTMc9Ix+WRbZhyoLqGdEYRRigVKT1SiRGRFtoFMfcpECgWx9Bqr+VT2o
         ckVmmq+m+NlXtX7MNc6lvWAqz9dq9dEW0/WHyRsHomJs2+CV5IrRiNlrf0ApobdwSzVQ
         UpSjL8m4k41oOGDuOuHY174R1aAK/xq8Qcnxxtt0jLvt8EHzuEBtTEuripGNP5qn82z4
         cVflDRODyqW1x/ZhoV0UnixNJ9itCC6HwpYHr57TFMJxXC2fAxkY4c501eJEAu/bZDpx
         WQO7fKwQ+uSAUmxVHHqDlOj4H5yU3MPEtrjIsqTOX0EFvpIok+KVT8ihyrFNT6bU0opo
         7jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WuaIE+JFDkGM42dnkjnzLFlRVgEyVCOQ5tGhM5Ebi68=;
        b=Ncc+3/pnTQzTeSPGcBVkfQfkPRClFdJ0wJdhTKPmcY/oHN3UKFmLe0wNyFDrFcRk2X
         /tAHT1dXSMPJSFDhlzw3nVxiHHdT58E12KwC/tZLSA8+mpQgrj55g2SiPphFuggFjAtg
         PwPeY+3bcKCNCwL1BlETCnY1/skghtzKJC8HAHHDMfQItkhVMLthQ9i6FJOuJVI6uGfB
         p7BRJ40Wy4MpeIol4sBOvWPtjW2nx/uRKUZCe+pfIfE5E9GZGOrnTjgXwDj9mwS1jXD/
         pZP1pl3VesWueSQnzFVrVTF7Bt5lINcfN06h2BTKPFkmXzsLV7lxoqGKS6hZ75MijK1n
         xuKQ==
X-Gm-Message-State: AEkoouuM2z7whna+GT7yb8b6eBpzkAr51jhapCu66noDmjwQ0ttzoFVhtT/8tM+eM9A8nvJjpwZB34ar/kvsqA==
X-Received: by 10.194.149.113 with SMTP id tz17mr47688128wjb.64.1471430449557;
 Wed, 17 Aug 2016 03:40:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Wed, 17 Aug 2016 03:40:49 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
Date:	Wed, 17 Aug 2016 12:40:49 +0200
Message-ID: <CAP8UFD2Xz5OxmF+UrywO8Uhh2OvypgEGMQVkz3Lk=HMzs8DRmw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 18
To:	git <git@vger.kernel.org>
Cc:	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Roberto Tyley <robertotyley@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	lwn@lwn.net
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi everyone,

I'm happy announce that the 18th edition of Git Rev News is now published:

https://git.github.io/rev_news/2016/08/17/edition-18/

Thanks a lot to all the contributors and helpers, especially Lars,
Dscho, Jakub, Roberto and Josh!

Enjoy,
Christian and Thomas.
