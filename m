Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C638C1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 01:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732582AbfBSBIw (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 20:08:52 -0500
Received: from mail.pdinc.us ([67.90.184.27]:40046 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732571AbfBSBIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 20:08:52 -0500
Received: from blackfat (five-58.pdinc.us [192.168.5.58])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id x1J18kf8020361
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 18 Feb 2019 20:08:47 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail1.pdinc.us x1J18kf8020361
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1550538527; bh=/rRQWDtjZbL3aezlYYJqalmYcuEr+aBjgY0cABnTIJk=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=YGS8tu59h9S8WsrFimZTRFwnY5s+V6qLNwEV+MJ9dIiOq+1IUS9jnI/ThNaMsvrKH
         5IHpSm/wz7kbwxVrypSRnb6G1f1grDV6NtZB7piYFIkJbWM3+0ulJWEaZF+zmKxadi
         w7B8ehx0V/tbqdehdUeIacbrgQOzZjwh+k9tRBRawXFtmWHrrnxrDslW2U/YjEKUzB
         GWeMRwrTqF3uyc2Jo4xpnBOibxNtsf5KfWAz9G3+tut51ZPzXV3MkN1sib4rBWPV8E
         pevL1XKWbGBr11nBDbo1T690yNjG8K2IbrKS4dH1Mnw2LwsM/uGO0Bvgasxz/Qv+92
         WTJUY74kdXGTA==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Cc:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Senol Yazici'" <sypsilon@googlemail.com>
References: <5c62b41d.1c69fb81.fe791.877b@mx.google.com> <CAFacdQ-soWD176VHgd+raHaV=VPpzKXrDrLFavPcNEoewZwBYA@mail.gmail.com> CAFacdQ-soWD176VHgd+raHaV=VPpzKXrDrLFavPcNEoewZwBYA@mail.gmail.com <5c657002.1c69fb81.d433c.32ce.GMR@mx.google.com> <CAFacdQ8NDKfd0p8=9Rh3s4FPeS9mbqpQt8mw3AZoJn9jHjriPg@mail.gmail.com> <nycvar.QRO.7.76.6.1902182158040.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902182158040.45@tvgsbejvaqbjf.bet>
Subject: RE: Delivery Status Notification (Failure)
Date:   Mon, 18 Feb 2019 20:08:50 -0500
Organization: PD Inc
Message-ID: <35a401d4c7ef$acf14070$06d3c150$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIG8tPn8ZhkYxBZqOqCto1UqajiFwGSg2oqAmc8qhwCvsNoFQKxUghvpTap7jA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Johannes Schindelin
> Sent: Monday, February 18, 2019 4:00 PM
>=20
> On Mon, 18 Feb 2019, Senol Yazici wrote:
> >
> > I just stumbled over following page
> >
> > https://git-scm.com/about/distributed
> >
> > and was wondering if it is possible to
> >
> > - demilitarise that =E2=80=9Cdictator/lieutenant=E2=80=9D thing and
> > - de-religionise that =E2=80=9Cblessed=E2=80=9D thing
> >
> > I did not had the feeling that git is =E2=80=9Cpro =
military=E2=80=9D, or is against
> > =E2=80=9Cnon religious=E2=80=9D developers/users.
>=20
> Those are valid concerns, and I value your feedback.
>=20
> It would probably be a good thing to change this, and you can even do =
it
> yourself: create a Pull Request to change this file:
>=20
> =
https://github.com/git/git-scm.com/blob/master/app/views/about/_distribut=
ed.html.erb
>=20

Curious, where are the sources for the PNGs saved? I did not find any =
obvious vector or art project files.

-Jason

