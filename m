Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A0C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJTRYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJTRYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 13:24:09 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F11B90DD
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666286646; bh=8arSL98nR4P0B5cyymTLSbHWUkpPOjB84cOP3lMO/EA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=n+5wThcONQtyqymT31sWYPfGrabIi3+68gTgDAeREC1ui2INmXmEnZzR1jd+USvOK
         1JdZmDIC3Ni6vlwbFxM2nJaUyUcl9wKW/FqZxsJ4lcjk4VkiN3Hd+bWgZl2tVnwIw1
         tRnhtmbm0akvt4360aoIJm2RoFjbYqZgKeZdeV8kPBDmZQJHX0F/wDZYbihBIzZkk3
         WRfUwn62uzD/HxnOR0jgqIuXDD1gnn/2NkfsgEbNk4uaj6TuJaP/xaoApQ6P7aMl5K
         zm7w8KUtmbk4UY7fTOO2OtE7ARKBSwk6kJiPQ37fvC0aXuZoQoirHqebT9S/W9nyW0
         2t26UYrocVoMw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOUxu-1oTVmt3x2E-00QFaQ; Thu, 20
 Oct 2022 19:24:06 +0200
Date:   Thu, 20 Oct 2022 19:24:05 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "W. Ekkehard Blanz" <ekkehard.blanz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cloning remotely under git for Windows not working
Message-ID: <20221020172405.oet6twwiehpjemkd@tb-raspi4>
References: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5E2E10BE-6EEB-4C78-A489-5899400DA937@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:MUb12cqPpKLjo+xeusSrHPUnUC3K5sxt70hrZXxmGNL+gJMXj+8
 FaJ7SSXZYXCy8jlDUlrCtQ/qONAMwz+ued+LpdUzb3hPfC/cOai4Yfg2d0m9mcBLi+1jTIv
 qpi9VTlcg9PDzA+Gs6BYEx3XImszzBR/RH9amo6WEHKQx7yjxdVkdVFqxuHrajq3h2MFi1m
 UTzfJfEprdX8RrwktwqMQ==
UI-OutboundReport: notjunk:1;M01:P0:6/ixP9vVPzE=;/pjMFy6XLfUt0iLlsSq0AOBbBQ9
 4K3nMQHRwIKrLUWaop7lXwjJBL84uRVpSyd0PsoVFWUgGwdcdk0hAOkHF37Yi6XpQcmcb8CeH
 56eQGlVBFsF2OdnasxesJJxiD1fymEznWiFvtx4kT7un8mjOx4fghqL9FjTLEU69lrRsBfMNC
 KCDw+bZWnERX4ueY5XDLwkHD5CrLzto1DUFsiSV3remPboQF0mX75+5NII+TCmXA3/KCYRifh
 uhpObZn83rLc2RiWyvKtkNq8LSz7o/L7P8PpvXa0xp5235ZqSyLa9D6u+a4vDC6JlwqLtIdzc
 9cP/QWfv4EPcw1KPTlu+fWKd4h0eRiUnTyGYwwrCjiYDzjiSIosTned4gn/6ZkGwEcoZQykDg
 DNtPaEVfzP6WuY/VhJeiZmRWL5lSU/h1k+3/G4mfypkKW10SQ61sB2ia1ptxfed2r1bhTd9JZ
 9TUMBEpsuxCLfATNxl8FJK7SToDUHm8TYLZZ10/BnKECLvoK3SKCfpZgisnHlStHkCFYv8fOz
 YRT2ImU1ZwnbHIccxT04c/QvHa5BBBrdUOX96nV5tOzcitLqbtmJtO4al4lHIQFKdFDZ9a5pm
 5TwgbiIVNgsWqhHYc84bhK26ZnYKpPLwlaU6Vz7A2TKRqaNAiwcA86BBJNc9Ui9JdzXPbo2xx
 vvvcuFDWAL/T4h2uydcpnSv35PlKHjZVrbMwwryDcgQXjtjHqtiW+5Koj+ckopPTUCPQj5Bhg
 QnLZappLL3AnNXM5rNCdCpN9Ml2sm1DUn+wluGGaSmZCYi6Pfv+gvD6bL6F/CN/JAjY6ovIAA
 XX1vyfDHT5czagrbOL0oOWUA5cz1ZKkCh8RWg3vPPNHhFr/43ZJy686DZ/mllcRo7zCnsvmKU
 9xiOOoHTmGMl9EQbSwQEfAUEA//OdOya/EgHMVuNhLfC+m/S1q33/crgl8GuK+dkQWD5zcI2+
 Ncw04rPddp6KcNiCENqzqhBOUuY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 08:58:54AM -0700, W. Ekkehard Blanz wrote:
> I am almost certain this is not a bug but a deficiency in my understandi=
ng.  But I can't be certain.  Here it goes...
>
> I copied an existing and valid bare git repository to a brand new Window=
s 11 machine (10.0.7.181) into D:\gitDepot\test.git
>
> The problem is that from any other machine on the LAN (Kubuntu 20.04, Ra=
spberry Pi running buster, an M1 MacBook Pro running macOS Monterey 12.6, =
 and a Windows 10 box), I cannot clone it remotely.  I made sure ssh works=
 correctly on all machines.  If I clone locally on the Windows 11 box wher=
e the repository resides, it works just fine.  Version of git on the Mac i=
s 2.30.1, on RBPi 2.20.1, the one on Linux is 2.25.1, and Windows 10 and W=
indows 11 are running the git version 2.38.1-6  I downloaded the day befor=
e yesterday. Since both Windows boxes are running the latest version of gi=
t (for Windows), I'll focus on these.  Here is the output from trying from=
 the Windows 10 machine via the LAN (but Linux, RBPi, and Mac are equivale=
nt, modulo the dreaded backslash quirks on all non-Windows machines):
>
>    $ git clone 10.0.7.181:D:\gitDepot\test.git
>    Cloning into 'test'...
>    username@10.0.7.181's password:
>    fatal: ''D:\gitDepot\test.git'' does not appear to be a git repositor=
y
>    fatal: Could not read from remote repository.

This is somewhat out of the blue,
did you try

git clone 10.0.7.181:D:/gitDepot/test.git

What result do you get ?
