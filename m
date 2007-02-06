From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 09:24:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702060921260.8424@woody.linux-foundation.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com>
 <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org>
 <20070206164441.GA4949@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 18:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEU48-0007Y6-4o
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 18:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbXBFRY6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 12:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932999AbXBFRY6
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 12:24:58 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41527 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622AbXBFRY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 12:24:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l16HOqmA030611
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Feb 2007 09:24:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l16HOpSr023401;
	Tue, 6 Feb 2007 09:24:51 -0800
In-Reply-To: <20070206164441.GA4949@spearce.org>
X-Spam-Status: No, hits=-0.42 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.112__
X-MIMEDefang-Filter: osdl$Revision: 1.174 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38863>



On Tue, 6 Feb 2007, Shawn O. Pearce wrote:
> 
> What about this language?
> 
> 	The time of the change is specified by `<time>` as the number of
> 	seconds since the UNIX epoc (midnight, Jan 1, 1970, UTC) and is
> 	written in base-10 notation using US-ASCII digits.  The committer's
> 	timezone is specified by `<tz>` as a positive or negative offset
> 	from UTC.  For example EST (which is typically 5 hours behind GMT)
> 	would be expressed in `<tz>` by ``-0500'' while GMT is ``+0000''.

I doubt it would confuse anybody. Although usually we'd not say

	"in base-10 notation using US-ASCII digits"

the normal way to do that is to just saying "as an ASCII decimal integer".

Sure, people could try to do "10,200,300" and claim it's "decimal 
integer", but at that point, you can just tell them they're crazy, and 
ignore them ;)

But your text certainly isn't wrong. I just think it overspecifies a bit, 
at the expense of readability.

		Linus
