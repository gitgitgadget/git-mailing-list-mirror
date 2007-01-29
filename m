From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git blame --progress
Date: Mon, 29 Jan 2007 12:24:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291222540.3611@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
 <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
 <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
 <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <45BCB273.7010601@lsrfire.ath.cx>
 <7v4pqbezo9.fsf@assigned-by-dhcp.cox.net> <7vzm83dkw4.fsf@assigned-by-dhcp.cox.net>
 <45BD40AE.9020603@lsrfire.ath.cx> <7vfy9ublvj.fsf_-_@assigned-by-dhcp.cox.net>
 <45BE520A.6050906@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-2100431331-1170102246=:3611"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jan 29 21:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBd3A-0006zy-Pz
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 21:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbXA2UYO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 15:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbXA2UYO
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 15:24:14 -0500
Received: from smtp.osdl.org ([65.172.181.24]:54667 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbXA2UYN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 15:24:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0TKO81m010174
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Jan 2007 12:24:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0TKO6mC029674;
	Mon, 29 Jan 2007 12:24:07 -0800
In-Reply-To: <45BE520A.6050906@lsrfire.ath.cx>
X-Spam-Status: No, hits=-2.483 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38096>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-2100431331-1170102246=:3611
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Mon, 29 Jan 2007, René Scharfe wrote:
> 
> The problem here is, of course, that we don't know how beforehand much
> work needs to be done.  The indicator could be full of stars long before
> the start of history is reached.

Well, we do have an approximation for it: we know how many lines the file 
has, and we do know (although we don't actually track) how many lines 
we've blamed so far.

So it would be fairly easy to give at least a *rough* indication of 
"percent blamed" - although it doesn't necessarily say anything about how 
expensive that last 1% is going to be..

		Linus
---1463790079-2100431331-1170102246=:3611--
