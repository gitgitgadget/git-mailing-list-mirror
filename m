X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-show: grok blobs, trees and tags, too
Date: Fri, 15 Dec 2006 11:22:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612151122080.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <8aa486160612150118y44744533t16af6d3086ac6b21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-73354504-1166178169=:3635"
NNTP-Posting-Date: Fri, 15 Dec 2006 10:22:58 +0000 (UTC)
Cc: git@vger.kernel.org, junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <8aa486160612150118y44744533t16af6d3086ac6b21@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34490>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvADO-0003Tr-DO for gcvg-git@gmane.org; Fri, 15 Dec
 2006 11:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751759AbWLOKWv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 05:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWLOKWv
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 05:22:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:52462 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751759AbWLOKWv
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 05:22:51 -0500
Received: (qmail invoked by alias); 15 Dec 2006 10:22:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 15 Dec 2006 11:22:49 +0100
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-73354504-1166178169=:3635
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 15 Dec 2006, Santi Béjar wrote:

> On 12/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > Since git-show is pure Porcelain, it is the ideal candidate to
> > pretty print other things than commits, too.
> 
> I think "git show ${tag}" should be more like "git show ${commit}",
> that is, with the tagger and date information and the indent, as:
> 
> $ git show v1.4.4.2
> tag v1.4.4.2
> Tagger: Junio C Hamano <junkio@cox.net>
> Date: ${Date}
> 
>    GIT 1.4.4.2
>    -----BEGIN PGP SIGNATURE-----
>    Version: GnuPG v1.4.5 (GNU/Linux)
> 
>    iD8DBQBFdx8+wMbZpPMRm5oRAsOXAJsGY8DIYey1TZlEXIGq5+8MNgEl1QCfQC0f
>    c5SmdLmAm2KPsCf+bCuoK+k=
>    =oDuA
>    -----END PGP SIGNATURE-----
> commit 49ed2bc4660c7cd0592cf21cc514080574d06320
> ...

Okay. You code it?

> > +EXAMPLES
> > +--------
> > +
> > +git show v1.0.0::
> > +       Shows the tag `v1.0.0`.
> 
> and the commit (or object) it references.
> 
> I would add:
> 
> git show v1.0.0^{}::
>      Shows only the commit referenced by the tag `v1.0.0`.

Okay. You provide a patch?

Ciao,
Dscho

