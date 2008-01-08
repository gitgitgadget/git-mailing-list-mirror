From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 8 Jan 2008 22:57:04 +0100
Message-ID: <200801082257.05949.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <20080108205054.GN6951@dpotapov.dyndns.org> <7vy7b0qarq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 22:57:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCMS8-0000mC-Vd
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 22:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbYAHV5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 16:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbYAHV5R
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 16:57:17 -0500
Received: from [83.140.172.130] ([83.140.172.130]:20364 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbYAHV5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 16:57:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 52AAB1447762;
	Tue,  8 Jan 2008 22:57:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3FSJTkM1tzTp; Tue,  8 Jan 2008 22:57:14 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 8CC6C802861;
	Tue,  8 Jan 2008 22:57:14 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7vy7b0qarq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69927>

tisdagen den 8 januari 2008 skrev Junio C Hamano:
> It counts CR and CRLF and converts only when there are the same
> number of them.  You probably only need to make it also count
> LF?

Strictly speaking yes, but probably no anyway. Some tools on Windows
keep existing line endings for existing lines but add CRLF for new ones.
I can only think of one right now, but that's at least one.

-- robin
