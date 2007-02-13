From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 10:39:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702131037330.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702131901040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH2ZW-000870-U0
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbXBMSj2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbXBMSj2
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:39:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48055 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbXBMSj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:39:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1DIdKhB031911
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 10:39:21 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1DIdJfg005788;
	Tue, 13 Feb 2007 10:39:20 -0800
In-Reply-To: <Pine.LNX.4.63.0702131901040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.421 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39578>



On Tue, 13 Feb 2007, Johannes Schindelin wrote:
> 
> No hooks means something like cvsnt does, and that means no .gitattributes 
> either. (BTW I really hate .gitattributes, as it does not at all say what 
> this is about; it's about file _conversions_, not attributes).

No, it *is* about attributes.

In order to know how to convert, you need to know the attributes of the 
file.

So it's not about conversion: we would ALWAYS do conversion. It's about 
the fact that in order to do the conversion, we need to know what the 
attributes of the file is - is it text, or what.

And the equal point is that there are _other_ attributes that git might 
care about. The "merge strategy" attribute, for example. Or "owner" 
attributes for files etc.

		Linus
