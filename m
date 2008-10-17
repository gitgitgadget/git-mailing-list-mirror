From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: Excluding files from git-diff
Date: Fri, 17 Oct 2008 17:08:51 +0200
Message-ID: <20081017150851.GA20860@rdrz.de>
References: <20081017145313.GA23471@eriks>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Hahn <erik_hahn@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 17 17:11:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqqyl-000417-KW
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 17:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389AbYJQPIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 11:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756919AbYJQPIz
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 11:08:55 -0400
Received: from rdrz.de ([217.160.107.209]:35665 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756532AbYJQPIy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 11:08:54 -0400
Received: (qmail 24951 invoked by uid 1009); 17 Oct 2008 15:08:51 -0000
Content-Disposition: inline
In-Reply-To: <20081017145313.GA23471@eriks>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98482>

On Fri, Oct 17, 2008 at 04:53:13PM +0200, Erik Hahn wrote:
> I'm currently working on a script whose developer does not use
> git. Hence, when I mail him the patch, I don't want to include the
> .gitignore file. Is it possible to exclude a file from git-diff (except
> not adding it to git, of course?)

Just add the content of .gitignore to .git/info/exclude, and remove
.gitignore from the repository.

Raphael
