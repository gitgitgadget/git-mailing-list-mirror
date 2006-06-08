From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 08 Jun 2006 13:37:12 +0200
Message-ID: <44880BE8.40804@etek.chalmers.se>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 13:37:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoIpD-0001RQ-Mo
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 13:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWFHLhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 07:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWFHLhQ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 07:37:16 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:7360 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S964784AbWFHLhP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 07:37:15 -0400
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.072.1)
        id 4487375900029203; Thu, 8 Jun 2006 13:37:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21480>

Johannes Schindelin wrote:
> Since there is a global config now, we need a way to access it
> conveniently. Now you can say
> 
> 	git repo-config --no-local alias.l "log --stat -M ORIG_HEAD.."
> 
> to set the alias globally (it will be stored in ~/.gitconfig).
> 

Wouldn't it make more sense to call the flag --global ?

/Lukas
