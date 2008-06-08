From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [TOY PATCH] git wrapper: show similar command names for an
 unknown command
Date: Sun, 8 Jun 2008 16:07:23 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806081607040.1783@racer>
References: <alpine.DEB.1.00.0806050747000.21190@racer> <20080607072721.GA3347@steel.home> <alpine.DEB.1.00.0806071603470.1783@racer> <20080607175103.GA5822@steel.home> <7vmylxnmnz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 17:09:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5MWZ-0005bx-IN
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 17:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbYFHPIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 11:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbYFHPIr
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 11:08:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:33690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753777AbYFHPIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 11:08:46 -0400
Received: (qmail invoked by alias); 08 Jun 2008 15:08:44 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 08 Jun 2008 17:08:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19q1SkjCyNqqck3eWKhPpksR2yeN106Biggj5/0bT
	EdxtQ14+2es8m+
X-X-Sender: gene099@racer
In-Reply-To: <7vmylxnmnz.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84277>

Hi,

On Sat, 7 Jun 2008, Junio C Hamano wrote:

> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Johannes Schindelin, Sat, Jun 07, 2008 17:04:14 +0200:
> >> -	for (i = 0; i < main_cmds.cnt; i++) {
> >> +	for (i = 0; i < main_cmds.cnt && i < 5; i++) {
> >
> > I accidentally considered "i" just the index in the global command
> > table. Of course it is better :)
> 
> That confusion however shows how hacky the approach to clobber the 
> main_cmds global table by stuffing other things in it and sorting, 
> without saying "who cares, we will exit after we are done with this 
> processing anyway".  If this patch were for inclusion, such a comment 
> should be there immediately before it starts to muck with the command 
> table.

This patch is not meant for inclusion, as indicated by the "TOY PATCH" 
prefix.

Ciao,
Dscho
