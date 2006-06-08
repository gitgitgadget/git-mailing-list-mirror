From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] repo-config: learn the flag "--no-local"
Date: Thu, 8 Jun 2006 22:17:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606082216070.28323@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606081331140.11910@wbgn013.biozentrum.uni-wuerzburg.de>
 <44880BE8.40804@etek.chalmers.se> <Pine.LNX.4.63.0606081340230.25911@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060608133747.GA15374@diana.vm.bytemark.co.uk> <20060608153508.GB8047@satan.machinehead.org>
 <e69qne$nnl$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 08 22:18:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoQww-000726-V0
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 22:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWFHURs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 16:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWFHURs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 16:17:48 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41346 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964978AbWFHURr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 16:17:47 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 6AE1B1C58;
	Thu,  8 Jun 2006 22:17:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 5EFDB1290;
	Thu,  8 Jun 2006 22:17:46 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 42839EF6;
	Thu,  8 Jun 2006 22:17:46 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e69qne$nnl$2@sea.gmane.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21509>

Hi,

On Thu, 8 Jun 2006, Jakub Narebski wrote:

> And legacy "git repo-config" as equivalent of "git config --repo", perhaps
> implemented via alias mechanism (if there woul be system-wide coniguration
> file, otherwise in skeleton/template).

Why use the alias mechanism? I, for one, never install git. So, this 
solution is rather fragile. But there are better ways: the builtin 
mechanism for one.

Ciao,
Dscho
