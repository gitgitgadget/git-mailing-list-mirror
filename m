From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [ANNOUNCE] tig-0.9
Date: Fri, 14 Sep 2007 10:32:52 -0700
Message-ID: <46EAC5C4.6020403@midwinter.com>
References: <20070913094512.GA28750@diku.dk> <F6776054-00EC-49E8-B4C8-BB0EAB3939AB@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:48:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWF2H-0007f7-9k
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 19:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbXINRcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 13:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXINRcy
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 13:32:54 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:36087 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751713AbXINRcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 13:32:53 -0400
Received: (qmail 18805 invoked from network); 14 Sep 2007 17:32:53 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Ld9mYH2F2j2HAx03rsZ/nMWBvc/zGO4n+fTSCP/ZISyLI97StCqd3s5JdS8LV0+y  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 14 Sep 2007 17:32:53 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <F6776054-00EC-49E8-B4C8-BB0EAB3939AB@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58166>

Brian Gernhardt wrote:
> Complete build failure using autoconf here.  Just using the Makefile 
> like I always have works fine, but "autoconf ; ./configure" (from the 
> git repo) fails with "configure: error: iconv() not found. Please 
> install libiconv."  This confuses me because I have 
> /usr/lib/libiconv.dylib, and compiling with -liconv works.  I fail to 
> have the autoconf-foo to figure out what's wrong.

Try "aclocal ; autoconf ; ./configure".

-Steve
