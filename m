From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fix display of trees via PATH_INFO.
Date: Thu, 21 Sep 2006 10:56:37 +0200
Organization: At home
Message-ID: <eetk3v$22n$2@sea.gmane.org>
References: <20060921074821.GG31940@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Sep 21 10:57:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQKMv-0006JC-HZ
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 10:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWIUI5P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 04:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWIUI5O
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 04:57:14 -0400
Received: from main.gmane.org ([80.91.229.2]:6374 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750983AbWIUI5O (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 04:57:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GQKMN-00069H-Ua
	for git@vger.kernel.org; Thu, 21 Sep 2006 10:56:44 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 10:56:43 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 10:56:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27466>

Martin Waitz wrote:

> When adding a / to the URL, git should display the corresponding
> tree object, but it has to remove the / first.

Hmm... I thought that gitweb works just fine with file_name ('f') parameter
with trailing '/'... I guessed wrong.

By the way, we should fix error when we try to "tree" display blob, or
"blob" display tree.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
