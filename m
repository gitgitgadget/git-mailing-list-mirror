From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Fri, 20 Oct 2006 10:48:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201045550.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
 <200610201821.34712.jnareb@gmail.com> <45390168.6020502@utoronto.ca>
 <20061020172125.GF18019@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 19:49:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GayUd-00061W-Dv
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 19:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992530AbWJTRtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 13:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992540AbWJTRtM
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 13:49:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992530AbWJTRtK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 13:49:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KHn0aX027660
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 10:49:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KHmwtT027570;
	Fri, 20 Oct 2006 10:48:59 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061020172125.GF18019@spearce.org>
X-Spam-Status: No, hits=-0.973 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29511>



On Fri, 20 Oct 2006, Shawn Pearce wrote:
> 
> I renamed hundreds of small files in one shot and also did a few
> hundered adds and deletes of other small XML files.  Git generated
> a lot of those unrelated adds/deletes as rename/modifies, as their
> content was very similiar.  Some people involved in the project
> freaked as the files actually had nothing in common with one
> another... except for a lot of XML elements (as they shared the
> same DTD).

Heh. We can probably tweak the heuristics (one of the _great_ things about 
content detection is that you can fix it after the fact, unlike the 
alternative).

That said, I've personally actually found the content-based similarity 
analysis to often be quite informative, even when (and perhaps 
_especially_ when) it ended up showing something that the actual author of 
the thing didn't intend.

So yeah, I've seen a few strange cases myself, but they've actually been 
interesting. Like seeing how much of a file was just a copyright license, 
and then a file being considered a "copy" just because it didn't actually 
introduce any real new code.

			Linus
