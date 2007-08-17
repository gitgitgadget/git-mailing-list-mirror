From: Mike Hommey <mh@glandium.org>
Subject: Re: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 18:56:55 +0200
Organization: glandium.org
Message-ID: <20070817165655.GA13891@glandium.org>
References: <20070817163034.GA11151@glandium.org> <Pine.LNX.4.64.0708171751360.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 17 18:58:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM59Y-0005lN-3o
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 18:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765551AbXHQQ5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 12:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765552AbXHQQ5y
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 12:57:54 -0400
Received: from vawad.err.no ([85.19.200.177]:50543 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992AbXHQQ5x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 12:57:53 -0400
Received: from aputeaux-153-1-51-63.w82-124.abo.wanadoo.fr ([82.124.11.63] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IM58s-0007R8-Km; Fri, 17 Aug 2007 18:57:49 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IM583-0003cH-V4; Fri, 17 Aug 2007 18:56:55 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708171751360.20400@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56066>

On Fri, Aug 17, 2007 at 05:52:52PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Fri, 17 Aug 2007, Mike Hommey wrote:
> 
> >   ?   committer name and email and the commit time.
> >   If not provided, "git-commit-tree" uses your name, hostname and domain to
> >   provide author and committer info. This can be overridden by either
> >   .git/config file, or using the following environment variables.
> >   (...)
> > 
> > The "If not provided" part doesn't make sense.
> 
> It does, if you know how to specify the committer info.  Which the man 
> page specifies how to provide:
> 
> This can be overridden by either `.git/config` file, or using the 
> following environment variables.
> 
>         GIT_AUTHOR_NAME
>         GIT_AUTHOR_EMAIL
>         GIT_AUTHOR_DATE
>         GIT_COMMITTER_NAME
>         GIT_COMMITTER_EMAIL
>         GIT_COMMITTER_DATE
>         EMAIL

This is exactly where the man page doesn't make sense to me. It tells
you that if you don't provide committer name, etc. it uses your name,
hostname, etc., and you can override this with .git/config or the
environment variable you listed.

So where were you supposed to provide these informations in the first
place ?

Mike
