From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 13:04:11 -0400
Message-ID: <20070817170411.GF28529@fieldses.org>
References: <20070817163034.GA11151@glandium.org> <Pine.LNX.4.64.0708171751360.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 17 19:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM5FE-0008Pd-Uf
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 19:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbXHQREQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbXHQREQ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 13:04:16 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54792 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753523AbXHQREP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 13:04:15 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IM5F5-0001e6-2X; Fri, 17 Aug 2007 13:04:11 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708171751360.20400@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56067>

On Fri, Aug 17, 2007 at 05:52:52PM +0100, Johannes Schindelin wrote:
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
> It does, if you know how to specify the committer info.
>
> Which the man page specifies how to provide:

At least on a first reading all of the following appears to fall under
the "if not provided" case.  I know what you mean, but the language here
is misleading.  One simple fix would be just to delete the words "If not
provided", or maybe replace them by "By default, ...".

--b.

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
