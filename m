Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445A51F859
	for <e@80x24.org>; Fri,  2 Sep 2016 07:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbcIBHcQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 03:32:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:52676 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbcIBHcP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 03:32:15 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ld4xA-1bFQc42fnk-00iGFH; Fri, 02 Sep 2016 09:32:08
 +0200
Date:   Fri, 2 Sep 2016 09:32:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 27/34] sequencer (rebase -i): differentiate between
 comments and 'noop'
In-Reply-To: <1472746523.4680.30.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1609020931450.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>   <736bcb8e860c876e32e8f89f68b0b901abedc187.1472633606.git.johannes.schindelin@gmx.de>  <1472718815.4680.21.camel@kaarsemaker.net>  <alpine.DEB.2.20.1609011720160.129229@virtualbox>
 <1472746523.4680.30.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1191959027-1472801528=:129229"
X-Provags-ID: V03:K0:2wTPTrjcSnbHUOCT0n4OGxbLtNN3zA5A07ZD4Mn1IB0iDe+jH4a
 uERDUOs14XiM43puPzK23sr7srhC2vjkBLBi6/WQXN/k5JMPJzivxX5tgkP3LbInTaiPA0X
 wUQp9xnB6y5TJgirHG7jcniryxpzAa9i8WN8B5rtD9E9u1xk9tujpJK74CAVwkepP3pL1pH
 5O67CY7ILb0VmPWKli9ng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hUH2d+rQ39I=:s6QZ5R3/eKoNr13fk83mgP
 bCqQTqgrJCBYeYcsy6hcrijLJ1bdqn0XtQGa7rZL1R7O2PtKDtWDmxjeXWOUfCxcMDkF3MiN0
 58NLamcQdruO2H+x1B992qfPD2COewH6TAHFo+gjS26CtC9aI3/rYDKlij0TBHYOJrg9AvDfx
 mjiFCRUMzAhrQhJl31NTTbAlhpfpOnuqo97Wp2oi29E/eRXSxyo1mY0jrV0rFVOuldPZ7mGG+
 N+JD8ue25bzej172pDj88HqHJGlDPZgIdWXLdj3ZwEAceM3YiIkrdrB769NVAGQg5STxNFtjW
 KM9MQfZVAyZDFY5PehERHhcX/TfeEbOpi6ZP5T5aj9aSKKCj2i89gHgUN5woEZH5YmZCCP2zc
 cJ3in7/Tj+wExz2W1X/LVm4Gd64vcoSOO/9yDTVDupGhyWz9nKAR0iRrsOeqlyDAELyCmgSg5
 YJgRFeqyn7d7hDxMAWwch/yngXkGg8sFVlNHkTcf5qshD80wR0iEqCwwY6gEw7nFpshqXjtoq
 MFoN2QTK0BvPE4Lg35g5BBtnUijBK97YnXycquQTyraN786LCpWvcMPNs7SOAmBijdNez5RnG
 mddG1WIhfG0piEjngezGzLvJLSapOIy4+kAMUt5xgZbNHTDk3OhZ7BQoZ3D7qAQHtEZ5bNRAf
 WeG6uEL/h2g4N6GUEsItxZaxJRlZwmadMZhY/lwEnIJWlHl0bbMdM+c6lHVl7vEsSBzu2Nlnf
 67caMw2Gu5Tg+xI9v1RxdV1AES+ov7rZyTz0LobjpCdAcXY+ZroaV2d/rt7ZQ1jsUxviQyYNp
 DSDhAMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1191959027-1472801528=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Thu, 1 Sep 2016, Dennis Kaarsemaker wrote:

> /*
> =C2=A0* Note that ordering matters in this enum. Not only must it match t=
he
> =C2=A0* mapping below, it is also divided into several sections that matt=
er.
> =C2=A0* When adding new commands, make sure you add it in the right secti=
on.
> =C2=A0*/
> enum todo_command {
> =09/* All commands that handle commits */
> =09TODO_PICK,
> =09...
> =09/* All commands that do something else than pick */
> =09TODO_EXEC,
> =09...
> =09/* All commands that do nothing but are counted for reporting progress=
 */
> =09TODO_NOOP,
> =09...
> =09/* Comments, which are not counted
> =09TODO_COMMENT
> }

I like it! Changed accordingly.

Thanks!
Dscho
--8323329-1191959027-1472801528=:129229--
