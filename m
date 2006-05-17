From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 15:48:09 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605171546350.1522@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160605161507w3a27152dq@mail.gmail.com> 
 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>  <8aa486160605161542u704ccf03w@mail.gmail.com>
  <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
 <8aa486160605170641p2ab8704o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 15:48:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgMNq-0006No-M9
	for gcvg-git@gmane.org; Wed, 17 May 2006 15:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWEQNsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWEQNsM
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 09:48:12 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:17569 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932556AbWEQNsL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 09:48:11 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id D5190197F;
	Wed, 17 May 2006 15:48:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id C930B18AE;
	Wed, 17 May 2006 15:48:09 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id ADB24DCD;
	Wed, 17 May 2006 15:48:09 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Santi <sbejar@gmail.com>
In-Reply-To: <8aa486160605170641p2ab8704o@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20198>

Hi,

On Wed, 17 May 2006, Santi wrote:

> In the other way, now I find the value of being able to say:
> 
> $ git add t*
> 
> and be sure that it does not add an ignored file. Unfortunately
> git-add cannot distinguish between both. So what I propose is to
> document it explicitly, something like:
> 
> [...]

How about a "--force" AKA "-f" flag that overrides the ignore file?

I would implement it if I had time, but I am gone for three days in about 
1 minute :-(

Ciao,
Dscho
