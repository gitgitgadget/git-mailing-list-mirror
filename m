From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Wed, 16 Nov 2005 02:32:14 +0100
Message-ID: <200511160232.15162.Josef.Weidendorfer@gmx.de>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de> <20051115215943.GW30496@pasky.or.cz> <437A5FAF.2000609@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 02:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcCA3-00030X-Mn
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 02:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbVKPBc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 20:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVKPBc2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 20:32:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:32705 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932261AbVKPBc2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 20:32:28 -0500
Received: (qmail invoked by alias); 16 Nov 2005 01:32:26 -0000
Received: from p5496C7F9.dip0.t-ipconnect.de (EHLO linux) [84.150.199.249]
  by mail.gmx.net (mp037) with SMTP; 16 Nov 2005 02:32:26 +0100
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <437A5FAF.2000609@zytor.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11984>

On Tuesday 15 November 2005 23:22, H. Peter Anvin wrote:
> Sure.  It's called %if.  There is also %ifdef and %define.

So by replacing @@FOR_SUSE@@ to 0 or 1 in the Makefile, this: 

 %if @@FOR_SUSE@@
 BuildRequires: openssh ...
 %else
 BuildRequires: openssh-clients ...
 %endif

would work?

Josef
