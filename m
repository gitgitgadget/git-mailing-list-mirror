From: Yann Dirson <ydirson@altern.org>
Subject: Re: "stgit rebase" should check for errors before changing tree
Date: Wed, 6 Jun 2007 23:47:56 +0200
Message-ID: <20070606214756.GL6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <200706052059.51173.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
X-From: git-owner@vger.kernel.org Wed Jun 06 23:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3MJ-0004Ta-6U
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 23:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935157AbXFFVr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935078AbXFFVr4
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 17:47:56 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:57947 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935157AbXFFVrz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 17:47:55 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1A80D5A236;
	Wed,  6 Jun 2007 23:47:54 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id EDFFC1F165; Wed,  6 Jun 2007 23:47:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200706052059.51173.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49320>

On Tue, Jun 05, 2007 at 08:59:40PM +0400, Andrey Borzenkov wrote:
> {pts/0}% stg rebase 2.6.22-rc4
> Checking for changes in the working directory... done
> Popping all applied patches... done
> Rebasing to "2.6.22-rc4"...
> stg rebase: Unknown revision: 2.6.22-rc4^{commit}
> 
> well, now user is forced to reapply (push) all patches by hand, "stg rebase" 
> lost history and state. It probably should check before popping patches.

Right, fixed in my tree.

Thanks for your report.
-- 
Yann
