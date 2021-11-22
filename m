Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2B5C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbhKVMDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:03:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:58189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhKVMDx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637582436;
        bh=qXsDP0vLK7F41hYR4rVu68HeTqMrcig9KdK4TpEfBeg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B0fSFJwnRTW0l9en9LdGLLgfOLDvf0yaHyqBC6mQ3gGs8sZJuRNb8RwSA/Js24upP
         qHZyH/puN5ZRWeZ4bTZpoC/g1DQs0F0X9fIUS+wEQ6OoHlKioyxiTF/YJyrdBCdzXH
         u/eAiBEQpYAz39tPXFLzMhcTLdKPYLv+NOZvSkDo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1mMymA0EIQ-00m62h; Mon, 22
 Nov 2021 13:00:36 +0100
Date:   Mon, 22 Nov 2021 13:00:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Aleen via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Aleen_=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v10 1/2] doc: git-format-patch: describe the option
 --always
In-Reply-To: <59bce7131dab858e8c87944ccb02eae8ba5fd459.1637567471.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111221258440.63@tvgsbejvaqbjf.bet>
References: <pull.1076.v9.git.1637564554.gitgitgadget@gmail.com>        <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com> <59bce7131dab858e8c87944ccb02eae8ba5fd459.1637567471.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1672421196-1637582436=:63"
X-Provags-ID: V03:K1:Gs8ka5b6xKU3jxJnZkCogv0Q7pQG9U6BpEWEXhKJSKcHaPwwJKW
 F07oHlCfftP6rmSgnTuQqWHBbH2M7mTzyLBGlDL+dJqxfheLE6zeD2OjjEkavCwXUJo/Zsa
 m+GIf4xsQHkiNb44qjAEcuktZB7xxzO2S5TL/fjUObhLr3fWUNmZViml2Qafihg27Hh6FLH
 gnTpFU0159jASJeGb14nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lboQD7l6umI=:b7MVuTkuXLSWGc9bpawvy1
 xUwlIg+YeFy2fRmKqdsWDMG5laALUnSQTgL3hEoSS0My9qbV7fZQMBqLKb6Rex2tHhP2D1dmv
 hPTlQemE1dWj08kUuQt1RyCDudXLsfbOdaObnWGFbhr4OqGB5+5G7UKt29ll2dJjZBrJD1T6I
 w2HQjnk2JrXP4NyoWGT4kcmiDrGIgdOPiWapVGqTc0Vw45IF7E/vWG1bz7lDrsHFM4w7V7708
 SBukejk/FgFRs6Iw2af8EV+DsRLBpev18YCYi/bmeZkFmq2SVbI0qqwjcLkGtEXYbPAgQEKO2
 acopB3W7SVjWjw+60gCFZs53NjOcmUvmbTfgZi2dmLT33j4pnmG5dtLt2SGioy1WLRD4Wu83q
 TDP2lmNps8FouJZni1NI6KaKCWmaOwE5nP7ZCRsFisX64hIDfXpRn3pdY3I5yiU62zva5d0uC
 DOkCCECKtlg2zmY6vcnPtYooCiU4zQ14i63pDSKRU1o6vN3qi7atTp9B6mTtqiBPVerASY+3l
 vSfVeokLwXhkYcQqAw7QGSC2VH4bD7GGST4PQXcWHBRDwsGUE8xvl1DWk99eF2gDpmfVZkTJL
 g1JMUxKbeuzchB3RWOfZu2sQ24KWPS1LI5HXQMbUEmOYlIwbxgpIILz/o14Ay3JcU8UDbnHJd
 AsbCE6Q0lD3AkWcdwWRAXVKel/su8/LzltU9pQ3orqlmg6pG7Gc+iGzDu3q+rGy4ebo+D/6/i
 wNWPgi6qjWVeZxFazV7PHbnr/1vGKByNh/DMiOqGehEVLzaR3lsrWpCqPvd0bmYco9ghK+Rj4
 cC3aBgz+a4rHF7WwvdehxmT8CSiJBDTCO+Y47x9AuGNGWI76tu3wktAS+JOSpAQ02tUtaIA5x
 pjGBqXxtyAgJjbaaipBGXpDrp89DL6C8nsoBXgH2vpIzK6lfPIQX2EFzuA7WH/d/SybC7mFH8
 lwf5vqwxNokQCmxpEn9/f8hQbmIRb+hx4AOnEBWrBktELWJubwgMQ+MStt0g4VKvzPXHDVe2k
 PgQqdhZ7uwsZfwxhP5Dr/vL7JYC5kt/0hNR3t3bvmrcIfFiQRTgBDKwwGwscOTBT7Jn4t0It3
 jySyPmrfzZIJxA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1672421196-1637582436=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Aleen,

On Mon, 22 Nov 2021, Aleen via GitGitGadget wrote:

> From: Aleen <aleen42@vip.qq.com>

FWIW this information comes from your commit, specifically from the
author information recorded when you committed first. To re-set it in
these two patches, run something like this:

	git config --global user.name "=E5=BE=90=E6=B2=9B=E6=96=87 (Aleen)"
	git rebase -x "git commit --amend --no-edit --reset-author" HEAD~2

and then force-push to your branch.

Ciao,
Dscho

--8323328-1672421196-1637582436=:63--
