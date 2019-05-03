Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D151F453
	for <e@80x24.org>; Fri,  3 May 2019 09:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfECJr2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 05:47:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:50291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfECJr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 05:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556876844;
        bh=eYKoVCB1hLhaIGNf+UgOm4XqAh0p936STtz21J26PgQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gpP1Fqriox7q+ZO451e7zpwjc4C8+HwFQtvaZCPZAW965V6iWX8pzoN1dXs7IHRgS
         6jXDqQAWOJTap7lXorglzIn1Z9MF2S1q/otp/+okoCM3FPDF9AHeNuBD1hjFK7OG/g
         EtcqVlrbay46AyVQ7BdvGvhmPc6+vej48SLan+/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCcE2-1hVsRK13ju-009SK6; Fri, 03
 May 2019 11:47:24 +0200
Date:   Fri, 3 May 2019 11:47:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>, Aleksey Midenkov <midenok@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug: fatal: Unable to create '.../.git/index.lock': File
 exists.
In-Reply-To: <CACsJy8D7bx46bix_LmGr=xcwsrA=LehXmLmnONLz2w3q6f80vw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905031146490.45@tvgsbejvaqbjf.bet>
References: <CAF8BazDu_GqoCPBQ-gEJ+q8n1aWSjf_TOV7bDE5VCQkDgBjyfQ@mail.gmail.com> <CAF8BazA-VYFns7o9F7gXfFZCspbM0yQKi+LQ+BnkpGH+EjPC9A@mail.gmail.com> <CACsJy8DSW2f3v1KpU-QrAz-EeLwG4mVm9ToDdA2=kXSmtsEAYw@mail.gmail.com> <CAF8BazBShg9F2uCuVQ_PM6196kOUNWOA1T9APkCXCoey7as2mQ@mail.gmail.com>
 <20190430174110.GA16729@sigill.intra.peff.net> <CAF8BazBBP53uhh+oOroFuVCEL-FaqJheSYX5Q5_NQxGRt=g_xA@mail.gmail.com> <20190501183638.GF4109@sigill.intra.peff.net> <CAF8BazAK_s89XY8-AAsSSbgOFgP03CLRZ50bLGPsc89bfnN7kQ@mail.gmail.com> <20190502150701.GA14906@sigill.intra.peff.net>
 <CACsJy8Dimn9+ogDNEgy3xmLunyX_pStBq=g-1jrf74LsOW1xrA@mail.gmail.com> <20190502165802.GA19341@sigill.intra.peff.net> <CACsJy8D7bx46bix_LmGr=xcwsrA=LehXmLmnONLz2w3q6f80vw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j+LR68gdWbTSeOIp7H7D/mF0DbLoqflGYVQVSoSC4pvOrnUpU3h
 GY9EAIDCrY+gbvyxpCPKH7r/WCBFvkRvcEdz+NiHZ3/8ypOfcNuiDWvU8mMd360VgdcjsC0
 v3eCrb4x6ypRD3UIgFM253CQBncax9Z0jlIol65Oldfn06wUQ1ZeCOD3n4xX6Sn3+MWCm4O
 3NLE4dPyos8NJExxAzASw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yD6irn75LAc=:TVNsxfRLK/Kuayf+1F2y/F
 kzLHNVjQTGCoYoYUo1idCFODr+IqzODw5ZjSOsfLiTPi90DzWgqxbMQvLH8iM93qd1ovI6RsA
 gKnY31BCUDVdSASbeJSEDGkVZV7CIH9Bz4WmN2gYTOVmArui6ZfQImezdbsdVENf4i3B7qf/2
 OEyNc6MW5x+bYr1v2MMmflsUH0YDlBtEuqP3wEC7ym/YrElyquj/EeB9R8FgA+l2Va2jjG+yq
 f8VXiZeX7qN+6/T8n0IRqqa/LBIqa5ALf7CjUBYcLgeIB3R1o9Tu5C4Nf+zvZNMQTZOqgqqYn
 tj8Al2+JyDcKQZXZFkURSgx/DvEtcP7W4yxxuiBtqnmDkJZ8uArOrwiS/eHuJVU95f9AwW78m
 wEmSlSJlVsrlHVm/ufWF1Dm9krvAkYRfImJkmsP7cEsPNiXJXhIGw3H4J3OUWGnHjlwCMvhWB
 gB3JdtUIDs8HX4bVqckixnO+pbGvnNzDW73cCFvEuLFnSAlIDH2ROnyfEYKl+82v6GrAnNq76
 aTj5OYI5PiYGnT3wh3ArdRyrcvH+Iu3F1miCdW6nLcikRpGrcXy8lxXsUOjycBecccvo781bY
 Qf9tPTvXrfVK46nkNYi7N+ywKXLUG5Lspilfg4jbcO5/tCMYybCax6cbM6wvOjjBWtmaG/6RN
 kRzHxjiMphvHlpDwwXuZdUUeVTnS/XZXFuB70/5QVrKZtlecDfrT1cG4J8Dh6V0b2sRNO4ZYL
 NfGd33jX1AmdkcXJYRdOHJB40o57odOMFZDRJuqx+lMjNuLUVztIDt8DAfD1bmxbaLr2JhOE0
 xTjor/7R1yegxcL4LvS0SzTINluzGYAlKl2CvKJ/mESJ/e8LgjmkwmoRlG+QE9Tmjc/rdOsHd
 d+uaLgJo6n07Uqy+A2S395JYXr5UPOsNt6NsIkPPxPiMPZVWybTNofjtVD6bc0NN+BSCbw/Rh
 hr8a4O82J7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 3 May 2019, Duy Nguyen wrote:

> I have a feeling that most operations read the index unlocked,
> manipulate and only lock before writing things out. So yeah it's
> probably already racy.

IIRC there is a check for that, so it is not actually racy ;-)

Ciao,
Johannes
