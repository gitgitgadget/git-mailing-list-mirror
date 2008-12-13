From: Resul Cetin <Resul-Cetin@gmx.net>
Subject: Re: Optimizing cloning of a high object count repository
Date: Sat, 13 Dec 2008 19:20:50 +0100
Message-ID: <200812131920.50736.Resul-Cetin@gmx.net>
References: <200812131624.57618.Resul-Cetin@gmx.net> <200812131714.05472.Resul-Cetin@gmx.net> <4943E657.9040204@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Jean-Luc Herren" <jlh@gmx.ch>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	gentoo-scm@gentoo.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 13 19:23:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBZ8m-00024U-92
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 19:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbYLMSUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 13:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYLMSUx
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 13:20:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:56499 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750919AbYLMSUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 13:20:52 -0500
Received: (qmail invoked by alias); 13 Dec 2008 18:20:50 -0000
Received: from i59F6A60F.versanet.de (EHLO rowo) [89.246.166.15]
  by mail.gmx.net (mp040) with SMTP; 13 Dec 2008 19:20:50 +0100
X-Authenticated: #13824512
X-Provags-ID: V01U2FsdGVkX1/d21gpSYLd6wCxha3vnYs1aTnZofS5lER1IY3tl2
	hJcA7/tMgySBwU
User-Agent: KMail/1.10.3 (Linux/2.6.26-1-amd64; KDE/4.1.3; x86_64; ; )
In-Reply-To: <4943E657.9040204@gmx.ch>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103009>

On Saturday 13 December 2008 17:44:07 you wrote:
> Resul Cetin wrote:
> > That would be a workaround but it doesn't explain why git.kernel.org
> > deliveres torvalds repository without any notable counting and
> > compressing time.
>
> If I remember right, git.kernel.org is a quite beefy machine.  But
> then again it has a lot more traffic too.  It might be interesting
> to know what machine you're on, compared to git.kernel.org.
I dont know what type of machine git.overlay.g.o is but my athlon64 3500+ with 
4GB ram has exactly the same problem without any other load. I made a clone  
over http and did no other changes to the repository until now.

http://git.overlays.gentoo.org/gitroot/exp/gentoo-x86.git/ is the http clone 
url.

I will try some stuff to reduce the time spend before sending anything..... If 
anyone has some ideas how to do that....

Regards,
	Resul
