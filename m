Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97731F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 14:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932186AbcIAOho (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 10:37:44 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:20092 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754206AbcIAOhn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 10:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1472740659; l=1038;
        s=domk; d=aepfle.de;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Subject:Cc:To:From:Date;
        bh=H0Q7OBgQqlVk8uHydEuiDoK+FIIx1wd5kLNY64OTZ0o=;
        b=NScQV0Vc8m72r/Ay5GfmXIHRDFpR5ZHc3HOKoBHExiyuIVLYcMgsBas4FhhRSlI5b/0
        CWLd/d3uEijn/z12iODB+3RW848IQhjksdB+MlSTzZxpJmYHL6jSOZL9wm8HhctSAsuKp
        bB4Ak5C/+14yO15jmWGFraP2L0eXDzpfC+4=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWtqWFmrC5F/k8z92bXikQ==
X-RZG-CLASS-ID: mo00
Received: from probook (aftr-185-17-206-179.dynamic.mnet-online.de [185.17.206.179])
        by smtp.strato.de (RZmta 38.13 DYNA|AUTH)
        with ESMTPSA id 605a95s81EbbFAN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 1 Sep 2016 16:37:37 +0200 (CEST)
Received: by probook (Postfix, from userid 1000)
        id E3BD650AE4; Thu,  1 Sep 2016 16:37:36 +0200 (CEST)
Date:   Thu, 1 Sep 2016 16:37:36 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: implement a stable 'Last updated' in Documentation
Message-ID: <20160901143736.GA26242@aepfle.de>
References: <20150126172409.GA15204@aepfle.de>
 <xmqqd25zkeg7.fsf@gitster.dls.corp.google.com>
 <20150128080214.GA18851@aepfle.de>
 <xmqqbnlif6t9.fsf@gitster.dls.corp.google.com>
 <54CB5770.8030503@drmicha.warpmail.net>
 <20150130150758.GA3683@peff.net>
 <20150210151747.GA8965@aepfle.de>
 <20150210184318.GA20090@peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20150210184318.GA20090@peff.net>
User-Agent: Mutt/1.6.2 (6759)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, asciidoc made a move, so this patch is good to go:
https://github.com/asciidoc/asciidoc/pull/9

Thanks.

Olaf

On Tue, Feb 10, Jeff King wrote:

> On Tue, Feb 10, 2015 at 04:17:47PM +0100, Olaf Hering wrote:
>=20
> > On Fri, Jan 30, Jeff King wrote:
> >=20
> > > I have 8.6.9-3 installed (it is part of Debian testing/unstable now),
> > > and confirmed that:
> > >=20
> > > diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
> > > index 2c16c53..10c777e 100644
> > > --- a/Documentation/asciidoc.conf
> > > +++ b/Documentation/asciidoc.conf
> > > @@ -21,6 +21,7 @@ tilde=3D&#126;
> > >  apostrophe=3D&#39;
> > >  backtick=3D&#96;
> > >  litdd=3D&#45;&#45;
> > > +footer-style=3Dnone
> > > =20
> > >  ifdef::backend-docbook[]
> > >  [linkgit-inlinemacro]
> > >=20
> > > drops the "last-updated" footer.
> >=20
> > This does not remove "Last updated" from files like
> > using-merge-subtree.html for me, using asciidoc-8.6.8.
>=20
> Yes, the feature is part of 8.6.9-3.
>=20
> -Peff
