From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel headers git tree
Date: Thu, 13 Jul 2006 22:52:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607132251310.5623@g5.osdl.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org> 
 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
 <1152840456.31372.75.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 07:52:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1GbV-0000pw-I5
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 07:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161048AbWGNFwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 01:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWGNFwm
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 01:52:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161048AbWGNFwm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 01:52:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6E5qZnW025756
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Jul 2006 22:52:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6E5qYIE031221;
	Thu, 13 Jul 2006 22:52:35 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152840456.31372.75.camel@shinybook.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23877>



On Fri, 14 Jul 2006, David Woodhouse wrote:
> 
> > But that thing is doubly strange, because it uses "." as a path specifier. 
> > If this is done in the top-most directory, that should mean "all changes", 
> > which in turn means that the whole thing should be equivalent to
> > 
> > 	git rev-parse "$1^0"
> > 
> > since all commits should make _some_ change, and thus the first revision 
> > in the list should always be the top commit - the one you passed in as an 
> > argument.
> 
> In this case, I really do have commits in the intermediate tree which
> don't actually change anything, and I want to filter them out -- I
> couldn't see a simple way to do it all in one pass.

Btw, I'm actually surprised that my path simplification didn't filter out 
the "." and make it mean exactly the same as not giving a path at all. I 
thought I had done that earlier, but if you say "-- ." matters, then it 
obviously does..

		Linus
