From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Allow curl helper to work without a local repository
Date: Wed, 4 Nov 2009 02:21:07 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911040211240.14365@iabervon.org>
References: <alpine.LNX.2.00.0911032149390.14365@iabervon.org> <fabb9a1e0911032132v5e76e4b6n559169ad43d9f7c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:21:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5aBA-0004xo-0m
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbZKDHVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 02:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbZKDHVE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:21:04 -0500
Received: from iabervon.org ([66.92.72.58]:33691 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbZKDHVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:21:04 -0500
Received: (qmail 25097 invoked by uid 1000); 4 Nov 2009 07:21:07 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Nov 2009 07:21:07 -0000
In-Reply-To: <fabb9a1e0911032132v5e76e4b6n559169ad43d9f7c0@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132051>

On Wed, 4 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Nov 4, 2009 at 03:52, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > This is the simple change to let remote-curl work without a local
> > repository for git ls-remote; it leave the transport-helper code assuming
> > that all helpers can list without a local repo, which happens to be true
> > of this helper, the only one in current git.
> 
> Add a capability for it? :P

That's the longer-term patch, yes. But doing anything meaningful with that 
requires communicating down to transport-helper that we're not in a local 
repo, which shades into reworking the whole setup/environment code. That's 
why I went with the easy patch for now, since it does fix the bug.

	-Daniel
*This .sig left intentionally blank*
