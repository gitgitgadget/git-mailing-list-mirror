X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-show: grok blobs, trees and tags, too
Date: Thu, 14 Dec 2006 11:58:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141156290.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b7i92ez.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 10:58:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v3b7i92ez.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34312>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuoIX-0001dv-3h for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932503AbWLNK6m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWLNK6l
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:58:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:55672 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932481AbWLNK6l
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 05:58:41 -0500
Received: (qmail invoked by alias); 14 Dec 2006 10:58:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 14 Dec 2006 11:58:39 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +			ret = show_object(o->sha1, 1);
> > +			objects[i].item = (struct object *)t->tagged;
> > +			i--;
> > +			break;
> 
> Good hack ;-).

Tail recursion ;-)

It has a nice side effect, too: the _name_ of the object is not changed, 
so if you show a tag which references a tree, you will see the name of the 
tag as if it were the name of the tree.

Ciao,
Dscho
