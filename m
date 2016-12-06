Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45AE61FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 13:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbcLFNq6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 08:46:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:61524 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752142AbcLFNq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 08:46:57 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNYxW-1cKKtH0Thy-0079pg; Tue, 06
 Dec 2016 14:46:49 +0100
Date:   Tue, 6 Dec 2016 14:46:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Aguilar <davvid@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>,
        Frank Becker <fb@mooflu.com>, John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] difftool: fix dir-diff index creation when in a
 subdirectory
In-Reply-To: <20161205222600.29914-1-davvid@gmail.com>
Message-ID: <alpine.DEB.2.20.1612061446230.117539@virtualbox>
References: <20161205222600.29914-1-davvid@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bASAKYbeiCIQ+O31p5pjgBS+J2D8xw1eCtiXoaSgNBakpoxo/sz
 2aAl5NcskcFletfzzKDoXmvrQ5dHCijg4U297QzjeabF77GkC2iePHdWk2vaqpulczSUTir
 NTg7ouaMZIrZlPbTHQvxQdvnT6XU+Y3Rgkucv35TGdZ6JCt71D94FXnemNLFS5jac1Le22h
 KIsNqB0nGgbCGwVMMiB0w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:++lV7Ud9+ww=:Kj1Kv8YxLw/NGOD1GuOs1+
 hJQN0HS4MUkJkncve8T7tpgpXx7WX11GDU9int8qhVsfcwxGAAmugWnkrT/hY8OeiODxzkD6g
 9aSzYnym164c8gOt6MTvFc3Ekw0VbqhMwx2z2bMgFRG0QuGlPAhc6zNiq0kxh1hXQu15Ckk3b
 Io9L15S+DtGt0CWj91FB4kwm6lRnCdswudAHKMLeJD0r/ktZ5gQPgXcygsbZcxZL8DM/+phxw
 jQE1X+nJjnXrSa8nByXUv3Rx77shS8RUenjzfxyaiYCM1Ce9nOlMKMQKfB06rV9xFPfRva9dP
 Ff/vLjtKkZ/FPJdsVq5uqVeT5gOSVkkBmISOkmFnU6IvUQnvej02ATbDn6qshO8D9IhSimUVi
 DXokMDiFXMXUiDzxW9DmLpgNsFfRJeaqMmt9r1n26H0jUF1/fMksBudzKCM3KM1viSjsr2FWU
 +/rqrhP1rC4O+PdJrI5wC0/zYZCcSL42NrkdGu5Ve1deu2BKFdjFiRaDqagXzBHal6ruMDOqp
 fD6iHxw4xxnxF1FrTKEJdmksewy7NWijxmdMXUb1n8NZi+I//zd/aW7ubWE7cphQ1PKUkuaHj
 86sNVezr7m4fVsfyOnbTdisAABiIreS0htJD1nqalcRA8u5Ouj2yi3b/fFNrYARQe0ac4vee0
 7N3LecoQKCHecdxLtOyQOwT/JdBV0M0bkWGDw91VIW7WBoWfQzLebuK5hQvQrRwmAst3Gvz9L
 BD/Enbdi2tivtvfRpsdHrlauMlcxA2n9Z0cQ2ulr8R8nvKDXIwHJljWGrmZqHnSAdvYsUZDJY
 Mxineeo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Mon, 5 Dec 2016, David Aguilar wrote:

> 9ec26e797781239b36ebccb87c590e5778358007 corrected how path arguments

How about using the "whatis" instead, i.e. "9ec26e7977 (difftool: fix
argument handling in subdirs, 2016-07-18)"?

Ciao,
Dscho
