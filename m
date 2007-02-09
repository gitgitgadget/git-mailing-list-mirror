From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 16:17:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702081613370.8424@woody.linux-foundation.org>
References: <17866.27739.701406.722074@lisa.zopyra.com>
 <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
 <17867.40122.51865.575762@lisa.zopyra.com> <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
 <17867.45437.922483.805945@lisa.zopyra.com> <20070208233324.GA1556@spearce.org>
 <17867.46325.433406.974582@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 01:17:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJSe-0000cN-RX
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 01:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422759AbXBIARw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 19:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422767AbXBIARw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 19:17:52 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46758 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422759AbXBIARv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 19:17:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l190Hj3O007708
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 8 Feb 2007 16:17:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l190Hhma031782;
	Thu, 8 Feb 2007 16:17:44 -0800
In-Reply-To: <17867.46325.433406.974582@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.44 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39135>



On Thu, 8 Feb 2007, Bill Lear wrote:
> 
> So, I assume I need to tell our developers that once we have installed
> the new git, they will need to set aside their old repos and just
> clone again from our company repo?

Not unless they want to take advantage of *all* the new features.

The new version of git will work fine with old repositories, both on the 
"server" side and the "user" side. And people can use a lot of the new 
features even if they do nothing at all.

But for the _specific_ case of having a clearly separated "local branch" 
vs "remote branch" case, you do need to make that distinction clear when 
you create the repository (unless you want to get really down and dirty 
with the repo and just modify it yourself: certainly possible but 
generally just not worth the effort since it's just easier to clone a new 
one instead).

So it's really a matter of how you use it. Switching to a new version of 
git on the "server side" (ie the shared repository operations) won't 
really affect anything at all. 

		Linus
