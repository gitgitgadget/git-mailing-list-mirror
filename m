From: Petr Baudis <pasky@suse.cz>
Subject: Re: cogito-0.16: t/test-lib.sh: Unportable test(1) construct
Date: Mon, 16 Oct 2006 03:47:57 +0200
Message-ID: <20061016014757.GY20017@pasky.or.cz>
References: <20061016010520.GS25390@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nico-linux-git@schottelius.org
X-From: git-owner@vger.kernel.org Mon Oct 16 03:48:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZHaI-0004A5-EV
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 03:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWJPBr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 21:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWJPBr7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 21:47:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54656 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932078AbWJPBr7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Oct 2006 21:47:59 -0400
Received: (qmail 24255 invoked by uid 2001); 16 Oct 2006 03:47:57 +0200
To: Thomas Klausner <tk@giga.or.at>
Content-Disposition: inline
In-Reply-To: <20061016010520.GS25390@danbala.tuwien.ac.at>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28943>

  Hi,

Dear diary, on Mon, Oct 16, 2006 at 03:05:20AM CEST, I got a letter
where Thomas Klausner <tk@giga.or.at> said that...
> As of version 0.16, cogito is using an unportable bash extension
> "==" for test(1) in t/test-lib.sh. This is not supported by most
> other shells or even test(1) from GNU coreutils. Please use "="
> instead. A patch is attached.

  thanks, applied. Please generate -p1 patches in the future and sign
them off.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
