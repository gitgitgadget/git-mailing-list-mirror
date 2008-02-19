From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Submodules and rewind
Date: Tue, 19 Feb 2008 23:32:01 +0100
Message-ID: <20080219223201.GE4703MdfPADPa@greensroom.kotnet.org>
References: <20080219140604.04afc91f@extreme>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 00:10:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRbbT-0000JV-Dc
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 00:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759943AbYBSXJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 18:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757821AbYBSXJi
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 18:09:38 -0500
Received: from cavspool01.kulnet.kuleuven.be ([134.58.240.41]:60531 "EHLO
	cavspool01.kulnet.kuleuven.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758716AbYBSXJh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Feb 2008 18:09:37 -0500
X-Greylist: delayed 2249 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Feb 2008 18:09:37 EST
Received: from cavuit01.kulnet.kuleuven.be (cavuit01.kulnet.kuleuven.be [134.58.240.43])
	by cavspool01.kulnet.kuleuven.be (Postfix) with ESMTP id 353622B1827
	for <git@vger.kernel.org>; Tue, 19 Feb 2008 23:34:08 +0100 (CET)
Received: from smtps02.kuleuven.be (smtpshost02.kulnet.kuleuven.be [134.58.240.75])
	by cavuit01.kulnet.kuleuven.be (Postfix) with ESMTP id 519A47B8064
	for <git@vger.kernel.org>; Tue, 19 Feb 2008 23:32:01 +0100 (CET)
Received: from greensroom.kotnet.org (unknown [10.92.5.39])
	by smtps02.kuleuven.be (Postfix) with SMTP id 1A869F3862
	for <git@vger.kernel.org>; Tue, 19 Feb 2008 23:32:01 +0100 (CET)
Received: (qmail 20450 invoked by uid 500); 19 Feb 2008 22:32:01 -0000
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
Content-Disposition: inline
In-Reply-To: <20080219140604.04afc91f@extreme>
User-Agent: Mutt/1.5.10i
X-KULeuven-Information: Katholieke Universiteit Leuven
X-KULeuven-Scanned: Found to be clean
X-Spam-Status: not spam, SpamAssassin (not cached, score=-49.9, required 5,
	autolearn=disabled, KUL_SMTPS -50.00, RDNS_NONE 0.10)
X-KULeuven-Envelope-From: skimo@kotnet.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74471>

On Tue, Feb 19, 2008 at 02:06:04PM -0800, Stephen Hemminger wrote:
> Because of a bone headed merge, I had to rewind one project back
> to a known good state, but the sub module stuff is now wedged and
> brain stuck on the old commit id.
> 
> Isn't there some simple way to do 'git sub-module remove' followed
> by 'git sub-module add' to reset the internal index?

Why doesn't "git submodule update" work for you?

skimo
