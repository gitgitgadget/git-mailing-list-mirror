Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040AC20193
	for <e@80x24.org>; Sun,  7 Aug 2016 08:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbcHGIvJ (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 04:51:09 -0400
Received: from mout.gmx.net ([212.227.17.20]:60790 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbcHGIvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2016 04:51:08 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MQzoI-1bfZAu2zy2-00ULfn; Sun, 07 Aug 2016 10:51:02
 +0200
Date:	Sun, 7 Aug 2016 10:51:01 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: use STRING_LIST_INIT_NODUP
In-Reply-To: <57A4FA24.4050505@web.de>
Message-ID: <alpine.DEB.2.20.1608071049510.5786@virtualbox>
References: <57A4FA24.4050505@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-863835765-1470559862=:5786"
X-Provags-ID: V03:K0:vWH8iO/81TZY0NZquLYguJ3GglcDcicND5D+KUTtvYU3IQ6etsQ
 Fk5OfiNefb0DKukRtNVURHqxsdeAGpKakh2F3I3qhBvWT/lc+vZS1d1nIhOwXFalmmfo2QJ
 XwdshO1BduiFrFA9UNnsULOyQzX+RnQoAkFenru6hTUR8KJkgO1rEcMrA8SdVTT+//gygXm
 BUlpHLHr6jB7ubsK2VpqA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:SArbhHmyAXE=:mBYHjNkdSZ6pIq32c3GsRf
 Qw1paEH/RWs7ucPZa+Erd8BIwDxkBf0YB1Dx2MAtTdbiO+xIKMIUkwj5RU20YeDT4YFcyWO/N
 53vlGn5bhTZe101vIlLw8dz/J9zXGvKIiZpAM/JrRYY5I5SXiw0dNwV3OhU/OIWl4dJZ8BgSp
 OchXGEWhjhYVTVOQ3vfDiyW2OgbTVNYppxPYtQDgFk+/JTHPhw1RHG7PIl0mO/fJREevJLeM/
 U4x5PUlK3gS9nTGzGtmv3wdOLWKoDK7ARkSlt/1r+iWrwgpbFDybu6cmgzpI7UaTSLRBxhpdg
 u9WhRFoD5b4PfeiIo3p66NZrFhNmxHsB0lV/sVvvi97K6/n8I+OOsXGWBBsrEa+tfFtdPIqHe
 T1VZ3A21R4xF5xudnuJc2elbUzCXOvql/5YOPf2N4P1NXdRwSmHzeJlZTiYlhWFwOAlWEUHt/
 hmiSriKCZh8xQ9X2WS2Nfb7mbVob37HHhTABwdRqyNdldcDVYk2366UABtqfBKybAFLAJkIfJ
 zfRr8avOZ8Qe4ub5KzGYwnjA/MEFqqi7pDd12GJtpJ6OPCubZYgO5B1ir4QfkGzfcs2+Krb5l
 QtSwqprrw05ff5BPgY2RpCdFuNj+Tg+JOjTmnmZgc/vwgay0YQkeVCfMYEpjzBcDTExEUPbJ2
 zoHnlTqW0l3cP2iVeF+7fRjEej/q0Mkf40c9pnoXC1ZYMitofz936mjP7gvzAqAHxs3ct3WYX
 SVsV2xTp3aHNB7RKvti6j78Qv8j7vU9RYP1ySP0J2uPiXh62S7sgo3472PWGB/zf5Ye23wMUe
 t7t9HdX
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-863835765-1470559862=:5786
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Fri, 5 Aug 2016, Ren=C3=A9 Scharfe wrote:

> Initialize a string_list right when it's defined.  That's shorter, saves
> a function call and makes it more obvious that we're using the NODUP
> variant here.

Thank you! I guess I never updated the code after the _INIT* macros were
introduced.

The change is good, of course.

Thanks,
Dscho
--8323329-863835765-1470559862=:5786--
