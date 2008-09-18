From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 4/4] diff.c: convert builtin funcname patterns to extended
 regular expressions
Date: Thu, 18 Sep 2008 10:39:46 +0200
Message-ID: <200809181039.46954.johan@herland.net>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
 <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 18 10:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgF58-0006gs-5F
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 10:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbYIRIkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 04:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbYIRIkf
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 04:40:35 -0400
Received: from smtp.getmail.no ([84.208.20.33]:40572 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773AbYIRIke (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 04:40:34 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K7D0051RURAV600@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 18 Sep 2008 10:40:22 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7D00MKCUQBQTB0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 18 Sep 2008 10:39:47 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7D003TMUQBF900@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 18 Sep 2008 10:39:47 +0200 (CEST)
In-reply-to: <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96184>

On Thursday 18 September 2008, Brandon Casey wrote:
> This is a blind conversion removing \\ before ( and { etc.
> and adding \\ before naked ( and { etc.
>
> I hope the authors who last touched these patterns will help with
> testing:
>
> bibtex: Johan Herland

This was moved by Junio when he applied my patch; the line was originally 
written by Gustaf Hendeby in 23b5beb28fdadbb1d80ebf686a35385609f7a180

>   html: Johan Herland

Works fine!

>    tex: Johan Herland

This was moved by Junio when he applied my patch; the line was last 
rewritten by Giuseppe Bilotta in 807d86945336f676c9f650a6cbae9baa3191aaec


...I just became a BIG fan of "git gui blame" ;)


Have fun!

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
