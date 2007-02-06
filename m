From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 08:37:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 17:38:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HETL2-000325-Lz
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 17:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbXBFQiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 11:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbXBFQiF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 11:38:05 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39808 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965041AbXBFQiE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 11:38:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l16GbxmA028409
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Feb 2007 08:38:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l16GbwqU022270;
	Tue, 6 Feb 2007 08:37:59 -0800
In-Reply-To: <200702060928.54440.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.421 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.173 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38857>



On Tue, 6 Feb 2007, Andy Parkins wrote:
> 
> Is <tz> /really/ expressed in minutes?  500 minutes is 8 hours 20 minutes.
> 
> I know what you mean, of course; and so would anyone reading it - so I suggest 
> just dropping the ", in minutes" - as it's not true.

Agreed. It _is_ "in minutes", but it's in an oddish human-readable base-60 
format. It's certainly *not* decimal, it's more like "two decimal digits 
encode each base-60 digit in the obvious way".

		Linus
