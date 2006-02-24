From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] New git-seek command with documentation and test.
Date: Fri, 24 Feb 2006 01:54:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602240152490.32472@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060224002915.17331.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: cworth@cworth.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 01:54:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCREE-00026b-3F
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 01:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWBXAyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 19:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWBXAyf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 19:54:35 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:56800 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932223AbWBXAyf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 19:54:35 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 53AD61BBD;
	Fri, 24 Feb 2006 01:54:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 47DC32A72;
	Fri, 24 Feb 2006 01:54:34 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E854FA46;
	Fri, 24 Feb 2006 01:54:33 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: linux@horizon.com
In-Reply-To: <20060224002915.17331.qmail@science.horizon.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16679>

Hi,

On Fri, 23 Feb 2006, linux@horizon.com wrote:

> This is somewhat heretical, but how about making a truly unnamed branch by
> having .git/HEAD *not* be a symlink, but rather hold a commit ID directly?

Not heretical. How do you intend to switch branches now? And how do you 
intend to record the starting point of git-seek to which you want to 
return to? All leads back to .git/HEAD pointing to a branch (or whatever 
you want to call it). And BTW, .git/HEAD is no symlink these days, but a 
symref.

Hth,
Dscho
