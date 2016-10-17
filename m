Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B0220988
	for <e@80x24.org>; Mon, 17 Oct 2016 08:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbcJQI4B (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 04:56:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:61079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932306AbcJQIz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 04:55:59 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MRkhB-1cP2rS3D5N-00SwCI; Mon, 17 Oct 2016 10:55:55
 +0200
Date:   Mon, 17 Oct 2016 10:55:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] Case insensitive Git attributes
In-Reply-To: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
Message-ID: <alpine.DEB.2.20.1610171054550.197091@virtualbox>
References: <C83BE22D-EAC8-49E2-AEE3-22D4A99AE205@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:emFGSyTQhzoQbqrFwgQ+WKFE/PH0DsWB/+pBRUevgVAMDwWb0GV
 dbiSSZC7+NH50f4pFJ6vOrRzEds1IWEsettiMaizQTAPk1UMLQ86NjfLAIA6fWmOEhzO8KF
 w4Ox1EMSufLe2IZuBBZLCGLOnlDAixJwsYVvmkHo31XU3oOD42be2kpCPoxGGTYQAWy/6aT
 3gCZFS/ryjcu5/74MGuag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b4/M64tHmnI=:Yi/T/wcHxLjcYysSw48CDu
 t08NS7ClGO3vvTmOl2z7D50mJk2oO5ppCYuLwPAVbQEjG2DnVSqhUsu9Qv7gZ/+iXTxO2h9bc
 J7UfPi761xyDcz0eIuFpw9GtIO2FMNYTaXZKURUbkAYuv8M45NTLSJA66re2a7WsGJ9WdewMx
 ijqlS2S4RX0iW8ErXEqUDMWfX1CYE4q578kIeAAoPtWSWRu+ljiNm7C4iUIoglFX5k71S3ToB
 PUq4AMbprX6qcDqBkE57NkTU6ssbb1ZuRVBzO0PzxszStMnSViNBBqr3BgAHvyGUqM/5V43n8
 xgXgqAbMqDPC/WwqwNpupR6nLiwt95kgax06jCWfesx5DHw9Oc1HBAVyIB1MdA8HC+vXhW7uT
 l+RFycgtq7w7iRQQJhjuNQSOrguigeJ3GoCnkZBxW6Fb0LxHaVvCIusbaQtU3B2Jmp6VEh70o
 x/T5OsrIUJ1TFi+SeJYYD2/h1iY2JY/gXXfk3+9gjcLXJDNBkwOBJem5bGDrnsuNgNrROlrQE
 Cge+Pe1PT+dhEsH9SfOr/lTJf4W7Nrj/F56xArEorflyIEluY89BvlO+R16l061bzPTWKhZxr
 4Aa3YXyMa6JlKELJx9lwiYtPfiC6HgQtxcItdPDQC2KAuPfuMu41/Ks36hQWAkuk0qMguqBT8
 fNYx5/ZCw5F/wAL5r2C/3CsHFouEUCzkiU9vOC8q+t1nw3BLadQVQufDJlqH7+VERFB9AXUD7
 L7h8fouoYeboUynQDyOiOs26CJj+fgGq3U8hS1oldIyLRBMC+7j85J9X5LFtlZZZ5xj4XCss7
 RuKjEcV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Sun, 16 Oct 2016, Lars Schneider wrote:

> One idea could be to add an attribute "case-sensitive" (or
> "caseSensitive") and set it to false (if desired) for all files in
> .gitattributes for a given repo.
> 
> ### .gitattributes example ###
> 
> * case-sensitive=false
> *.bar something
> 
> ###

Hrm. Maybe a better idea would be to warn when attributes match a file
name with a different case?

Ciao,
Dscho
