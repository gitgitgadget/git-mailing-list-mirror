From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 19:42:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702131942290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702131901040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702131037330.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 19:42:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH2cB-0001Cq-5C
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 19:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbXBMSmw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 13:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbXBMSmw
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 13:42:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:37407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751576AbXBMSmv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 13:42:51 -0500
Received: (qmail invoked by alias); 13 Feb 2007 18:42:50 -0000
X-Provags-ID: V01U2FsdGVkX19pXgofEbZpghqmtnbwWWiwZBaXkFNXghxxabJPcu
	fehw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0702131037330.8424@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39580>

Hi,

On Tue, 13 Feb 2007, Linus Torvalds wrote:

> On Tue, 13 Feb 2007, Johannes Schindelin wrote:
> > 
> > No hooks means something like cvsnt does, and that means no .gitattributes 
> > either. (BTW I really hate .gitattributes, as it does not at all say what 
> > this is about; it's about file _conversions_, not attributes).
> 
> No, it *is* about attributes.
> 
> In order to know how to convert, you need to know the attributes of the 
> file.
> 
> So it's not about conversion: we would ALWAYS do conversion. It's about 
> the fact that in order to do the conversion, we need to know what the 
> attributes of the file is - is it text, or what.
> 
> And the equal point is that there are _other_ attributes that git might 
> care about. The "merge strategy" attribute, for example. Or "owner" 
> attributes for files etc.

Yes, you're right. Colour me converted (pun intended).

Ciao,
Dscho
