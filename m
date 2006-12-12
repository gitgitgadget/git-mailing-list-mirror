X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding a new file as if it had existed
Date: Tue, 12 Dec 2006 13:07:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612121305430.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com> 
 <7vhcw1whfx.fsf@assigned-by-dhcp.cox.net> <7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 12:07:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34085>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu6Px-0005fQ-FC for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750703AbWLLMH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWLLMH0
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:07:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:56604 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1750703AbWLLMHZ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 07:07:25 -0500
Received: (qmail invoked by alias); 12 Dec 2006 12:07:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp018) with SMTP; 12 Dec 2006 13:07:24 +0100
To: Bahadir Balban <bahadir.balban@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Bahadir Balban wrote:

> On 12/12/06, Junio C Hamano <junkio@cox.net> wrote:
> > No.
> > 
> > I do not understand why not adding all the files you care about
> > eventually anyway in the initial commit is needed for
> > "performance reasons", if you do not touch majority of them for
> > a long time.  Care to explain?
> 
> If I don't know which files I may be touching in the future for
> implementing some feature,

When I use an SCM, it is to track the revisions of a project. It seems you 
are content to have only parts of a revision? That does not make sense to 
me.

> I said "performance reasons" assuming all the file hashes need checked 
> for every commit -a to see if they're changed, but I just tried on a 
> PIII and it seems not so slow.

Bingo!

You just felt the consequences of the "index".

Ciao,
Dscho
