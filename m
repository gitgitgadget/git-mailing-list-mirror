From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 11:37:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701071136110.3661@woody.osdl.org>
References: <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com>
 <20070107090336.GA7741@1wt.eu> <Pine.LNX.4.61.0701071141580.4365@yvahk01.tjqt.qr>
 <20070107104943.ee2c5e6f.randy.dunlap@oracle.com>
 <Pine.LNX.4.61.0701072004290.4365@yvahk01.tjqt.qr>
 <20070107112834.a8746a98.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Willy Tarreau <w@1wt.eu>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 20:40:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3drR-0008UI-M6
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 20:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbXAGTjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 14:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965003AbXAGTjN
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 14:39:13 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43112 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964982AbXAGTjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 14:39:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l07JbhWi031853
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 Jan 2007 11:37:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l07JbgOM023979;
	Sun, 7 Jan 2007 11:37:42 -0800
To: Randy Dunlap <randy.dunlap@oracle.com>
In-Reply-To: <20070107112834.a8746a98.randy.dunlap@oracle.com>
X-Spam-Status: No, hits=-0.668 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36191>



On Sun, 7 Jan 2007, Randy Dunlap wrote:
> 
> ISTM that Linus is trying to make 2.6.20-final before LCA.  We'll see.

No. Hopefully "final -rc" before LCA, but I'll do the actual 2.6.20 
release afterwards. I don't want to have a merge window during LCA, as I 
and many others will all be out anyway. So it's much better to have LCA 
happen during the end of the stabilization phase when there's hopefully 
not a lot going on.

(Of course, often at the end of the stabilization phase there is all the 
"ok, what about regression XyZ?" panic)

		Linus
