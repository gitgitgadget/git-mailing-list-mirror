From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Wed, 21 Nov 2007 15:46:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211544510.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
 <fi1heo$u4i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, sbejar@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:46:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IurmV-00059B-QY
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbXKUPqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750696AbXKUPqI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:46:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:48196 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751192AbXKUPqH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:46:07 -0500
Received: (qmail invoked by alias); 21 Nov 2007 15:46:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 21 Nov 2007 16:46:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19i8OMOFvpiHDETnaHW2RNx8qtiP8JIhJpfnx/aGA
	CQufLYSfBb2v3y
X-X-Sender: gene099@racer.site
In-Reply-To: <fi1heo$u4i$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65666>

Hi,

On Wed, 21 Nov 2007, Jakub Narebski wrote:

> Santi B?jar wrote:
> 
> > 3) I can "git fetch" a bundle but I cannot "git push" a bundle, so if I have:
> > 
> > [remote "bundle"]
> > ? url = /file/to/bundle
> > ? fetch = "+refs/heads/*:refs/remotes/bundle/*"
> > 
> > $ git push bundle
> > 
> > would create a bundle in /file/to/bundle with the same branches as a
> > normal git push, but considering the remote branches as the local
> > remotes/bundle/*
> 
> And how you would differentiate between path meaning bundle, and path 
> meaning "local" protocol, i.e. git repository on the same filesystem? 

Maybe because the git repository is specified as an existing directory?  
The bundle is specified as a (possibly non-existing) file...

Hth,
Dscho
