From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 13:41:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <44880BE8.40804@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1950643950-1149766864=:25911"
Cc: Git Mailing List <git@vger.kernel.org>, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Jun 08 13:41:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoIsv-0001xc-WB
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 13:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWFHLlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 07:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWFHLlG
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 07:41:06 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:9942 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964798AbWFHLlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 07:41:05 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A48632C06;
	Thu,  8 Jun 2006 13:41:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 98C702A8B;
	Thu,  8 Jun 2006 13:41:04 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 86D031DA7;
	Thu,  8 Jun 2006 13:41:04 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <44880BE8.40804@etek.chalmers.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21481>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1950643950-1149766864=:25911
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 8 Jun 2006, Lukas Sandström wrote:

> Johannes Schindelin wrote:
> > Since there is a global config now, we need a way to access it
> > conveniently. Now you can say
> > 
> > 	git repo-config --no-local alias.l "log --stat -M ORIG_HEAD.."
> > 
> > to set the alias globally (it will be stored in ~/.gitconfig).
> > 
> 
> Wouldn't it make more sense to call the flag --global ?

Sure, why not? Other opinions? (I will not add a test case until this is 
resolved! ;-)

Ciao,
Dscho

---1148973799-1950643950-1149766864=:25911--
