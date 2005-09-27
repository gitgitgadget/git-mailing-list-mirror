From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 08:54:37 +0200
Message-ID: <20050927065436.GL15165MdfPADPa@greensroom.kotnet.org>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
 <20050926212536.GF26340@pasky.or.cz>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 27 08:55:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK9Ma-0007L9-SB
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 08:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVI0Gyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 02:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVI0Gyp
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 02:54:45 -0400
Received: from smtp16.wxs.nl ([195.121.6.39]:4326 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S964832AbVI0Gyo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 02:54:44 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0ING0012KR71P3@smtp16.wxs.nl> for git@vger.kernel.org; Tue,
 27 Sep 2005 08:54:37 +0200 (CEST)
Received: (qmail 10707 invoked by uid 500); Tue, 27 Sep 2005 06:54:37 +0000
In-reply-to: <20050926212536.GF26340@pasky.or.cz>
To: Petr Baudis <pasky@suse.cz>
Mail-followup-to: Petr Baudis <pasky@suse.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, Git Mailing List <git@vger.kernel.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9375>

On Mon, Sep 26, 2005 at 11:25:36PM +0200, Petr Baudis wrote:
> So the strategy I'm thinking of now is to manually (I think no GIT tool
> can do that for me) dereference the possible tag chain until I end up at
> some non-tag object. 

If it _is_ a commit, you could use 
git-rev-list --max-count=1 $tag

It won't help you though if it isn't.

skimo
