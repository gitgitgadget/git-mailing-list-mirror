From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: keep leading slash when canonicalizing paths
 (fallback case)
Date: Fri, 5 Oct 2012 23:12:07 +0000
Message-ID: <20121005231207.GA22903@dcvr.yhbt.net>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-7-git-send-email-schwern@pobox.com>
 <20120728135502.GC9715@burratino>
 <5014387C.50903@pobox.com>
 <20121005070430.GA23572@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 01:12:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKH47-0001gb-9y
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 01:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab2JEXMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 19:12:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33002 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635Ab2JEXMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 19:12:08 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370BA3F89D;
	Fri,  5 Oct 2012 23:12:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20121005070430.GA23572@elie.Belkin>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207126>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Noticed by forcing the fallback on and running tests.  Without this
> patch, t9101.4 fails:
> 
>  Bad URL passed to RA layer: Unable to open an ra_local session to \
>  URL: Local URL 'file://homejrnsrcgit-scratch/t/trash%20directory.\
>  t9101-git-svn-props/svnrepo' contains unsupported hostname at \
>  /home/jrn/src/git-scratch/perl/blib/lib/Git/SVN.pm line 148
> 
> With it, the git-svn tests pass again.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for noticing this.
Signed-off-by: Eric Wong <normalperson@yhbt.net>
and pushed to my master at git://bogomips.org/git-svn
