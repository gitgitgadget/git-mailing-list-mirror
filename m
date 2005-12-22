From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 16:52:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512221651160.18945@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com> 
 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>  <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vek465cev.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0512220211o74f7f533j11b8e48311b61ec2@mail.gmail.com> 
 <Pine.LNX.4.63.0512221227190.7112@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0512220638j382252b5l24e1c6b261165bd6@mail.gmail.com> 
 <Pine.LNX.4.63.0512221603490.18668@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0512220714w7fb1d9c2j95bbe620fd88cf95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 16:52:12 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpSjj-0001H7-F1
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 16:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVLVPwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 10:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVLVPwH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 10:52:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:55172 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030212AbVLVPwF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 10:52:05 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3B5FF13FCD9; Thu, 22 Dec 2005 16:52:02 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1E4539E231; Thu, 22 Dec 2005 16:52:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F409E9E3A1; Thu, 22 Dec 2005 16:52:01 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 80A3013FCD9; Thu, 22 Dec 2005 16:52:01 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0512220714w7fb1d9c2j95bbe620fd88cf95@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13951>

Hi,

On Thu, 22 Dec 2005, Alex Riesen wrote:

> Does it make sense to allow different access methods to a shared repository?

My point is: regardless if you allow different access methods or not, you 
only need one method to set a repository-wide umask.

Ciao,
Dscho
