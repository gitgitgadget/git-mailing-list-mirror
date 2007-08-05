From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Some ideas for StGIT
Date: Sun, 5 Aug 2007 09:39:40 -0400
Message-ID: <20070805133940.GA18835@filer.fsl.cs.sunysb.edu>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv> <20070804055110.GP20052@spearce.org> <f934ve$3oi$1@sea.gmane.org> <20070805023130.GV20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 15:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHgKh-0005gt-O4
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbXHENjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbXHENjp
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:39:45 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:49343 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbXHENjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:39:44 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l75DdemZ004316;
	Sun, 5 Aug 2007 09:39:40 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l75DdeeK004314;
	Sun, 5 Aug 2007 09:39:40 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <20070805023130.GV20052@spearce.org>
User-Agent: Mutt/1.5.16 (2007-07-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55016>

On Sat, Aug 04, 2007 at 10:31:30PM -0400, Shawn O. Pearce wrote:
...
[rebase is complex but fun]

Great, but does git have something that could replace
$QUILT_LIKE_APP refresh?

Sure, if you can take 2 commits and collapse them into one you could fake it
by creating a dummy commit with the new changes, and then collapsing, but
that's nasty - and reflog might not like that much :)

Josef 'Jeff' Sipek.

-- 
I'm somewhere between geek and normal.
		- Linus Torvalds
