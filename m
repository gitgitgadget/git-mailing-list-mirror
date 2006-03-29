From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add ALL_LDFLAGS to the git target.
Date: Wed, 29 Mar 2006 13:42:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0603291340570.1473@wbgn013.biozentrum.uni-wuerzburg.de>
References: <15693.1143575188@lotus.CS.Berkeley.EDU>
 <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 13:42:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOZ42-0002Qv-N6
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 13:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWC2LmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 06:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWC2LmF
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 06:42:05 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:21393 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750732AbWC2LmE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 06:42:04 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id E702112AE;
	Wed, 29 Mar 2006 13:42:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id DB286A8A;
	Wed, 29 Mar 2006 13:42:00 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id BB3371BB9;
	Wed, 29 Mar 2006 13:42:00 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne2jf9t.s3g.mdw@metalzone.distorted.org.uk>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18166>

Hi,

On Tue, 28 Mar 2006, Mark Wooding wrote:

> Jason Riedy <ejr@EECS.Berkeley.EDU> wrote:
> 
> > P.S. For the whole finding-a-function-name business, some of 
> > us are using git on fixed-format Fortran.  Every non-comment
> > line begins with whitespace...  ;)  And in free format, many
> > people don't add that first indentation within subroutines.
> 
> Urgh.  So, which regex library do people want to use? ;-)  (My vote's
> for pcre.)

My vote is against adding such a dependency for so little gain. We already 
use regex.h (probably my fault).

Ciao,
Dscho
