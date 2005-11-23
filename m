From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why not clone to a remote directory over SSH
Date: Thu, 24 Nov 2005 00:41:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511240038001.11106@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <7vd5kr3pz1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 00:44:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef4Gq-0001tL-3u
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 00:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbVKWXmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 18:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVKWXmL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 18:42:11 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54408 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030517AbVKWXmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 18:42:00 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2648413FDE6; Thu, 24 Nov 2005 00:41:57 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0B2EDB52E1; Thu, 24 Nov 2005 00:41:57 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DA593B521E; Thu, 24 Nov 2005 00:41:56 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 65F0013FDE6; Thu, 24 Nov 2005 00:41:56 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5kr3pz1.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12662>

Hi,

On Wed, 23 Nov 2005, Junio C Hamano wrote:

> 	$ ssh machine 'git clone '`hostname`:`pwd`' /path/to/new/repository'

Obviously, this only works if the other side can connect to this side via 
ssh. Hmm. Firewalls? Disabled sshd? `hostname` not reliably returning a 
valid address for the remote side?

Hth,
Dscho
