From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: [PATCH] Add .git/version
Date: Thu, 17 Nov 2005 18:16:53 +0300
Message-ID: <20051117151653.GB3626@igloo.ds.co.ug>
References: <11322339372137-git-send-email-matlads@dsmagic.com> <Pine.LNX.4.63.0511171436170.13358@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 17 16:18:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EclW2-0007Um-Dc
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 16:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVKQPRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 10:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbVKQPRc
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 10:17:32 -0500
Received: from metronet39.infocom.co.ug ([217.113.73.39]:61445 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP
	id S1751031AbVKQPRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 10:17:31 -0500
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id D51155160
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 18:19:02 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.54)
	id 1EclVN-00012B-W3
	for git@vger.kernel.org; Thu, 17 Nov 2005 18:16:54 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511171436170.13358@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12117>

On Thu, Nov 17, 2005 at 02:39:21PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 17 Nov 2005, Martin Atukunda wrote:
> 
> > This patch series attempts to add .git/version support to init-db.c.
> 
> Wouldn't it make more sense to add the variable VERSION to git-var? After 
> all, git is designed to be backwards compatible; newer versions are 
> supposed to work with ancient repositories.
> 
> I think you are more interested in knowing which version the tools are at.

Actually this patch series is more a response to the thread
"Re: [PATCH] Disable USE_SYMLINK_HEAD by default" in  particular see
this message 200511160205.43443.Josef.Weidendorfer@gmx.de by Josef
Weidendorfer.

We've had at least one change that was backwards incompatible, though
this was in the ancient days of git development. This patch allows git to record what
version of the git tools created the repo we are dealing with. Just in
case future changes require this.

- Martin -

-- 
Due to a shortage of devoted followers, the production of great leaders has been discontinued.
