From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Documentation/git-submodule.txt: Add Description section
Date: Tue, 15 Jul 2008 21:37:05 +0300
Message-ID: <20080715183705.GD4379@zakalwe.fi>
References: <20080715102119.26321.78530.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jul 15 20:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIpPb-0004UQ-Bm
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 20:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbYGOShH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbYGOShH
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 14:37:07 -0400
Received: from zakalwe.fi ([80.83.5.154]:39414 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbYGOShG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 14:37:06 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 1D4DB2BC39; Tue, 15 Jul 2008 21:37:05 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080715102119.26321.78530.stgit@localhost>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88585>

On Tue, Jul 15, 2008 at 12:22:07PM +0200, Petr Baudis wrote:
> +Submodules are a special kind of tree entries which do not refer to a blob or
> +a directory, but to a particular tree in another repository (living at a given
> +URL). 

Better to say what a submodule is, rather than what it isn't:

"Submodules are a special kind of tree entries which refer to a 
particular tree in another repository ..."

Also, I think you should make the following explicit:

"A submodule is visible as subdirectory in the working directory.
However, the submodule is not part of the main repository.
This is a differene to "remotes". In remotes only the contents of 
other repositories is tracked, but their content is not visible in the
working directory."

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
