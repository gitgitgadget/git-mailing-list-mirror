From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Quick merge status updates.
Date: Wed, 28 Jun 2006 11:13:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606281109010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606280928540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606280938420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7vh4q8w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Jun 28 11:13:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvW6r-0002Zg-8w
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 11:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423231AbWF1JNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 05:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423237AbWF1JNQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 05:13:16 -0400
Received: from mail.gmx.net ([213.165.64.21]:425 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423231AbWF1JNP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 05:13:15 -0400
Received: (qmail invoked by alias); 28 Jun 2006 09:13:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 28 Jun 2006 11:13:13 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7vh4q8w.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22786>

Hi,

On Wed, 28 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > on my iBook, make in pu outputs:
> >
> > GIT_VERSION = 1.4.1.rc1.gf5d3
> >     * new build flags or prefix
> > (cd perl && /usr/bin/perl Makefile.PL \
> >      PREFIX='/Users/gene099' \
> >      DEFINE=' -I/sw/include -DSHA1_HEADER='\''<openssl/sha.h>'\'' 
> > -DNO_STRCASESTR -DNO_STRLCPY -DGIT_VERSION='\''"1.4.1.rc1.gf5d3"'\''' \
> >      LIBS=' -L/sw/lib -lz  -liconv  -lcrypto -lssl')
> > Can't locate Devel/PPPort.pm in @INC (@INC contains: 
> > /System/Library/Perl/darwin /System/Library/Perl /Library/Perl/darwin 
> > /Library/Perl /Library/Perl /Network/Library/Perl/darwin 
> > /Network/Library/Perl /Network/Library/Perl .) at Makefile.PL line 29.
> > BEGIN failed--compilation aborted at Makefile.PL line 29.
> > make: *** [perl/Makefile] Error 2
> >
> > FWIW all Perl scripts in git, except git-send-email, work here.
> 
> I suspect git-fmt-merge-msg doesn't, and perhaps git-mv.

Last time I checked, git-mv worked (couple of weeks ago). And if I am not 
mistaken, git-fmt-merge-msg is needed when git-pull does not fast forward? 
I definitely successfully merged on my iBook, IIRC last time was last 
week.

BTW: Devel/PPPort.pm is introduced by this line in perl/Git.xs:

> #include "ppport.h"

Ciao,
Dscho
