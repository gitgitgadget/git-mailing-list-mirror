From: Pavel Roskin <proski@gnu.org>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 14:41:19 -0400
Message-ID: <1154025679.13273.5.camel@dv>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
	 <1154018302.13273.0.camel@dv>
	 <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
	 <Pine.LNX.4.64.0607270947540.4168@g5.osdl.org>
	 <b8bf37780607271017p22fa908bt82a564a4a1a15a79@mail.gmail.com>
	 <b8bf37780607271025m1a611006x65a900e9e487ce1b@mail.gmail.com>
	 <Pine.LNX.4.64.0607271049460.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 20:41:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Anb-0004oj-N2
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 20:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWG0Sl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 14:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWG0Sl3
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 14:41:29 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:35003 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750953AbWG0Sl2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 14:41:28 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G6AnX-0007ph-FJ
	for git@vger.kernel.org; Thu, 27 Jul 2006 14:41:27 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1G6AnP-0002a7-6V; Thu, 27 Jul 2006 14:41:19 -0400
To: =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
In-Reply-To: <Pine.LNX.4.64.0607271049460.4168@g5.osdl.org>
X-Mailer: Evolution 2.7.4 (2.7.4-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24329>

On Thu, 2006-07-27 at 10:50 -0700, Linus Torvalds wrote:
> Nope. I have a fairly constant 120kbps, and:
> 
> [torvalds@g5 ~]$  git clone git://source.mvista.com/git/linux-davinci-2.6.git
> Checking files out...)      
>  100% (19754/19754) done

Same thing here.  Current git from the master branch.

-- 
Regards,
Pavel Roskin
