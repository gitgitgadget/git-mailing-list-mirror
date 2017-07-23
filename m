Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CA441F89D
	for <e@80x24.org>; Sun, 23 Jul 2017 03:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbdGWDvm (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 23:51:42 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:57256 "EHLO
        2.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbdGWDvm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 23:51:42 -0400
X-Greylist: delayed 3599 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Jul 2017 23:51:41 EDT
Received: from player726.ha.ovh.net (b6.ovh.net [213.186.33.56])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 973C762708
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 04:33:27 +0200 (CEST)
Received: from [172.31.18.214] (unknown [103.90.76.125])
        (Authenticated sender: jean-noel.avila@scantech.fr)
        by player726.ha.ovh.net (Postfix) with ESMTPSA id C4C6E2A007E;
        Sun, 23 Jul 2017 04:33:22 +0200 (CEST)
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
 <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
 <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
 <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
 <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
 <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
 <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com>
 <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
 <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com>
 <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jean-noel.avila@scantech.fr>
Message-ID: <2421d5f3-12ee-833b-72d8-de627fbfe26c@scantech.fr>
Date:   Sun, 23 Jul 2017 04:33:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------44B95F22952C1C6E3FC5C122"
Content-Language: fr
X-Ovh-Tracer-Id: 790100260400235485
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrhedtgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------44B95F22952C1C6E3FC5C122
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Le 22/07/2017 à 02:43, Jiang Xin a écrit :
>
> Benefit of using the tweak version of gettext:
>
> 1. `make pot` can be run in a tar extract directory (without git controlled).

This issue is real for packet maintainers who can patch the original
source and run their own set of utilities outside of a git repo. This
can be possible with Junio's proposition by writing the files to a
temporary directory before running the xgettext, then removing the
temporary directory.

Please note that with respect to this issue, the patched xgettext
approach is completely disruptive.

> 2. do not need to run `git reset --hard`.

Same as before.

> 3.  it's quick (nobody cares).
>

Requiring patched tools is really breaking collaboration. Git made a
great case of relying on standard tools (not even GNU versions), so that
would really go backward.


Plus, I hope that some day, instead of translators finding afterwards
that a change broke i18n capabilities, developpers would have some kind
of sanity check. Requiring special versions of i18n tooling stops this hope.


--------------44B95F22952C1C6E3FC5C122
Content-Type: text/x-vcard; charset=utf-8;
 name="jean-noel_avila.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jean-noel_avila.vcf"

begin:vcard
fn;quoted-printable:Jean-No=C3=ABl AVILA
n;quoted-printable:AVILA;Jean-No=C3=ABl
org:SCANTECH FRANCE
adr;quoted-printable:Savoie Technolac, BP244;;34, All=C3=A9e du Lac d'Aiguebelette;Le Bourget du Lac;;73374;FRANCE
email;internet:jean-noel.avila@scantech.fr
title:Embedded Systems Manager
tel;work:+33 479265450
tel;cell:+33 633046418
x-mozilla-html:FALSE
url:http://www.scantech.fr
version:2.1
end:vcard


--------------44B95F22952C1C6E3FC5C122--
