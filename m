From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Allow using arguments to the editor.
Date: Thu, 19 Feb 2009 00:10:55 -0800
Message-ID: <20090219081055.GB21499@dcvr.yhbt.net>
References: <1234964869-11159-1-git-send-email-rhonda@deb.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerfried Fuchs <rhonda@deb.at>
X-From: git-owner@vger.kernel.org Thu Feb 19 09:13:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La41B-0004Uh-Ae
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 09:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbZBSIK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 03:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbZBSIK5
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 03:10:57 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:55064 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753085AbZBSIK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 03:10:56 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A391F5D0;
	Thu, 19 Feb 2009 08:10:55 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1234964869-11159-1-git-send-email-rhonda@deb.at>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110642>

Gerfried Fuchs <rhonda@deb.at> wrote:
> When setting the EDITOR or VISUAL environment variable, one might want
> to hand over arguments (like e.g. for not backgrounding a GUI editor but
> waiting for it to finish. This patch enables that posibility, before it
> did look for a program with the content of the variable, including the
> space as filename part. The change is in sync with regular behavior with
> various other tools, git itself included.
> 
> Signed-off-by: Gerfried Fuchs <rhonda@deb.at>

Hi Gerfried,

I wanted to do something like this a few weeks ago, but generically
enough to be used by other scripts (sh/perl/python/ruby/whatever...).

I haven't had time to follow up on it (and decide on a command-name),
but the thread starts here:

  http://mid.gmane.org/20090201025349.GA22160@dcvr.yhbt.net

-- 
Eric Wong
