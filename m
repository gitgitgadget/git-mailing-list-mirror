From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH] Test "stg rebase" after "stg commit"
Date: Sun, 6 May 2007 15:39:09 +0200
Message-ID: <20070506133909.GG19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070504081021.14786.77675.stgit@yoghurt> <20070506122116.GA18883@diana.vm.bytemark.co.uk> <20070506131554.GF19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 06 15:40:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkgxz-0006YZ-JM
	for gcvg-git@gmane.org; Sun, 06 May 2007 15:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbXEFNjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 09:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbXEFNjz
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 09:39:55 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:36864 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754601AbXEFNjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 09:39:54 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0E3CE5F26B;
	Sun,  6 May 2007 15:39:54 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 685621F160; Sun,  6 May 2007 15:39:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070506131554.GF19253@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46334>

On Sun, May 06, 2007 at 03:15:54PM +0200, Yann Dirson wrote:
> That said, I have not looked at your testcase yet, I'll try to do this
> soon.

Oh, timeslot allocated :)

Well, this case clearly falls in the category of "actions outside
stgit that make it possible to rebase without a loss".  But then it is
also clear that the action of tagging makes the committed patch
reachable, and thus the rebase loss-less.

The safety check could be possibly be rewritten as "check if current
base is reachable without using any refs from current series".

Best regards,
-- 
Yann.
