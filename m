Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FA91F404
	for <e@80x24.org>; Sun, 22 Apr 2018 07:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbeDVHeG (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 03:34:06 -0400
Received: from agora.rdrop.com ([199.26.172.34]:2456 "EHLO agora.rdrop.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbeDVHeF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 03:34:05 -0400
X-Greylist: delayed 1358 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Apr 2018 03:34:01 EDT
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
        by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id w3M7B8qe009468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sun, 22 Apr 2018 00:11:09 -0700 (PDT)
        (envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
        by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id w3M7B66k009467;
        Sun, 22 Apr 2018 00:11:06 -0700 (PDT)
        (envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
        id AA01524; Sun, 22 Apr 18 00:10:25 PDT
Date:   Sun, 22 Apr 2018 00:10:20 -0700
From:   perryh@pluto.rain.com (Perry Hutchison)
To:     ikorot01@gmail.com
Cc:     git@vger.kernel.org, sunshine@sunshineco.us
Subject: Re: Is support for 10.8 dropped?
Message-Id: <5adc355c.rJrv6ddtapM9C9H5%perryh@pluto.rain.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
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
In-Reply-To: <CAPig+cT0ogLmiviWhdZTLxDM7+VN3hk7wgkKnvX96Ym-yXR5bA@mail.gmail.com>
User-Agent: nail 11.25 7/29/05
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.us> wrote:
> On Sun, Apr 22, 2018 at 1:15 AM, Igor Korot <ikorot01@gmail.com> wrote:
> > MyMac:git-2.17.0 igorkorot$ cat config.mak
> > NO_GETTEXT=Yes
> > NO_OPENSSL=Yes
> >
> > MyMac:dbhandler igorkorot$ /Users/igorkorot/git-2.17.0/git pull
> > fatal: unable to access
> > 'https://github.com/oneeyeman1/dbhandler.git/': error:1407742E:SSL
> > routines:SSL23_GET_SERVER_HELLO:tlsv1 alert protocol version
> > MyMac:dbhandler igorkorot$
>
> Try re-building with OpenSSL enabled (remove NO_OPENSSL from
> config.make). You may need to build/install OpenSSL yourself to get
> this to work.

Explanation:  "tlsv1 alert protocol version" means that the server
requires its clients to use a newer version of TLS than what was
used in the local build of git.
