From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Invoke "gc --auto" from git commit
Date: Wed, 26 Nov 2008 13:37:09 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811261335320.30769@pacific.mpi-cbg.de>
References: <492C24B9.6090200@gmx.ch> <alpine.DEB.1.00.0811260056480.30769@pacific.mpi-cbg.de> <492C9FAF.4090407@gmx.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Wed Nov 26 13:30:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5JX9-0007ao-9d
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 13:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYKZM3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 07:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYKZM3B
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 07:29:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:59341 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751776AbYKZM3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 07:29:01 -0500
Received: (qmail invoked by alias); 26 Nov 2008 12:28:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 26 Nov 2008 13:28:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ofRMd8XuoYQEpVCMc4HjVVXorIt5KFEigC16ZSk
	aYtgYn2FLTLdjD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <492C9FAF.4090407@gmx.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101729>

Hi,

On Wed, 26 Nov 2008, Jean-Luc Herren wrote:

> As for the performance impact, on my machine 'git gc --auto' runs
> 500 times per second in a loop on the git repository (it won't
> call the hook unless repacking is necessary).

Ummm.

How many people do you think share your luck?  git.git is _small_.  Your 
machine is _fast_.  It is the typical mistake in IT, not thinking about 
real-world cases...

Ciao,
Dscho
