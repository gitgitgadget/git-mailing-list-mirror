X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 20:04:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612121956470.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
 <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612121352520.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 19:04:44 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612121352520.18171@xanadu.home>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34128>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCvg-0006h2-QM for gcvg-git@gmane.org; Tue, 12 Dec
 2006 20:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751581AbWLLTEi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 14:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWLLTEi
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 14:04:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:57737 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751580AbWLLTEh
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 14:04:37 -0500
Received: (qmail invoked by alias); 12 Dec 2006 19:04:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 12 Dec 2006 20:04:35 +0100
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Nicolas Pitre wrote:

> On Tue, 12 Dec 2006, Johannes Schindelin wrote:
> 
> > On Tue, 12 Dec 2006, Linus Torvalds wrote:
> > 
> > > But since the thing needs mirroring for non-git uses too, and since 
> > > rsync generally _works_ apart from the slight race-condition issue, 
> > 
> > ... and git would probably change the pack structure (i.e. which objects 
> > are in which packs, or even loose) which would be too bad for all those 
> > HTTP leechers ...
> 
> I don't see how that would be more of a concern than the current 
> situation with occasional repacks.

Oh well. I did not want to get bashed for something which is probably no 
problem, but I suspected that the two mirror machines could get out of 
sync, which could well mean that the new packs would have to be downloaded 
_twice_. As I said, probably no problem.

But it would become a non-problem when the HTTP transport would learn to 
read and interpret the .idx files, basically constructing thin packs from 
parts of the .pack files ("Content-Range:" comes to mind)...

Ciao,
Dscho
