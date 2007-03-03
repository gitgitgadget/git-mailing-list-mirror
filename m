From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: (Re: gitweb not friendly to firefox?) and unusable in the lynx
Date: Sat, 3 Mar 2007 14:04:23 +0100
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <20070303130423.GL16509@flower.upol.cz>
References: <989B956029373F45A0B8AF02970818902DA81B@zch01exm26.fsl.freescale.net> <200703030357.18822.jnareb@gmail.com> <alpine.LRH.0.82.0703022223060.29426@xanadu.home> <200703030441.36627.jnareb@gmail.com> <alpine.LRH.0.82.0703022242570.29426@xanadu.home> <alpine.LRH.0.82.0703030005320.29426@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Li Yang-r58472 <LeoLi@freescale.com>, rea-git@codelabs.ru,
	Raimund Bauer <ray@softwarelandschaft.com>,
	git@vger.kernel.org, Alp Toker <alp@atoker.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 13:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNTmw-0000Sn-RP
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 13:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbXCCM41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 07:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbXCCM41
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 07:56:27 -0500
Received: from raven.upol.cz ([158.194.120.4]:33742 "EHLO raven.upol.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030225AbXCCM40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 07:56:26 -0500
Received: from smtpgate (antivir1.upol.cz [158.194.108.127])
	by raven.upol.cz (AIX4.3/8.9.3/8.9.3) with SMTP id OAA65960;
	Sat, 3 Mar 2007 14:03:30 +0100
Received: from flower (flower.upol.cz [158.194.64.22])
 by smtpgate ([158.194.108.127]:25) (F-Secure Anti-Virus for Internet Mail 6.50.60 Release)
 with SMTP; Sat, 3 Mar 2007 12:54:32 -0000
 (envelope-from <olecom@flower.upol.cz>)
Received: from olecom by flower with local (Exim 4.63)
	(envelope-from <olecom@flower.upol.cz>)
	id 1HNTuR-0006M0-PI; Sat, 03 Mar 2007 14:04:23 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LRH.0.82.0703030005320.29426@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41293>

On Sat, Mar 03, 2007 at 12:09:02AM -0500, Nicolas Pitre wrote:
[]
> So gitweb is now broken for 2 out of 3 text based browsers that used to 
> just work fine before.

Maybe there's a patch to have xhtml to be as html.

In the Debian i have:

,-*- bash -*-
|olecom@flower:/tmp$ nc -l -p 8888 localhost
|GET / HTTP/1.0
|Host: localhost:8888
|Accept: text/html, text/plain, application/x-troff-man,
|application/x-tar, application/x-gtar, application/ogg, image/gif,
|image/jpeg, image/pjpeg, image/png, image/tiff, image/bmp, text/*,
|application/x-debian-package, audio/basic, */*;q=0.01
|Accept-Encoding: gzip, compress
|Accept-Language: en, ru, cs
|Accept-Charset: koi8-r, iso-8859-1;q=0.01, us-ascii;q=0.01
|User-Agent: Lynx/2.8.5rel.1 libwww-FM/2.14 SSL-MM/1.4.1 GNUTLS/1.4.4
`-*-

All additional content types, e.g application/*, image/*, are handled by
external software of course.

And maybe this: "*/*;q=0.01" is handled somehow wrong, i.e out of priority.
____
