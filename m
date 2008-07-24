From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Respect crlf attribute in "git add" even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 22:44:04 +0200
Message-ID: <200807242244.04799.robin.rosenberg.lists@dewire.com>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <465DE5CD-DA13-42B4-B0D8-961F3D118F59@zib.de> <alpine.DEB.1.00.0807241742220.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:45:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM7gw-0006yf-K6
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbYGXUoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYGXUoj
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:44:39 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:52880 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYGXUoi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:44:38 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 2D91F380A3; Thu, 24 Jul 2008 22:44:37 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id DFB0437F52; Thu, 24 Jul 2008 22:44:36 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id B6DA237E42;
	Thu, 24 Jul 2008 22:44:35 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0807241742220.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89961>

torsdagen den 24 juli 2008 18.45.07 skrev Johannes Schindelin:
> However, I see Junio's point: on sane platforms you have to work hard to 
> get CR-damaged files.  And the regular sane platform user should not be 
> punished for the brain/CR damage a certain monopolist has brought over 
> this planet.

That wasn't hard at all :) Eclipse did it all by itself for JEE MANIFEST.MF files.
We got into some strange problems on windows with msysgit after that where git
(status) detected the files as changed, but no actual content change and refused
to change it's mind. I think we had actually fixed the files on Windows prior to that.
Only after converting the checkout to autocrlf=input did msysgit enter a sane state
again. I was not able to repeat the problem at the time.

Maybe I'll try again in a few weeks time.

-- robin
