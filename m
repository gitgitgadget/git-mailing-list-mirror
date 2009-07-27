From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Question about fixing windows bug reading graft data
Date: Mon, 27 Jul 2009 21:31:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907272129550.8306@pacific.mpi-cbg.de>
References: <63BEA5E623E09F4D92233FB12A9F794303117E06@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F7943033B2744@emailmn.mqsoftware.com> <alpine.DEB.1.00.0907271948130.6883@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 21:31:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVVv8-0002Sh-Gr
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 21:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbZG0Tb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 15:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbZG0Tb3
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 15:31:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:54007 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751484AbZG0Tb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 15:31:28 -0400
Received: (qmail invoked by alias); 27 Jul 2009 19:31:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 27 Jul 2009 21:31:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GOb8p+pAG1WRayDd9D8eOzmTNyqC/lBFYMr20gP
	1ZMX4wXVaL/hvT
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0907271948130.6883@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124187>

Hi,

On Mon, 27 Jul 2009, Johannes Schindelin wrote:

> But a few files come to mind which might have CR/LF line endings and 
> need to be interpreted correctly by Git: "grafts", as you pointed out, 
> but also the refs and of course the config.

Forgot at least one: objects/info/alternates.

And this one was a very real issue on my side, when I installed an 
alternate on somebody's Windows computer, and it did not work.  Should 
have used vi to begin with... :-)

Ciao,
Dscho
