X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-show: grok blobs, trees and tags, too
Date: Fri, 15 Dec 2006 11:22:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612151121240.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <eltng7$te5$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1894957122-1166178121=:3635"
NNTP-Posting-Date: Fri, 15 Dec 2006 10:22:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <eltng7$te5$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34489>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvACg-0003PE-Tj for gcvg-git@gmane.org; Fri, 15 Dec
 2006 11:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751688AbWLOKWG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 05:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWLOKWG
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 05:22:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:56408 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751688AbWLOKWE
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 05:22:04 -0500
Received: (qmail invoked by alias); 15 Dec 2006 10:22:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 15 Dec 2006 11:22:02 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1894957122-1166178121=:3635
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 15 Dec 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > +For tags, it shows the tag message and the referenced objects.
> [...]
> > +EXAMPLES
> > +--------
> > +
> > +git show v1.0.0::
> > +       Shows the tag `v1.0.0`.
> 
> This changes semantic. Before this patch "git show v1.0.0" showed 
> _commit_, not a tag. Well, you can get commit using "git show 
> v1.0.0^{}"...

As Santi pointed out, this also shows the commit. Not only the tag.

Ciao,
Dscho

