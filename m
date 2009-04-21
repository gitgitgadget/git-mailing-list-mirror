From: Eric Wong <normalperson@yhbt.net>
Subject: Re: RA layer request failed while git-svn fetch
Date: Tue, 21 Apr 2009 11:04:08 -0700
Message-ID: <20090421180408.GC16642@dcvr.yhbt.net>
References: <f18356030904142031n2db32fcyc035a87b6797fee5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Li Feng <nemokingdom@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:07:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwKLx-0004g2-2W
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 20:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbZDUSEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 14:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbZDUSEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 14:04:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44830 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755177AbZDUSEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 14:04:08 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A1C1F7A0;
	Tue, 21 Apr 2009 18:04:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <f18356030904142031n2db32fcyc035a87b6797fee5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117143>

Li Feng <nemokingdom@gmail.com> wrote:
> Hi,
> 
> I don't know if this is a proper place for asking this
> question, let me know if it's not.
> 
> I use git svn to sync with the subversion repos:
> 
> $ mkdir prj && cd prj
> $ git svn init http://url/to/repos/branches/experimental
> $ git svn fetch
> 
> and got the error message:
> 
> RA layer request failed: OPTIONS of 'http://url/to/repos/branches/experimental':
> Could not read status line: connection was closed by proxy server
> (http://url/to/repos) at /usr/bin/git-svn line 1352
> 
> Why and how can I fix this?

Seems like a failed internet connection or the server or proxy went
down.  Does restarting git-svn work?  If not, I'd check with the SVN
repo with the regular SVN client...

-- 
Eric Wong
