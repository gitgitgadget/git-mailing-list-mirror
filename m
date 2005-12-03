From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull aborts in 50% of cases
Date: Sat, 3 Dec 2005 03:18:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru> <43909963.60901@zytor.com>
 <20051202211250.GA11384@mipter.zuzino.mipt.ru> <4390B64E.20601@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexey Dobriyan <adobriyan@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 03:18:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiMya-0001kB-I5
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 03:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVLCCSI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 21:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVLCCSH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 21:18:07 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45212 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751156AbVLCCSG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 21:18:06 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B1CA013F8D4; Sat,  3 Dec 2005 03:18:02 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 98F5F9F50E; Sat,  3 Dec 2005 03:18:02 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 85AE19F41D; Sat,  3 Dec 2005 03:18:02 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F279A13F8D4; Sat,  3 Dec 2005 03:18:01 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4390B64E.20601@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13139>

Hi,

On Fri, 2 Dec 2005, H. Peter Anvin wrote:

> Alexey Dobriyan wrote:
> > 
> > Heisenbug :-\. I'll send IP next time.
> > 
> 
> Actually, it turns out the two servers were running different versions; one
> 0.99.9j and one 0.99.9k.  They're both running 0.99.9j now.
> 
> 0.99.9k is clearly bad.

Huh? It could be slower, and it could therefore hit the maximum client 
count faster, but it should not be bad.

All changes to pull were done in a manner so as to be backward compatible. 
In both ways.

Hth,
Dscho
