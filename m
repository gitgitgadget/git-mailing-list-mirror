X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Wed, 13 Dec 2006 11:42:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131137100.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
 <200612111147.44964.Josef.Weidendorfer@gmx.de> <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net>
 <200612130415.59038.Josef.Weidendorfer@gmx.de> <7v1wn4mk9i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 10:43:01 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wn4mk9i.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34204>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuRZZ-00074t-Of for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932395AbWLMKmp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 05:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWLMKmp
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:42:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:53537 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932447AbWLMKmo
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 05:42:44 -0500
Received: (qmail invoked by alias); 13 Dec 2006 10:42:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 13 Dec 2006 11:42:42 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Junio C Hamano wrote:

> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > No. It currently is starting to get useful. With the ability
> > to temporarily store away a dirty state of the working directory,
> > it really could become very good.
> 
> Hmm, a way to easily stash away local changes and restoring
> would lead to a system where you can easily stash and unstash
> multiple snapshots and switch between them, and such a model
> sounds vaguely familiar...

Hmm, what might that be? :-)

A more simple approach than to buy into Python would be to introduce a 
very simple program, which exchanges work directory contents with index 
contents. So,

$ git revolve-stage
$ [test the staged revision]
$ [possibly fix a thing or two]
$ git revolve-stage
$ git commit

Opinions?

Ciao,
Dscho
