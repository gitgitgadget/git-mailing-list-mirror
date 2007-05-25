From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 25 May 2007 14:16:16 -0700
Message-ID: <46575220.2070604@midwinter.com>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org>	<20070518224209.GG10475@steel.home>	<7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>	<7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>	<20070520155407.GC27087@efreet.light.src>	<7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>	<20070521165938.GA4118@efreet.light.src>	<20070521211133.GD5412@admingilde.org>	<7viraixeme.fsf@assigned-by-dhcp.cox.net>	<20070525203505.GB4493@efreet.light.src> <7vwsywpqaj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Hudec <bulb@ucw.cz>, Martin Waitz <tali@admingilde.org>,
	skimo@liacs.nl, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 25 23:16:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrh96-0001i8-1H
	for gcvg-git@gmane.org; Fri, 25 May 2007 23:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbXEYVQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 17:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759213AbXEYVQT
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 17:16:19 -0400
Received: from tater.midwinter.com ([216.32.86.90]:60936 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754363AbXEYVQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 17:16:18 -0400
Received: (qmail 26803 invoked from network); 25 May 2007 21:16:18 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=fU7r00qpsR16CT7jv8QM/pieyn4vOFYXlpgNxuBzazBYaZKUGgs5L3+JpUsfb7u9  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 25 May 2007 21:16:18 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <7vwsywpqaj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48418>

Junio C Hamano wrote:
> If you were doing an efficient cgi script that renders history
> of git managed projects, binding git as its subproject, and that
> system can be built with either 'maint' (i.e. 1.5.2 series) or
> 'master' (i.e. ultrastable WIP towards 1.5.3), even though they
> both might come from git://git.kernel.org/pub/scm/git/git.git/,
> I think they should be registered as two separate logical
> subprojects.
>   

I agree strongly with this, and it's another good reason that we have to 
be able to use something other than the URL as the key to look up a 
subproject's repository location. If you use the URL it is impossible to 
differentiate the two subprojects in this case.

-Steve
