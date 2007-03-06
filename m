From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: mercurial to git
Date: Tue, 6 Mar 2007 18:08:02 -0500
Message-ID: <20070306230802.GA17226@filer.fsl.cs.sunysb.edu>
References: <20070306210629.GA42331@peter.daprodeges.fqdn.th-h.de> <20070306215459.GI18370@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:08:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOilW-0005l3-CU
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbXCFXIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030655AbXCFXIP
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:08:15 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:48670 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030649AbXCFXIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:08:15 -0500
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l26N82UZ018138;
	Tue, 6 Mar 2007 18:08:02 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l26N82fX018136;
	Tue, 6 Mar 2007 18:08:02 -0500
Content-Disposition: inline
In-Reply-To: <20070306215459.GI18370@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41611>

On Tue, Mar 06, 2007 at 04:54:59PM -0500, Theodore Tso wrote:
...
> The other thing that I've been working in my design is how to make the
> converter to be bidrectional.
 
A while back, I tried to write an extension to mercurial that would export a
hg repo using the git protocol. One side-effect was that it converted the
entire repository to a git repo with many loose objects.

It "worked" (I never finished it enough) on a small repo in a bidirectional
way.

I'll try to dig up the code, and put it up somewhere...

Josef "Jeff" Sipek.

-- 
I'm somewhere between geek and normal.
		- Linus Torvalds
