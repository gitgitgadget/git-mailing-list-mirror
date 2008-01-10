From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 09:31:12 -0500
Message-ID: <eaa105840801100631p6b95ed86j153d70244d474b03@mail.gmail.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	 <02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
	 <20080108190952.GK22155@fieldses.org>
	 <7vir24rtfp.fsf@gitster.siamese.dyndns.org>
	 <alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org>
	 <7vd4sbmnmz.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0801091041570.31053@racer.site>
	 <Pine.LNX.4.64.0801101023380.11922@ds9.cixit.se>
	 <alpine.LSU.1.00.0801101155140.31053@racer.site>
	 <Pine.LNX.4.64.0801101424580.11922@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	"Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jan 10 15:31:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCyRe-0001wN-LE
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 15:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbYAJObR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 09:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbYAJObR
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 09:31:17 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:38019 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYAJObQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 09:31:16 -0500
Received: by mu-out-0910.google.com with SMTP id i10so432086mue.5
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 06:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=yMXkLmWHoPRcK4K8bTQ8Jts+P88zcynlIGHeiC2xVKo=;
        b=SVTnrtK6J0TOAcgno0RO3IypMqlWhsmPQHvXOUO7Zkf+jDma+ei0kLYzbqnrR57IY3Gv2Rvoq3VdNZerjWF4tukaOz43fCvd8OrwIo4382FtmfqyRnvzYryZtDgb2/7anaRHloY2FVhxuOXsn2Lj0fx6lqjfpl1Tbloj7HdgSEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=aoobtOLc8s4jU1O311nuNT48sKq+BzMEPwk9PlWtjSFsosLDd3uVEr5SURnXcU0tsYZ+CQiHIy1c7nhG8W1wENl9kdGKK156gSQVGT/HCznBgBr9D5wpuawlekITdc1nfpKWeIFQI2OM0K9g48FaWfar5z3AJBB9TFYMAkFdGqo=
Received: by 10.78.138.14 with SMTP id l14mr2254357hud.57.1199975472181;
        Thu, 10 Jan 2008 06:31:12 -0800 (PST)
Received: by 10.78.203.14 with HTTP; Thu, 10 Jan 2008 06:31:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0801101424580.11922@ds9.cixit.se>
Content-Disposition: inline
X-Google-Sender-Auth: a0852169d2f5b541
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70074>

On Jan 10, 2008 8:28 AM, Peter Karlsson <peter@softwolves.pp.se> wrote:
> I meant to say that any software that claims to be Windows software
> should handle, and produce, CRLF line breaks in text files.

Including zip/unzip? How about tar? rsync? NFS and SMB copies from
network shares? I bet the Samba folks would just *love* to have this
discussion for the hundredth time.

Just because CVS and FTP got the defaults wrong (and modern FTP
clients mostly default to automatically switching to binary, so
basically just CVS) doesn't mean that Git has to get the default
wrong, too. Git *does* handle and produce CRLF line breaks, as long as
you tell it to. Please don't lose sight of that fact.

I'm just glad that VMS is effectively dead. Line endings on VMS are
stored outside the text body, IIRC...

Peter Harris
