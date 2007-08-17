From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 17:52:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708171751360.20400@racer.site>
References: <20070817163034.GA11151@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 18:53:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM54V-0003U4-0C
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 18:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218AbXHQQxK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 12:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbXHQQxJ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 12:53:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:48936 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754371AbXHQQxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 12:53:07 -0400
Received: (qmail invoked by alias); 17 Aug 2007 16:53:04 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp019) with SMTP; 17 Aug 2007 18:53:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18c2IkvDzEcuNDeMZWjgb2lfVxNLFYt58K4nGZXS+
	EowOeiXlno/dO4
X-X-Sender: gene099@racer.site
In-Reply-To: <20070817163034.GA11151@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56064>

Hi,

On Fri, 17 Aug 2007, Mike Hommey wrote:

>   ?   committer name and email and the commit time.
>   If not provided, "git-commit-tree" uses your name, hostname and domain to
>   provide author and committer info. This can be overridden by either
>   .git/config file, or using the following environment variables.
>   (...)
> 
> The "If not provided" part doesn't make sense.

It does, if you know how to specify the committer info.  Which the man 
page specifies how to provide:

This can be overridden by either `.git/config` file, or using the 
following environment variables.

        GIT_AUTHOR_NAME
        GIT_AUTHOR_EMAIL
        GIT_AUTHOR_DATE
        GIT_COMMITTER_NAME
        GIT_COMMITTER_EMAIL
        GIT_COMMITTER_DATE
        EMAIL

Hth,
Dscho
