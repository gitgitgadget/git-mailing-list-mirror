From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a 
 foreign vcs
Date: Wed, 5 Aug 2009 18:15:06 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051809500.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org>  <alpine.DEB.1.00.0908052251430.8306@pacific.mpi-cbg.de> <alpine.LNX.2.00.0908051658530.2147@iabervon.org>  <alpine.DEB.1.00.0908052319210.8306@pacific.mpi-cbg.de>
 <fabb9a1e0908051446t63942d21nf71ee0673bb85b8c@mail.gmail.com>  <alpine.DEB.1.00.0908052349250.8306@pacific.mpi-cbg.de> <fabb9a1e0908051453y3bb4b2fax2ab17608436510ca@mail.gmail.com>  <alpine.DEB.1.00.0908060004300.8306@pacific.mpi-cbg.de>
 <fabb9a1e0908051505h671ece4ekef8bb887865a8488@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 00:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYolR-0001ZM-JP
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbZHEWPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 18:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbZHEWPH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:15:07 -0400
Received: from iabervon.org ([66.92.72.58]:37896 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbZHEWPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:15:06 -0400
Received: (qmail 25681 invoked by uid 1000); 5 Aug 2009 22:15:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 22:15:06 -0000
In-Reply-To: <fabb9a1e0908051505h671ece4ekef8bb887865a8488@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125010>

On Wed, 5 Aug 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Aug 5, 2009 at 15:04, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > Yes, I agree: svn:http:// is much better.
> 
> Was that sarcasm? (I just realized that ':' is also a forbidden character)

svn:http://... clearly works on the transport side; it'll run 
"git helper-svn", not "git helper-svn:http". The helper would have to know 
not to run svn with the URL being svn:http://... (which would probably 
cause it to use the native svn protocol), of course.

	-Daniel
*This .sig left intentionally blank*
