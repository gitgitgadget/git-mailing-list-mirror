From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout --track: make up a sensible branch name if '-b'
 was omitted
Date: Mon, 11 Aug 2008 01:02:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808110058360.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vtzdu6nb7.fsf@gitster.siamese.dyndns.org> <7vvdya55ur.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vsktd51wg.fsf@gitster.siamese.dyndns.org> <A6E466C6-C3B5-40EB-940C-516CF4D02ADF@frim.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Mon Aug 11 00:59:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSJsJ-0008Cg-3r
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 00:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYHJW54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 18:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYHJW54
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 18:57:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:55589 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751163AbYHJW5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 18:57:55 -0400
Received: (qmail invoked by alias); 10 Aug 2008 22:57:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 11 Aug 2008 00:57:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4cIZSxA34eHUihjF97IdQahQI8ElerDOfH29qOk
	4+LgdIHBv/gLpE
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <A6E466C6-C3B5-40EB-940C-516CF4D02ADF@frim.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91897>

Hi,

On Sat, 9 Aug 2008, Pieter de Bie wrote:

> Changing the behaviour to mean "git checkout -b origin/master master" 
> will change the meaning, but who uses -b with an existing remote branch 
> anyway?

FWIW I am totally opposed to this kind of reasoning.  I consider it sloppy 
to make assumptions that might or might not be true, and to force 
a change that might be convenient to you, but is likely to hurt others.

Besides, your suggestion completely breaks consistency.  If somebody asks 
to name a new branch "origin/master" (and "-b origin/master" is _just_ 
_that_), then it is not Git's job to fix the user's mistake.  Just like it 
is not Git's job to fix when somebody said "git commit", but meant "git 
push".

After all, I might _want_ to create a local branch "origin/master", and 
you would just break the valid assumption that "-b origin/master" would do 
that for me.

Hth,
Dscho
