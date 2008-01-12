From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Decompression speed: zip vs lzo
Date: Sat, 12 Jan 2008 17:44:49 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801121742510.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
 <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net> <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
 <47869C24.3000400@vilain.net> <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org> <4786BFCD.1000303@vilain.net> <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org> <47870CDF.4010606@vilain.net> <alpine.LFD.1.00.0801110759160.3148@woody.linux-foundation.org>
 <47881D44.9060105@vilain.net> <alpine.LFD.1.00.0801112125470.3054@xanadu.home> <47882EC5.2080406@vilain.net> <alpine.LFD.1.00.0801121053080.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 17:45:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDjU6-00020P-PY
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 17:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbYALQoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 11:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYALQoy
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 11:44:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:59745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753755AbYALQox (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 11:44:53 -0500
Received: (qmail invoked by alias); 12 Jan 2008 16:44:51 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp003) with SMTP; 12 Jan 2008 17:44:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zm70kfv7zv7OiUJ1jqLGEBGh2nYJr/VGZBdPQbs
	UYrKSfwiIYZNgY
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <alpine.LFD.1.00.0801121053080.3054@xanadu.home>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70329>

Hi,

On Sat, 12 Jan 2008, Nicolas Pitre wrote:

> On Sat, 12 Jan 2008, Sam Vilain wrote:
> 
> > Going as much as twice as fast for many history operations for 10% 
> > added space sounds like a clear win to me.

I have to agree with Nicolas.  A full history log is such a rare occasion 
that it is not worth optimising for.

When I call "git log", it typically shows me the first commit 
_instantaneously_, which is plenty fast enough for me, especially given 
that I quit it right away or after a few pages more often than not.

Ciao,
Dscho
