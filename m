X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Only warn about missing branch.<n>.merge in pull.
Date: Tue, 19 Dec 2006 11:30:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612191128500.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061218091206.GA11284@spearce.org> <7virg9xcvw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612182135360.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612190159.58658.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 10:31:06 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612190159.58658.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34815>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcF5-00010v-Su for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932759AbWLSKaf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWLSKaf
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:30:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:49284 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932759AbWLSKae
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 05:30:34 -0500
Received: (qmail invoked by alias); 19 Dec 2006 10:30:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp014) with SMTP; 19 Dec 2006 11:30:33 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Josef Weidendorfer wrote:

> On Monday 18 December 2006 21:43, Johannes Schindelin wrote:
>
> > However, I would actually reuse our versatile (often hated?) config  
> > handling:
> > 
> > [branch "xyz"]
> > 	remote = blabla # this is the default remote
> > 	merge = master # this is the default branch for the default remote
> > 	merge = pu for remote second # merge 'pu' if pulling from second
> 
> Looks a little bit confusing, but is fine with me.

Granted. Suggestions?

> I even would remove the need for the word "remote" in the second merge 
> line.

No. In Git, a line like

	blabla

would turn into a boolean named "blabla" being true.

Ciao,
Dscho
