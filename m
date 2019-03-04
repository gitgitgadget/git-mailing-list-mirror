Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C03B20248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfCDP30 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:29:26 -0500
Received: from mout.gmx.net ([212.227.15.18]:41273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfCDP30 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:29:26 -0500
Received: from [10.49.208.72] ([95.208.59.9]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LyF3F-1h3yLw0unt-015WXa; Mon, 04
 Mar 2019 16:29:17 +0100
Date:   Mon, 4 Mar 2019 16:29:17 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     "Wendeborn, Jonathan" <Jonathan.Wendeborn@bruker.com>
cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: AW: fast-import fails with case sensitive tags due to case
 insensitive lock files
In-Reply-To: <3dbce0f1c80e4e67b114f8c84e2106c8@bruexc101.brumgt.local>
Message-ID: <nycvar.QRO.7.76.6.1903041627230.45@tvgsbejvaqbjf.bet>
References: <ceb9b34681c14d9ab2a33ba909b5ca75@bruexc101.brumgt.local> <20190303002542.GG601925@genre.crustytoothpaste.net> <3dbce0f1c80e4e67b114f8c84e2106c8@bruexc101.brumgt.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-60783448-1551713358=:45"
X-Provags-ID: V03:K1:7xsyTwyizoWfZXGUXKnE0/7fLgPtvjMpxHnibHcHaAJa5WORjPB
 rlQRQ7MP64+HckIqL+x1PJ57W0OmdrSVE2sfC5r5iRORUq8RBtzYr8WBWhv3SpCYn5M126I
 168gnMfuiMW1LCmd9eCCsi7g09ulcVi/5TsyzLmEdOQl9FZofxAsU3TC0Hr7QgQ+VzSYgLC
 I1XItCOnsF1U4psXISJXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c2eiC/Fwc4E=:/MMj4vwRdR7FJ+nJZmDwo9
 LVBK8OUN7D+RNbPwyjjwW7qEsUjor5Rxh4bgOKPvJ1nZcCeVmBE/SWU2aomHWapfGE9YLu636
 epeONvBtiUQVb5w8RvX06kTstH1S/FqUw26gnBH8uHwFZZOva3GmkDC053SPy04La7MT11c3N
 mmMJSKh+uKY0uE64Qagr7vcClqehKonOOKYupwRdeiEBsmj/MA9D58dAjziTCv6TH/O8NO5/Y
 FNe+Zsg312kFmloD18241Rghh/VQG016a+YTwFvaCoClxGmIqITJU3IiW8725+qqXAUFhstaj
 1toWGWOANy/1x3JG77cq7Is0n/mforeG4L7Wih7coapCaS4Up8ctu+9uXYOKAyHFiTpWMPqYl
 l0/nwetEXYFIAvoHK4xUTFY8KD+gVpJKXb5xntM8hiTfvyWqJilKYcMDQMqeB006OAh4CSXTa
 H9KmitBntCKG9NPBwRgNrPWnozFYJtFqxi8NXBWKOCVJ7jEtRO1w9slOc60/WvNFmFYFSuYGg
 K34rIuwB/03OBErKjyVPuIgUJGcEgny3io7rw48c2NuKh/RYBwKrVOivvUJXNEU6gBzF71s9k
 fxPzFGc9c24oV2ZkKvWzC5Krvvq8/pqweITeTrYabcBa8PT4JKSPFNtp+G7S6UMw9RVj0X2kb
 obX9cFJft+IRRsE8u+rGKIzNYhtbqPyrwlYokX8VyC9UUDvuX722tIjWJNCOSoa/6zWuwJlQy
 FBl0FEBJ1sdrwo+x+lu3IMvBSJFDf3fGRQtz2KgaQ1BYKXfsH/OjlWRAtgygSqecqT3mTCBsW
 4xWyGrkfFGBCI2tJZPFofQSgLbliPM9KY6lDhCrtHHNj0EAL/p3ePHXX+HtlTzMn1SpAqT+GO
 VM0DsMv37e6Y0kU5mVXm060eqXYzbAQV7JCz4I1iS5RxEQJ+anrdh4+UcIKLo1vqzP9S/1DqO
 UDqbitTux+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-60783448-1551713358=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Jonathan,

On Mon, 4 Mar 2019, Wendeborn, Jonathan wrote:

> > Right now, you have some choices: 
> > • Volunteer to implement reftable. 
> > • Since you're on Windows 10, set your Git repository directory as 
> >   case-sensitive. 
> > • Use Windows Subsystem for Linux, which is case sensitive and creates 
> >   directories with that flag (even on NTFS), to do your import. 
> > • If you control the fast-export output, adjust the arguments you pass 
> >   such that the output does not contain one of the offending tags. 
> 
> Hi Brian,
> 
> Thank you very much for your answer!
> 
> Unfortunately I am stuck with Windows 10 1703 which neither supports
> case-sensitivity nor any Linux subsystem from the Microsoft Store :(

Too bad.

> Also, my employer unfortunately doesn’t allow me to invest the time to
> implement reftable,

Even worse!

> so I guess I go with manually leaving out the one conflicting label I
> found and tagging it manually afterward.

That is a valid workaround.

> One thing I still would like to encourage to is to improve the error
> message which is really misleading in this case.

Well, that is at least something you could do. After all, you use a
volunteer-driven project, so you could at least volunteer a little time to
improving it yourself.

Ciao,
Johannes
--8323328-60783448-1551713358=:45--
