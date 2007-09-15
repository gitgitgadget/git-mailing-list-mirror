From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.9
Date: Sat, 15 Sep 2007 11:43:41 +0200
Message-ID: <20070915094341.GA14763@diku.dk>
References: <20070913094512.GA28750@diku.dk> <F6776054-00EC-49E8-B4C8-BB0EAB3939AB@silverinsanity.com> <46EAC5C4.6020403@midwinter.com> <719DD02E-5BA3-477E-ABBB-C385BF43EF9E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 11:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWUBq-0005T2-OG
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 11:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbXIOJnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 05:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbXIOJnp
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 05:43:45 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:50804 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbXIOJno (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 05:43:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 1FEC95E622C;
	Sat, 15 Sep 2007 11:43:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4bJTSa+CvMZp; Sat, 15 Sep 2007 11:43:41 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 9B6865E6222;
	Sat, 15 Sep 2007 11:43:41 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 891046DFD37; Sat, 15 Sep 2007 11:38:54 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 69B5F63134; Sat, 15 Sep 2007 11:43:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <719DD02E-5BA3-477E-ABBB-C385BF43EF9E@silverinsanity.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58232>

Brian Gernhardt <benji@silverinsanity.com> wrote Fri, Sep 14, 2007:
> 
> On Sep 14, 2007, at 1:32 PM, Steven Grimm wrote:
> 
> >Brian Gernhardt wrote:
> >>Complete build failure using autoconf here.  Just using the  
> >>Makefile like I always have works fine, but "autoconf ; ./ 
> >>configure" (from the git repo) fails with "configure: error: iconv 
> >>() not found. Please install libiconv."  This confuses me because  
> >>I have /usr/lib/libiconv.dylib, and compiling with -liconv works.   
> >>I fail to have the autoconf-foo to figure out what's wrong.
> >
> >Try "aclocal ; autoconf ; ./configure".
> 
> Yes, remembering to regenerate the configure script would have been  
> smart.  Works perfectly, thank you.

Great, I will probably roll out a 0.9.1 with this fix tomorrow.

-- 
Jonas Fonseca
