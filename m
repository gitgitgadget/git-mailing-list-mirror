From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsimport: use git-update-ref when updating
Date: Fri, 31 Mar 2006 12:08:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0603311207270.20122@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0603301405160.18852@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vk6ab1iy2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 12:10:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPGZN-00074R-SQ
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 12:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWCaKIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 05:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCaKIS
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 05:08:18 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50890 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932077AbWCaKIM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 05:08:12 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id B51AD1D46;
	Fri, 31 Mar 2006 12:08:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id A8BB4A88;
	Fri, 31 Mar 2006 12:08:11 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 8C6C59BE;
	Fri, 31 Mar 2006 12:08:11 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6ab1iy2.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18224>

Hi,

On Thu, 30 Mar 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This simplifies code, and also fixes a subtle bug: when importing in a
> > shared repository, where another user last imported from CVS, cvsimport
> > used to complain that it could not open <branch> for update.
> 
> The second hunk look sensible but I do not know about "use Fcntl"
> since I do not see anything you are adding that starts to use it...

O_EXCL. Without "use Fcntl;" perl says I am not allowed to use bareword 
things in strict mode or some such.

Ciao,
Dscho
