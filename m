Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B94120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 06:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeLKGMH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 01:12:07 -0500
Received: from mout.web.de ([212.227.15.4]:36831 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeLKGMH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 01:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1544508725;
        bh=goRDzu1fuK9vguoeYDDlh4RqDzNnFkvvw2B7A/NaRfY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=LuaX5sqgV4x3beC6lEkXs1sCQJ+xkNJkKp0aznGAWIE0CUqEdn63rlu4f0dtf13RK
         XRWDALeNZdoqzKNl894GDSE8z8dbuwf7gruUuc7rJ+6EkAe1w0xA3/lGPn8mwZYNdb
         tuTaFZmjfLkr3bd0NGB6FlC6g8BsCGhaK90QzH+M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrKEG-1hT0LQ3hQC-0132fE; Tue, 11
 Dec 2018 07:12:04 +0100
Date:   Tue, 11 Dec 2018 07:12:04 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, svnpenn@gmail.com
Subject: Re: [PATCH v3 1/1] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
Message-ID: <20181211061204.GA1130@tor.lan>
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
 <20181208151109.2097-1-tboegi@web.de>
 <nycvar.QRO.7.76.6.1812100931390.43@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1812100931390.43@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:Q8mGnJp9eRHpY8Fjs0EUADF68bqYx+2A8eIQrbif0mixfxoTfhQ
 1XQzW3Jy1e52xmCPZ8L3sBxNYTo4qXJJSLIQ3/cFxY09YdaoMGCDPDipfulkOWQbqk4IW05
 blnbImro1W6lkM1XbZg5bFOypPp0CdjH1OdkLGTU3zg2ua0dbXo0IWnNgMRTN4cT9xs3vMD
 X5h/aD8meeUjMM+XjcVnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AHemg7mX7uM=:zdJ5ejr1vN//dkD4y3z+mP
 A5UpqVtN6h12ja2s+LGwM/CQkoQKS8uNJ4m5PL4P8qZKtz1CNFS/ryvbJfzP4HhkrNr3z/hJV
 2z4teBuBEIb+MVfnp+b13BZi2pDH+Ah0dTzGh5fmRSPtf0TcVxpAgeMo7RPuE/qKVwD79uyxF
 /h489dyluTgcwUUAVnNhuHHXM7vRj6sg9GrhkafGyp1ha66hk9+55tT2TbU6xdqCW1yYPrOtn
 jPSGOfZoCrlGC2ieAHQw8eAYtbZsBZWgy8BWaeDpZg+rYhhVgIrNCRMDtijzdjyI6L6p/A8Sg
 yYybNpRFp0ebrGIwctvs4QY63w1pvm2VhydnPKitIo+uV4HXecx8yEgAZH9T8zdZy2QWN1X73
 FXLdEAlAcumfXiv67YQqmoWt25wWPOAVQVnFioAo9ESSVGiQbSrSOYPahnCA/P7GsT4PeKBtR
 XMcAmXM3Tj/PrHXN7Lk85qz85Sc0bTRw/QEwxx0xCE6gnukaoy/cKRqrZbaPk7dU4/36e6etG
 uykR3ZpvT24PUwgfDzT/+N9/RHRrQVaK5mtn87YG1Mn3c8NSU362S5aQSFyTn5etAa2UAmV52
 BV8wNwKtaZ/4nE1Rl6cc5gGDNhg7uxMmFZDuUGv2LvBvRoRUPBgxngkZWF6ND7VZqwrA9v+lb
 QOAJ0ysWwhatBJOwlVzLwbesw05hiBJViHMcO0OBcrx1pJlhlHucLUM2izo4isLaQqehBcg8I
 m0L58utW3ybmFiSCvcglzUHd27XhaHCYhyq0UC/83d9X3wl6iRjfpQV5UhAYrzc/rm3R/Kr7p
 2Ut0a8+hyb3ByWObgS9FoT94c/OtG5AmRsdGWN7vde4Vif0k4msJWe4LPvVUHyXfQqGJeZr/b
 a+6/VWcWtTatWrM2H6Fyc1P1NYYQUd5w6bpQ9rPpc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 09:32:03AM +0100, Johannes Schindelin wrote:
> Hi Torsten,
> 
> On Sat, 8 Dec 2018, tboegi@web.de wrote:
> 
> > And, before any cleanup is done, I sould like to ask if anybody
> > can build the code with VS and confirm that it works, please ?
> 
> Can you give me an easy-to-fetch branch?
> 
> Thanks,
> Dscho

@Dscho: The branch should be here:
  https://github.com/tboegi/git/tree/tb.181208_0844_cygwin-dos-drive
  (or fetch it from Junio, please see below:)

@Junio:
  Please keep tb/use-common-win32-pathfuncs-on-cygwin
  in pu for a while. I need to send a V4 to fix t5601 for cygwin.
 
