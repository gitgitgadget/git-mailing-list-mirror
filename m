From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Thu, 23 Mar 2006 13:39:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603231319120.26286@g5.osdl.org>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org>
 <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com>
 <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org>
 <20060323210215.GH26071@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Packard <keithp@keithp.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 22:39:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMXWz-00008b-Ul
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 22:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWCWVjn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 16:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCWVjn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 16:39:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2532 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932177AbWCWVjm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 16:39:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2NLdYDZ020222
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 23 Mar 2006 13:39:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2NLdX8U027868;
	Thu, 23 Mar 2006 13:39:33 -0800
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060323210215.GH26071@mythryan2.michonline.com>
X-Spam-Status: No, hits=2 required=5 tests=PORN_WORD_OSDL4
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17875>



On Thu, 23 Mar 2006, Ryan Anderson wrote:
> 
> Scott Collins (QT evangelist, incredibly smart guy) commented to me
> sometime over the summer, that every new SCM was born out of someone's
> desire to implement a new merge algorithm.  While I think that's too
> simple, I think there have been an awful lot of academic SCMs out there.

The exact details are lost in antiquity, but I'm sure one of the defining 
moments in time for CVS was Dick Grune saying "Merges? We don't need no 
steenking merges! We'll just make branching difficult! Yeah, that's it! 
Mwhahahhahhaaaa!".

The rest is history.

[ Really, the sad part is that you're probably right even when it comes to 
  CVS. The #1 feature of CVS as defined by Brian Berliner in his CVS II 
  paper was 'Concurrent access and conflict-resolution algorithms to 
  guarantee that source changes are not "lost"'. ]

			Linus
