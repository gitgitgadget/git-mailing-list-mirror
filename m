From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem merging
Date: Fri, 25 Nov 2005 02:13:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511250208500.28437@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051123025001.15527.qmail@web31812.mail.mud.yahoo.com>
 <7v4q6483ms.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511231546330.8191@wbgn013.biozentrum.uni-wuerzburg.de>
 <D8B7EF65-9D0C-4706-B248-4B7C118C16BF@hawaga.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 02:15:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfSA5-0006MF-5j
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 02:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbVKYBN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 20:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVKYBN4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 20:13:56 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56745 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932680AbVKYBN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 20:13:56 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 21C3A13FB98; Fri, 25 Nov 2005 02:13:55 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 083E09F415; Fri, 25 Nov 2005 02:13:55 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E878B9D969; Fri, 25 Nov 2005 02:13:54 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D766113FB98; Fri, 25 Nov 2005 02:13:54 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <D8B7EF65-9D0C-4706-B248-4B7C118C16BF@hawaga.org.uk>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12724>

Hi,

On Thu, 24 Nov 2005, Ben Clifford wrote:

> On 24 Nov 2005, at 00:49, Johannes Schindelin wrote:
> 
> > I think nobody is. Since there are infinitely many files having the same
> > SHA1 (pigeon-hole principle),
> 
> hmm... pigeon-hole principle is just that there exists two files that 
> have the same SHA-1 as each other... doesn't say anything about *all* 
> SHA-1s, though?

Okay, the second part of the truth is: It would be a lousy cryptographic 
hash (which it isn't), if the SHA1s were not uniformly distributed over 
the possible data.

You actually can be reasonably sure that given the SHA1s of all messages 
of length up to N (N being an integer at least the number of bits of the 
hash, i.e. 160 for SHA1), the counts of the different SHA1s should be 
equal.

Ciao,
Dscho
