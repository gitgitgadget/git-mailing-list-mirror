From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Missing files
Date: Wed, 19 Jul 2006 19:48:15 -0700
Message-ID: <20060720024815.GC31763@localdomain>
References: <b6327a230607191902n47b81993x8caea2df3955d8c0@mail.gmail.com> <b6327a230607191909tf48c4f8nc551b732523cca3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 04:48:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3OaM-0007qk-1O
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 04:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWGTCsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 22:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWGTCsS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 22:48:18 -0400
Received: from hand.yhbt.net ([66.150.188.102]:23228 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964893AbWGTCsS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 22:48:18 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 1CABD7DC022;
	Wed, 19 Jul 2006 19:48:16 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 19 Jul 2006 19:48:15 -0700
To: Ben Williamson <benw@pobox.com>
Content-Disposition: inline
In-Reply-To: <b6327a230607191909tf48c4f8nc551b732523cca3e@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24015>

Ben Williamson <benw@pobox.com> wrote:
> Oh. I just looked in git-svn and found this:
> 
> $VERSION = '1.1.1-broken';

I removed the version tag and started using GIT_VERSION when git-svn
moved out of contrib/ a few weeks ago.

As far as I remember, I don't remember git-svn having problems with
missing files.  There has been a bug where it got extra files from other
places in the repository, but that's fixed.

May I ask if you have the Perl SVN:: library bindings installed?  If so
1.1.1-broken (and all versions afterwards) will automatically. use them
(if the SVN library version is >= 1.1).

Nevertheless, I'm running an import right now (with the SVN:: libraries enabled)
and will make another run with them disabled (which is kind of slow).
I'll keep you posted...

I've actually been getting a lot of real-world git-svn usage in the past
few weeks (and hence the lack of git-related work) and haven't noticed
any major problems.

> Fair enough. So far I haven't explored other branches in git.git, I've
> no idea what "pu" stands for. Can someone point me in the right
> direction?

pu is "potential updates", it's very bleeding edge.  next is a few steps
ahead of master, which should be the safest of the three.

-- 
Eric Wong
