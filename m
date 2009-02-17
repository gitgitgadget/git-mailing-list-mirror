From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: First round of UGFWIINI results
Date: Wed, 18 Feb 2009 00:49:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902180049110.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902171745320.6185@intel-tinevez-2-302> <bd6139dc0902170929g7215427clcf40348c01dfd10e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZhM-0005NJ-Jd
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbZBQXs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752479AbZBQXs2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:48:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:42833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751413AbZBQXs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:48:28 -0500
Received: (qmail invoked by alias); 17 Feb 2009 23:48:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 18 Feb 2009 00:48:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XUBJsscrXPHSgY4JUNMLtaZRFtDM7zoFsHBWIoj
	upcHQn+M/KL+rv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <bd6139dc0902170929g7215427clcf40348c01dfd10e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110479>

Hi,

On Tue, 17 Feb 2009, Sverre Rabbelier wrote:

> On Tue, Feb 17, 2009 at 17:47, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > I managed to collect 10 candidates already, and since I did all the hard
> > work of collating them, I took the liberty of ordering them into a very
> > subjective order of ugfwiininess (pronounced "You-gah-wee-knee-ness").
> 
> How about using git to do a temporary 'svn stash'?
> If you have changes in your svn working copy that you cannot commit
> just yet, but you want to check out an earlier revision for whatever
> reason, the current only solution in svn to that is to have a second
> working copy. But no longer!
> $ cd path/to/svn/repo
> $ git init && git add . && git commit -m "save svn state"
> $ svn revert -R *
> $ svn update -r 42
> $ # do whatever you need to do here
> $ git reset --hard && rm .git
> 
> Does that qualify? ;)

Heh, do you actually use it?

Ciao,
Dscho
