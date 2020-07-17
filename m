Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEBCC433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B60B21744
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PWkiLA3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgGQM75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:59:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:56581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgGQM74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jul 2020 08:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594990794;
        bh=5fgY+ZF1TKtbSTqMhPaCB8Y40OeA1m3S2kGidVFmriM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PWkiLA3QiG5PGONNnTPDPrkaKsS/fS0pCD3kLMWMc+MmaRWC4l8fMIAgOfDq0P59g
         xs1OliwisB30OcsFrRDJMSpf/iGD+f1QTIVezQ/kKRBClYSkMYKTratU5K7GGxVoL0
         ZqqlFul4AlcPo4WKrNZg+VClMYYUP5/CNzvQaR5M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.237.98] ([213.196.213.77]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6m4-1khYUo2jro-00lTUK; Fri, 17
 Jul 2020 14:59:54 +0200
Date:   Fri, 17 Jul 2020 13:33:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Wolfgang Fahl <wf@bitplan.com>
cc:     git@vger.kernel.org
Subject: Re: git pull warning
In-Reply-To: <30eadf73-689a-b5fd-6e59-bfef4f48814b@bitplan.com>
Message-ID: <nycvar.QRO.7.76.6.2007171330010.54@tvgsbejvaqbjf.bet>
References: <30eadf73-689a-b5fd-6e59-bfef4f48814b@bitplan.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-233178749-1594985611=:54"
X-Provags-ID: V03:K1:d11QRYTF2l1j/NTDuMAF5xJHB5+O0+6w9kMteapDS0xUhBiEmjE
 mHIN9YiEXhoWRtTRcB0qC0N9JqPmTTlegoW2NnxJoy+TsW0s7iFbu72K04CAXfzGguQV3ap
 VNQLrriHyhJAMfEymGNDV016s/gFfVP2MzpFdhYul2yROxJQ9V8KGr8Yem6arg3pKNm8cXb
 Ly6dwtKp5jmEIdAkVRKiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tyCbGpC98rs=:Kyv0BrjfFF/qRXV4ee+xT8
 FNeEr3ILVXKXGbmzLZby/BLtyadHiPnmoCfgjHmjob9oW1ZB1Elq+94M2NOvksPNkCEpAqG/W
 uWIORkFU2ls/gGvk1QramJ/iUiJKhaLnBfaRJv2XJW8YNSbw1SLx4VRMaIG+5qkDPXQB82vhk
 Zsmqmht7FQixS3VvJw++qwcrqpdc+x4Y1xLBK5mGy7oJKI6nOMDzmfhC34dpuwvSOunFpRdVc
 2YctfECl34fIPnn8FYoSz8U6NgAo4cvKvU2zL3YptuoHLSumEhMSMWUO8v9rYmNbSnrw7XCjd
 5y25/AiKNZHBikQIczyky3/fr6VBm47DcMTtnfF2MF0jGzl+Vz6uOUmzh875+byUp1fVR/0K5
 8Y4VUWg1IMHJ8KtyuidYM2hq5b0TZJgW1QGwXRNCYl789nBYZ+uQ2f9GqyhCrljvuB3QkZW93
 EAQhYwrEOM/KpopfBjpsCgCHIEa0nqQ6X5ORpxk/D7h32yq8ZQ47rV9vVTJiqH++wOzhZnEh+
 0Ys/yZARz4FXEo9LEU4TlKgZJvUzpVMHwsQn4r5DAHDQnDLKj1GSCPdhQxV5sO1UDXl5SovGh
 tqR+cQcZ0GPtLS5mZzXFZpXXwbNPHbEMyBJaHtsIpbgJ7HCD0dWtk4QSyuq4R3VXlDJ9iAUCt
 mRWxWI20WmyTUkOCnnrge7G8g+zaa+RXkzpbisKHYYHU6KluLZQ603M+knfCLIBJ9h15rz2Ed
 XR7jDPzpCI2x9zBnuYKH8X72XwkxG1qBStQbVtSlVds6Hq8hraVf7JeXHPWr3eiGs9EQaQqQ6
 yVcLDXEmXZpo+vQIAbbZmu6o5cFxMD7ehGsCydf2zLtSmR9tOzV+mGrwoBjfK9kOoiDoSbTaz
 hLIYAuuPd+4MzmkAAprZMy6PIWHImdYFgOvmUa6kA42xZtI2KHiy7ssdq30OO7GPuK7YgI9q/
 Toz6w3n+wIEi5KIzcsjBKjHoejg0OU4SYaFIfcFNbWfGQNjvhugi4nrp7KhTnf3GI7CCynwsX
 OYJ40150R0SjzaJz6SVc7mADrFQRnHmfPMAfwq3VEpymeGcvijNpfqfhny8K8afreU+MwifUu
 8c7xRUDbubZ9xB7w/jLVgqPEp9iv1zupOcJHQUxrKL2pAQFyJco+Q5g5WwTcbzjgmbGVNeFgi
 UAkFM0muNpq8SvamUUaEQA6MAI2Cw6IcZyamMIiNfOmppDdcgNoWd7I2Mbgm/paGRi/xjNaBx
 w8R/31B4N5ZwwEwBVj53ZxmHzyad/6WsKUZVmww==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-233178749-1594985611=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Wolfgang,

please note that the language on this mailing list is English, it is a bit
rude to assume that every reader on this list will learn German just to
read your mail.

On Fri, 17 Jul 2020, Wolfgang Fahl wrote:

> [...]
> git pull
> warning: Es wird davon abgeraten zu Pullen, ohne anzugeben, wie mit
> abweichenden
> Branches umgegangen werden soll. Sie k=C3=B6nnen diese Nachricht unterdr=
=C3=BCcken,
> indem Sie einen der folgenden Befehle ausf=C3=BChren, bevor der n=C3=A4c=
hste Pull
> ausgef=C3=BChrt wird:
>
> =C2=A0 git config pull.rebase false=C2=A0 # Merge (Standard-Strategie)
> =C2=A0 git config pull.rebase true=C2=A0=C2=A0 # Rebase
> =C2=A0 git config pull.ff only=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # aus=
schlie=C3=9Flich Vorspulen
>
> Sie k=C3=B6nnen statt "git config" auch "git config --global" nutzen, um
> einen Standard f=C3=BCr alle Repositories festzulegen. Sie k=C3=B6nnen a=
uch die
> Option --rebase, --no-rebase oder --ff-only auf der Kommandozeile nutzen=
,
> um das konfigurierte Standardverhalten pro Aufruf zu =C3=BCberschreiben.
>
> Bereits aktuell.
> Was ist der Unterschied zwischen dem, was Sie erwartet haben und was
> wirklich passiert ist?
> the warning
> Sonstige Anmerkungen, die Sie hinzuf=C3=BCgen m=C3=B6chten:
> please remove the warning

You can, and should, remove that warning yourself by using the appropriate
call, as indicated by the very warning you want to suppress. In your
instance, the most likely course of action would be

	git config --global pull.rebase false

As this warning message was added intentionally, there is very little
chance that Git itself will remove it; You ware expected to configure the
behavior you desire.

Ciao,
Johannes

P.S.: I wonder whether it was such a good idea to translate the bug report
template, given that the primary purpose was most likely to allow
reporting bugs to the Git mailing list.

--8323328-233178749-1594985611=:54--
