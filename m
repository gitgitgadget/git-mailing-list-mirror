Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792BD1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932679AbeDWXZT (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:25:19 -0400
Received: from agora.rdrop.com ([199.26.172.34]:3697 "EHLO agora.rdrop.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932567AbeDWXZS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:25:18 -0400
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
        by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id w3NNP7nD000161
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 23 Apr 2018 16:25:09 -0700 (PDT)
        (envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
        by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id w3NNP62K000157;
        Mon, 23 Apr 2018 16:25:06 -0700 (PDT)
        (envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
        id AA08532; Mon, 23 Apr 18 16:16:46 PDT
Date:   Mon, 23 Apr 2018 16:16:40 -0700
From:   perryh@pluto.rain.com (Perry Hutchison)
To:     ikorot01@gmail.com
Cc:     tboegi@web.de, git@vger.kernel.org, sunshine@sunshineco.us
Subject: Re: Is support for 10.8 dropped?
Message-Id: <5ade6958.+rSvEziDyo1bWxZm%perryh@pluto.rain.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
 <CAPig+cQOzKbM0R6vKTg_BU6meEbAAJWL1T0jZkaCOF0uJ=_Lmw@mail.gmail.com>
 <CA+FnnTzqaPrLgYv-8X9BDW0DR7331morN33B81w8T3vzOwn+Pw@mail.gmail.com>
 <CA+FnnTz-qdVK5482GJo06QrvMktGYhJAJ6g-Naq0BgT-uoRvEA@mail.gmail.com>
 <CAPig+cS+gf5gGM3fmnxk-6k7ezbtS=KQFqkkxVtcytHfcQApEQ@mail.gmail.com>
 <CA+FnnTwvnA90nDARKW9r7p5iraoOGTvfDJ26n6Udc68bDSUASw@mail.gmail.com>
 <CAPig+cRjYju4zEgiY_TuOOk0e7A8zNz+hu+40vQUEGDX6FGDxw@mail.gmail.com>
 <CA+FnnTzFomd91d1F6O-a28hXQ6PxOiBd44da4nSVW0MuDKgkmw@mail.gmail.com>
 <CAPig+cTw5GjB4VgFD2teDvMuyGPFFoNSCqbXbarEXCe3fVdLjQ@mail.gmail.com>
 <CA+FnnTzkZS7HP61Ck3y5p0EC7J_h=ToR5tq5cvEpJ79vYuSxZw@mail.gmail.com>
 <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
 <CA+FnnTxXOwORs_qYvOdSj41UX1aBfj+Hd1+kxPa8j+34xgjhgQ@mail.gmail.com>
 <CAPig+cQzX04JuoUOnxOxWtqMCpHCUi=hMOSDL+jpNuML0iE+Tw@mail.gmail.com>
 <05560086-232c-f14c-f82b-e21b7ecce1b3@web.de>
 <CAPig+cSbAaNby++AvCx4CkJ0KcRkx5Q=xs8VSbNmY=dgi-F9jg@mail.gmail.com>
 <CA+FnnTy1spOxnPYFb3=xCxUZJB3D=shoOGV-SQr=4LDZEHVSkQ@mail.gmail.com>
In-Reply-To: <CA+FnnTy1spOxnPYFb3=xCxUZJB3D=shoOGV-SQr=4LDZEHVSkQ@mail.gmail.com>
User-Agent: nail 11.25 7/29/05
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Korot <ikorot01@gmail.com> wrote:
> This laptop is old and doesn't have too big of a hard drive.
> And I'm trying to create a big program

Building OpenSSL via homebrew or MacPorts would likely take less
space than building all of git that way, but if even that is
too much perhaps it is time to consider moving the development
environment onto an external hard drive (via USB, eSATA, or even
FireWire) -- the presumption being that the development environment
may not need to be lugged around when using the laptop as a laptop.
