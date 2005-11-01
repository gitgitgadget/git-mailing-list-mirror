From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: HTTP pushes
Date: Tue, 1 Nov 2005 20:10:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511012008310.11979@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051101020248.GA3928@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 20:11:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX1Wg-0003io-TP
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 20:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVKATKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 14:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKATKV
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 14:10:21 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50654 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751139AbVKATKU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 14:10:20 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B012513F27A; Tue,  1 Nov 2005 20:10:17 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 944D29F078; Tue,  1 Nov 2005 20:10:17 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7FFB28C0F8; Tue,  1 Nov 2005 20:10:17 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0553B13F27A; Tue,  1 Nov 2005 20:10:17 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051101020248.GA3928@reactrix.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10948>

Hi,

On Mon, 31 Oct 2005, Nick Hengeveld wrote:

> HTTP is currently listed as a read-only/unsupported method for doing
> pushes, is that due to inherent problems with HTTP or just because
> it hasn't been written yet?
> 
> I've built a working prototype of an HTTP push implementation using DAV.

I think this is useful. There are restrictive firewalls out there, which 
only allow ports 80 and 443 to be connected to. Your work would fit in 
right there.

BTW, if the push would be relatively big, it would be nice to support 
pushing packs...

Ciao,
Dscho
