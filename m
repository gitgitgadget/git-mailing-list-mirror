From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Trying to use AUTHOR_DATE
Date: Tue, 03 May 2005 01:30:35 +0200
Message-ID: <m3mzrddx44.fsf@defiant.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	<20050430125333.2bd81b18.froese@gmx.de>
	<1114859594.24014.60.camel@localhost.localdomain>
	<20050430144936.6b05cc90.froese@gmx.de>
	<1114865964.24014.77.camel@localhost.localdomain>
	<m3wtqhe0t6.fsf@defiant.localdomain> <4276A906.2040403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Edgar Toernig <froese@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 01:25:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSkHH-0006Jv-QI
	for gcvg-git@gmane.org; Tue, 03 May 2005 01:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVEBXap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 19:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVEBXao
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 19:30:44 -0400
Received: from khc.piap.pl ([195.187.100.11]:24580 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261227AbVEBXak (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 19:30:40 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id A431410922; Tue,  3 May 2005 01:30:35 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4276A906.2040403@zytor.com> (H. Peter Anvin's message of "Mon,
 02 May 2005 15:26:14 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> It is, but you can't assume you don't have that.

Yes, if you use NTP time (directly - not the system time) you can get
second=60 (and, in theory, even 61 - not to be expected soon).

>  Either way, you just
> treat it the same as the following second.

Sure, that's the safe way.
-- 
Krzysztof Halasa
