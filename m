From: Petr Baudis <pasky@suse.cz>
Subject: Re: Feature: add --force option to cg-push.
Date: Tue, 17 Oct 2006 02:55:15 +0200
Message-ID: <20061017005515.GD20017@pasky.or.cz>
References: <452E437D.3070708@adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 02:55:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZdEn-00026L-CW
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWJQAzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWJQAzS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:55:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28370 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030196AbWJQAzR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:55:17 -0400
Received: (qmail 21153 invoked by uid 2001); 17 Oct 2006 02:55:15 +0200
To: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Content-Disposition: inline
In-Reply-To: <452E437D.3070708@adelaide.edu.au>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29010>

Dear diary, on Thu, Oct 12, 2006 at 03:30:37PM CEST, I got a letter
where Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au> said that...
> If I cg-push on a remote branch after changing my mind about how I 
> wanted the branch ordered, it will complain and say "maybee you need to 
> update"
> 
> I didn't know what to do, since I was on the "no" side of maybee.
> 
> Here is a patch that adds the --force option for those people.

Thanks, I've committed a similar but different patch (with better
description and handling local pushes as well). Please sign off your
patches in the future.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
