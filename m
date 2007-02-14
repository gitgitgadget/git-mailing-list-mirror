From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 19:17:50 +0100
Organization: Dewire
Message-ID: <200702141917.51341.robin.rosenberg.lists@dewire.com>
References: <45CFA30C.6030202@verizon.net> <Pine.LNX.4.63.0702141653440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45D346B6.5020802@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:17:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOgX-0007wC-A5
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbXBNSQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbXBNSQu
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:16:50 -0500
Received: from [83.140.172.130] ([83.140.172.130]:18840 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932425AbXBNSQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:16:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A68E7803393;
	Wed, 14 Feb 2007 19:11:55 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01124-07; Wed, 14 Feb 2007 19:11:55 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 505E2800199;
	Wed, 14 Feb 2007 19:11:53 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <45D346B6.5020802@verizon.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39717>

onsdag 14 februari 2007 18:28 skrev Mark Levedahl:
> As to cvsnt, my actual feeling is I'd like to kick it in the ass, it has 
> destroyed too many files for me over the years, binary and text, so I 
> don't think its strategies are very good. That is why I'm kicking these 
> ideas around, if I thought I knew the "right" way I would have written 
> it already.

That may be why an excellent piece of software, TortoiseCVS,  doesn't trust 
cvs or cvsnt to do the job. Here is how they do the binary detection (and 
some more):

http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/TortoiseCVS/src/CVSGlue/CVSStatus.cpp?revision=1.172&view=markup

-- robin
