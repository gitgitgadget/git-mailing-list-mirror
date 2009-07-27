From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make 'git stash -k' a short form for 'git stash save 
 --keep-index'
Date: Mon, 27 Jul 2009 23:37:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907272336290.8306@pacific.mpi-cbg.de>
References: <cover.1248719786u.git.johannes.schindelin@gmx.de>  <76cdda0d6cf911449d16ebb86f54641620135fca.1248719786u.git.johannes.schindelin@gmx.de> <fabb9a1e0907271424x5495a228r779efe9794848880@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:37:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXsX-0004fD-N8
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 23:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145AbZG0Vg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 17:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755126AbZG0Vgz
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 17:36:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:41613 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754643AbZG0Vgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 17:36:55 -0400
Received: (qmail invoked by alias); 27 Jul 2009 21:36:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 27 Jul 2009 23:36:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AVRBoGEKARWwfSAaDzmZyGBe3Zy7c6J8YkxRQSE
	KynNvmayyl/Mgy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0907271424x5495a228r779efe9794848880@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124199>

Hi,

On Mon, 27 Jul 2009, Sverre Rabbelier wrote:

> On Mon, Jul 27, 2009 at 11:37, Johannes 
> Schindelin<johannes.schindelin@gmx.de> wrote:
> > To save me from the carpal tunnel syndrome, make 'git stash' accept 
> > the short option '-k' instead of '--keep-index', and for even more 
> > convenience, let's DWIM when this developer forgot to type the 'save' 
> > command.
> 
> +many, especially the DWIM part! Does it also grok 'git stash 
> --keep-index'?

Yes, it does, but it causes carpal tunnel.

Ciao,
Dscho
