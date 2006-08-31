From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 16:59:22 +0200
Organization: At home
Message-ID: <ed6tg9$9ij$1@sea.gmane.org>
References: <44F6D016.4050007@users.sourceforge.net> <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F6F478.1070708@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 31 17:01:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIo26-0004hQ-7d
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 17:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWHaPAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 11:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWHaPAT
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 11:00:19 -0400
Received: from main.gmane.org ([80.91.229.2]:36230 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932173AbWHaPAR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 11:00:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GIo1Q-0004XF-FX
	for git@vger.kernel.org; Thu, 31 Aug 2006 17:00:00 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 17:00:00 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 17:00:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26263>

Jorma Karvonen wrote:

> Johannes Schindelin wrote:

>> since you do have a recent snapshot, why not try ./configure, as Pasky 
>> suggested?
>>
>> BTW I cannot read Finnish, but it probably says that you do not have curl 
>> installed. configure would detect that, and automatically set NO_CURL=1.
>
> Sorry,
> 
> but I have not any git installed and there is no configure file in 
> installing directory. It was the first thing I checked after extracting 
> the git-snapshot-20060831.bz2 file. The INSTALL file does not mention 
> the ./configure command, either.

>From INSTALL file, 'maint' branch:

  Alternatively you can use autoconf generated ./configure script to
  set up install paths (via config.mak.autogen), so you can write instead

        $ autoconf ;# as yourself if ./configure doesn't exist yet
        $ ./configure --prefix=/usr ;# as yourself
        $ make all doc ;# as yourself
        # make install install-doc ;# as root

>From INSTALL file, 'next' and 'master' branches (here since 2006-08-08):

  Alternatively you can use autoconf generated ./configure script to
  set up install paths (via config.mak.autogen), so you can write instead

        $ make configure ;# as yourself
        $ ./configure --prefix=/usr ;# as yourself
        $ make all doc ;# as yourself
        # make install install-doc ;# as root


 
> When I tested 
> 
> make NEEDS_LIBICONV=1 NO_CURL=1
> 
> the make succeeded but when trying make install I got error messages 
> shown in the enclosed file.

Try then
  $ NEEDS_LIBICONV=YesPlease NO_CURL=YesPlease make

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
