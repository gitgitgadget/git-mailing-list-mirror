From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Wed, 22 Feb 2006 23:00:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0602201934270.28957@wbgn013.biozentrum.uni-wuerzburg.de>
  <20060220191011.GA18085@hand.yhbt.net>  <7vr75xbs8w.fsf_-_@assigned-by-dhcp.cox.net>
  <81b0412b0602210930w5c1a71aage12bad2079dd515a@mail.gmail.com> 
 <43FB79E2.1040307@vilain.net> <20060221215742.GA5948@steel.home> 
 <43FB9656.8050308@vilain.net> <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 23:01:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FC22e-0001tr-Ul
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 23:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWBVWAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 17:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWBVWAt
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 17:00:49 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:4272 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750980AbWBVWAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2006 17:00:48 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 5F1C31A82;
	Wed, 22 Feb 2006 23:00:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 533098F6;
	Wed, 22 Feb 2006 23:00:45 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 369191112;
	Wed, 22 Feb 2006 23:00:45 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0602220835p4c4243edm145ee827eb706121@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16617>

Hi,

On Wed, 22 Feb 2006, Alex Riesen wrote:

> IPC::Open2 works!

Note that there is a notable decrease in performance in my preliminary 
tests (about 10%).

Ciao,
Dscho
