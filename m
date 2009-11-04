From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 11/13] Allow helpers to request the path to the .git
  directory
Date: Wed, 4 Nov 2009 18:25:43 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911041819560.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>  <1257364098-1685-12-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041621400.14365@iabervon.org>  <fabb9a1e0911041406tce0956ai2ad3fe6cfbdc546d@mail.gmail.com> 
 <alpine.LNX.2.00.0911041723010.14365@iabervon.org> <fabb9a1e0911041442k493c5d7cx493c2e5dac9d892c@mail.gmail.com>  <alpine.LNX.2.00.0911041748150.14365@iabervon.org> <fabb9a1e0911041518h9e3d07dneba3056848e98f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 00:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5pEt-0004dg-Km
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 00:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933125AbZKDXZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 18:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933082AbZKDXZj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 18:25:39 -0500
Received: from iabervon.org ([66.92.72.58]:55053 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932851AbZKDXZj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 18:25:39 -0500
Received: (qmail 7884 invoked by uid 1000); 4 Nov 2009 23:25:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 23:25:43 -0000
In-Reply-To: <fabb9a1e0911041518h9e3d07dneba3056848e98f3e@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132171>

On Thu, 5 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Thu, Nov 5, 2009 at 00:17, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > Well, gfi is used with different native systems, each of which will
> > presumably put it somewhere different.
> 
> Right, but I meant for git itself :). I assume that you meant that
> 'gitdir' (or 'infodir' , whatever) should return the same path,
> whatever we decide on?q

Yeah. I think the base that git uses wasn't decided on, although I may 
have missed that part of the thread. In any case, I do think it should be 
the directory passed to the helper.

	-Daniel
*This .sig left intentionally blank*
