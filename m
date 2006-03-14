From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Tue, 14 Mar 2006 22:20:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603142219040.23646@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060314211022.GA12498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Mar 14 22:25:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJGwr-0000DN-Hb
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 22:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWCNVUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 16:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWCNVUz
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 16:20:55 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:58808 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750816AbWCNVUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 16:20:54 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 7E6E31C68;
	Tue, 14 Mar 2006 22:20:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 716D75CC7;
	Tue, 14 Mar 2006 22:20:53 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 55E0AA90;
	Tue, 14 Mar 2006 22:20:53 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Qingning Huo <qhuo@mayhq.co.uk>
In-Reply-To: <20060314211022.GA12498@localhost.localdomain>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17598>

Hi,

On Tue, 14 Mar 2006, Qingning Huo wrote:

> -	var=`git repo-config --get pull.octopus`
> +	var=`git-repo-config --get pull.octopus`

This is unlikely to be applied; there are plans to have a "libexec" path 
in which all git executables are stored, and just the "git" wrapper in the 
path. Your patch would break git in those setups.

Ciao,
Dscho

P.S.: BTW there are quite a few discussions of this in the mailing list 
archives...
