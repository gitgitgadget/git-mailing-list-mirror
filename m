From: David Brown <git@davidb.org>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 08:40:12 -0800
Message-ID: <20051224164011.GA6737@old.davidb.org>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se> <20051224101849.GY1279MdfPADPa@greensroom.kotnet.org> <43AD21D7.5060306@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Rob McDonald <robm@asdl.gatech.edu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 17:40:29 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqCRU-00007M-1M
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 17:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVLXQkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 11:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbVLXQkV
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 11:40:21 -0500
Received: from mail.davidb.org ([66.93.32.219]:9872 "EHLO mail.davidb.org")
	by vger.kernel.org with ESMTP id S1751246AbVLXQkU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 11:40:20 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.54 #1 (Debian))
	id 1EqCRI-0001lz-0a; Sat, 24 Dec 2005 08:40:12 -0800
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43AD21D7.5060306@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14027>

On Sat, Dec 24, 2005 at 11:24:23AM +0100, Andreas Ericsson wrote:
> Sven Verdoolaege wrote:
> >On Sat, Dec 24, 2005 at 11:09:39AM +0100, Andreas Ericsson wrote:
> >
> >>The worst trouble you're likely to run into is all the hardcoded paths. 
> >>They are everywhere and ofcourse use the / for path entity separation.
> >
> >
> >AFAIR, '/' is a valid path separator on Windows.
> >It's just command.com (does that still exist?) that insisted on '\\'
> >separators.
> 
> Are you sure? I've seen lots of porting patches that transliterate those 
> to '\\'. Perhaps those who wrote those patches just took for granted 
> that it was needed, the same as I did.

AFAIK all of the Win32 APIs accept either forward or backward slash as a
separator.  It has been this way since when they added directories to DOS.

What doesn't always accept forward slashes are commandline utilities that
are using '/' as an option separator.  Most of them these days will accept
the '/', at least in many circumstances.

Dave
