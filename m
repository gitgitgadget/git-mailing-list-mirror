From: Jim Radford <radford@blackbean.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 10:54:23 -0800
Message-ID: <20051110185423.GA7212@blackbean.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 19:56:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaHZB-0002Zw-Oq
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 19:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVKJSya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 13:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVKJSya
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 13:54:30 -0500
Received: from cpe-66-74-186-186.socal.res.rr.com ([66.74.186.186]:46311 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S1751215AbVKJSy3
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 13:54:29 -0500
Received: from home.blackbean.org (localhost.localdomain [127.0.0.1])
	by mail.blackbean.org (8.13.4/8.13.4) with ESMTP id jAAIsNjB007654;
	Thu, 10 Nov 2005 10:54:23 -0800
Received: (from jim@localhost)
	by home.blackbean.org (8.13.4/8.13.4/Submit) id jAAIsN38007651;
	Thu, 10 Nov 2005 10:54:23 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11502>

On Thu, Nov 10, 2005 at 12:14:29AM -0800, Junio C Hamano wrote:
>    I think archimport part needs to be split out just like its
>    svn/cvs cousins,

I don't agree.  The chance of running git-archimport and not having
arch installed is significantly less likely than the chance of not
noticing that the git-archimport program exists because it was moved
into a separate package that you didn't know you needed to install in
the first place.

The main reason I see for splitting cvs and email import out is the
non-standard dependencies, cvsps and perl(Email::Valid).  While for
svn import it's to keep from requiring subversion-perl of everone who
installs git-core.  This dependency is added automatically, so you
cannot easily just ignore it like you can in the arch/tla case.

> and perhaps documentation into another separate package.

There is no need for a separate documentation RPM, since the
documentation is marked as such and rpm has a standard way to avoid
installing them (--excludedocs).

-Jim
