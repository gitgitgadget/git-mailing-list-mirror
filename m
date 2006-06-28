From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick merge status updates.
Date: Wed, 28 Jun 2006 01:51:43 -0700
Message-ID: <7vy7vh4q8w.fsf@assigned-by-dhcp.cox.net>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606280928540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606280938420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Jun 28 10:52:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvVmB-0007KI-Lt
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 10:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423227AbWF1Ivt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 04:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423229AbWF1Ivr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 04:51:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34746 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1423227AbWF1Ivp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 04:51:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628085144.BPCQ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 04:51:44 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606280938420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 28 Jun 2006 09:39:46 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22781>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> on my iBook, make in pu outputs:
>
> GIT_VERSION = 1.4.1.rc1.gf5d3
>     * new build flags or prefix
> (cd perl && /usr/bin/perl Makefile.PL \
>      PREFIX='/Users/gene099' \
>      DEFINE=' -I/sw/include -DSHA1_HEADER='\''<openssl/sha.h>'\'' 
> -DNO_STRCASESTR -DNO_STRLCPY -DGIT_VERSION='\''"1.4.1.rc1.gf5d3"'\''' \
>      LIBS=' -L/sw/lib -lz  -liconv  -lcrypto -lssl')
> Can't locate Devel/PPPort.pm in @INC (@INC contains: 
> /System/Library/Perl/darwin /System/Library/Perl /Library/Perl/darwin 
> /Library/Perl /Library/Perl /Network/Library/Perl/darwin 
> /Network/Library/Perl /Network/Library/Perl .) at Makefile.PL line 29.
> BEGIN failed--compilation aborted at Makefile.PL line 29.
> make: *** [perl/Makefile] Error 2
>
> FWIW all Perl scripts in git, except git-send-email, work here.

I suspect git-fmt-merge-msg doesn't, and perhaps git-mv.
