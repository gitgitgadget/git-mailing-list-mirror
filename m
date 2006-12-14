X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-show, was Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 11:25:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141121010.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com>
 <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612140113340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612132231050.18171@xanadu.home> <7vy7pb9eit.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612140855400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqm6anjz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 10:26:31 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vbqm6anjz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34301>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gunn9-0005re-Bu for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751847AbWLNKZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbWLNKZ4
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:25:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:37466 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751847AbWLNKZz
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 05:25:55 -0500
Received: (qmail invoked by alias); 14 Dec 2006 10:25:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 14 Dec 2006 11:25:54 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Wed, 13 Dec 2006, Junio C Hamano wrote:
> >
> >> One minor issue we may need to decide is what to do when show is
> >> given a tag object.  Personally I think the current behaviour of
> >> dereferencing it to commit is fine (people who want to see the
> >> tag can always do 'git-verify-tag -v').
> >
> > How about adding the command line option "--tag" to git-show, which makes 
> > it only show that tag. I'd also vote for a "--verbose|-v" flag to show the 
> > contents of the tag _before_ showing the referenced object.
> 
> Sounds sensible.  Please make it so.

Actually, I rethought it. A tag _without_ what it tags makes no sense. See 
my upcoming patch. And git-show really is as Porcelain as it gets, so it 
should Do What I Mean.

Ciao,
Dscho
