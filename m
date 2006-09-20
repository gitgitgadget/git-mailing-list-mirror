From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull for update of netdev fails.
Date: Thu, 21 Sep 2006 00:34:47 +0200
Organization: At home
Message-ID: <eesfm3$h2o$1@sea.gmane.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 21 00:35:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQAez-0003xI-FR
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 00:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWITWfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 18:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWITWfN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 18:35:13 -0400
Received: from main.gmane.org ([80.91.229.2]:21146 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932425AbWITWfL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 18:35:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GQAec-0003sf-HC
	for git@vger.kernel.org; Thu, 21 Sep 2006 00:34:54 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 00:34:54 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 00:34:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27419>

Johannes Schindelin wrote:

> Another, even more serious problems with rebasing: You can introduce a bug 
> by rebasing. Meaning: git-rebase can succeed, even compilation is fine, 
> but the sum of your patches, and the patches you are rebasing on, is 
> buggy. And there is _no_ way to bisect this, since the "good" version can 
> be gone for good.

Well, you can always tag tip of branch before rebasing, and remove the tag
when rebased branch is tested.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
