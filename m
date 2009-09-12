From: Tito <farmatito@tiscali.it>
Subject: Re: [DIFF] build git on armv6l emulator with uclibc
Date: Sat, 12 Sep 2009 22:52:45 +0200
Message-ID: <200909122252.45995.farmatito@tiscali.it>
References: <200909122218.07830.farmatito@tiscali.it> <20090912204230.GA31317@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 12 22:53:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmZaf-0006p7-Hq
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 22:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbZILUwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 16:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbZILUww
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 16:52:52 -0400
Received: from smtp-out25.alice.it ([85.33.2.25]:2605 "EHLO
	smtp-out25.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbZILUwv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 16:52:51 -0400
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out25.alice.it with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 12 Sep 2009 22:52:52 +0200
Received: from FBCMCL01B03.fbc.local ([192.168.69.84]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 12 Sep 2009 22:52:52 +0200
Received: from [192.168.1.100] ([79.45.5.203]) by FBCMCL01B03.fbc.local with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 12 Sep 2009 22:52:51 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090912204230.GA31317@localhost>
Content-Disposition: inline
X-OriginalArrivalTime: 12 Sep 2009 20:52:51.0716 (UTC) FILETIME=[FE695440:01CA33EA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128297>

On Saturday 12 September 2009 22:42:30 Clemens Buchacher wrote:
> On Sat, Sep 12, 2009 at 10:18:07PM +0200, Tito wrote:
> 
> > +#if 0
> >  		mtime.nsec = ST_MTIME_NSEC(st);
> > +#else
> > +		mtime.nsec = (unsigned long int)st.st_mtimensec;
> > +#endif
> 
> You can do this instead:
> 
> $ echo NO_NSEC=YesPlease >> config.mak
> $ make
> 
> Clemens
> 

Maybe something about this could be added to configure

Optional Features:
  --disable-option-checking  ignore unrecognized --enable/--with options
  --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
  --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
  --enable-pthreads=FLAGS FLAGS is the value to pass to the compiler to enable
 
 --disable-nsec

to avoid to someone else to reinvent the wheel like i did :-)

Ciao,
Tito
