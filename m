Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24034C433E2
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 16:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2804207DF
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 16:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgH1QLR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 28 Aug 2020 12:11:17 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:46674 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1QLR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 12:11:17 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2020 12:11:15 EDT
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 94E204356E1
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 17:54:05 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:e110:de7a:39e9:b10d])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 16F2913F87C;
        Fri, 28 Aug 2020 17:53:32 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] po: add missing letter for French message
Date:   Fri, 28 Aug 2020 17:53:32 +0200
Message-ID: <2398329.Am1n9C2Xzm@cayenne>
In-Reply-To: <xmqq8sdzpu71.fsf@gitster.c.googlers.com>
References: <20200827223527.36788-1-sandals@crustytoothpaste.net> <xmqq8sdzpu71.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, 28 August 2020 01:04:02 CEST Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > Add the missing "e" in "de".  While it is possible in French to omit it,
> > that only occurs with an apostrophe and only when the next word starts
> > with a vowel or mute h, which is not the case here.
> >
> > Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> > ---
> > I noticed this the other day when trying to delete a remote branch that
> > I'd already deleted.  I'm not sure what the preferred approach is for
> > this, whether Junio should pick it up or whether Jean-Noël will want to
> > incorporate it first, but I've CC'd both so y'all can fight it out.
> 
> Unless it is in the pre-release period (in which case I'd prefer not
> to touch po/ myself at all, to give i18n/l10n teams a stable base to
> work from), I can take it dircetly as long as somebody from the l10n
> team for the language gives an Ack, as I cannot read most of the
> files under po/ directory.
> 
> Thanks.
> 

Acked-by: Jean-Noël Avila <jn.avila@free.fr>


> 
> >  po/fr.po | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/po/fr.po b/po/fr.po
> > index d20fc440ab..75b1e75f6a 100644
> > --- a/po/fr.po
> > +++ b/po/fr.po
> > @@ -6503,7 +6503,7 @@ msgstr "'%s' ne peut pas être résolue comme une branche"
> >  #: remote.c:1088
> >  #, c-format
> >  msgid "unable to delete '%s': remote ref does not exist"
> > -msgstr "suppression d '%s' impossible : la référence distante n'existe pas"
> > +msgstr "suppression de '%s' impossible : la référence distante n'existe pas"
> >  
> >  #: remote.c:1100
> >  #, c-format




