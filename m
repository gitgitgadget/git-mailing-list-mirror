From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bisect broken in 1.2.4
Date: Tue, 2 May 2006 21:38:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605022137290.21545@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060501181020.GA21263@suse.de> <20060502070155.GA861@informatik.uni-freiburg.de>
 <7vpsiwopkv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0605021241300.3795@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslnskzjj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 21:38:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb0he-0005s7-PT
	for gcvg-git@gmane.org; Tue, 02 May 2006 21:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWEBTib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 15:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWEBTib
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 15:38:31 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51938 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751040AbWEBTia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 15:38:30 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 8CB4DDA7;
	Tue,  2 May 2006 21:38:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 80F5EDA4;
	Tue,  2 May 2006 21:38:29 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 6312EBA8;
	Tue,  2 May 2006 21:38:29 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslnskzjj.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19426>

Hi

On Tue, 2 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Why not just use the existing method:
> >
> > 	[core]
> > 		onlyusesymrefs = false
> 
> USE_SYMLINK_HEAD is not enabled by default, and when it is, it
> _defaults_ to use symlink head.

Okay. I missed the part that support is disabled by default.

Sorry for the noise,
Dscho
