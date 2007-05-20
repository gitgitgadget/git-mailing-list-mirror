From: Johan Herland <johan@herland.net>
Subject: Re: RFC: submodule terminology
Date: Mon, 21 May 2007 01:16:24 +0200
Message-ID: <200705210116.25079.johan@herland.net>
References: <20070520214417.GM5412@admingilde.org>
 <200705210006.47266.johan@herland.net> <20070520230352.GQ5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Martin Waitz <tali@admingilde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 21 01:17:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpueF-000552-0W
	for gcvg-git@gmane.org; Mon, 21 May 2007 01:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758066AbXETXRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 19:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758151AbXETXRI
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 19:17:08 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35196 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758066AbXETXRG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 19:17:06 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JID00H074OEQ600@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 01:17:02 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JID00E7C4ND1S30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 01:16:25 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JID00IS14NDTC50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 21 May 2007 01:16:25 +0200 (CEST)
In-reply-to: <20070520230352.GQ5412@admingilde.org>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47952>

On Monday 21 May 2007, Martin Waitz wrote:
> hoi :)
> 
> On Mon, May 21, 2007 at 12:06:47AM +0200, Johan Herland wrote:
> > For the high-level concept, "subproject" seems to me the best 
> > alternative. I think it is much better than "submodule" at 
> > describing that the subproject is a stand-alone project/repo in
> > itself.
> 
> it may be developed independently but for the sake of the more important
> bigger ("the top level project") it really is only one small part.
> That and the fact that "module" is already an established term
> in software makes me prefer "submodule".
> For me the project is always the top-level one: the project you
> currently work for.

"The project you currently work for" depends on your POV. But I agree
that using the term "project" alone might be confusing. That's why I'd
rather talk about "superproject" and "subproject". That way, there's
no ambiguity at all.

> > As for the low-level concept, I personally prefer "gitlink", but 
> > I don't have any strong feelings. The fact that "gitlink" seems 
> > to already be used in the code (as in resolve_gitlink_ref() etc.), 
> > coupled with "dirlink" being somewhat ambiguous (i.e. may also be 
> > interpreted as "(sym)link to directory") makes the case for me.
> 
> The only problem I have with gitlink is that there already was
> a lot of discussion about some entirely different "gitlink", so
> choosing a different name is not that bad.
> Aside from that I prefer gitlink, too.

The term "gitlink" is ambiguous/confusing? I didn't know. What's the 
other meaning of gitlink?

(Unless you're talking about gitlink as in "gitlink:git[7]" which 
appears all over our asciidoc documentation, but I don't think that 
counts...)


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
