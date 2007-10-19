From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] allow git to use the PATH for finding subcommands and
 help docs
Date: Fri, 19 Oct 2007 19:19:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710191917440.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071019065931.GB1463@srparish.net> <47185DAF.7060809@viscovery.net>
 <20071019130402.GD1463@srparish.net> <Pine.LNX.4.64.0710191616490.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071019164816.GA24573@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Parish <sRp@srparish.net>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 19:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IivVj-0005u1-AN
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 19:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942AbXJSRTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 13:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbXJSRTf
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 13:19:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:55430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762203AbXJSRTf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 13:19:35 -0400
Received: (qmail invoked by alias); 19 Oct 2007 17:19:33 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp027) with SMTP; 19 Oct 2007 19:19:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19vJl56CMFvkjZegQAZRbxDVmXzYSf7F8mzODJbDO
	PBdBF9l0GymTMj
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071019164816.GA24573@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61733>

Hi,

On Fri, 19 Oct 2007, Mike Hommey wrote:

> On Fri, Oct 19, 2007 at 04:27:39PM +0200, Johannes Schindelin wrote:
> > While reading this, I have to wonder why it is not just simpler to try 
> > with builtin_exec_path first, and if that fails, just let exec() find the 
> > program in the PATH?
> 
> Why not try the directory where the git executable is, too ?

I commented on that.  If the git command was not specified with an 
absolute path, then make it absolute (and only if not even a relative path 
was specified, ignore this altogether since git is in the PATH).

I was a bit terse on the issue I have to admit, though.

Ciao,
Dscho
