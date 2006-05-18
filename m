From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Shipping man pages?
Date: Thu, 18 May 2006 11:49:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605181142190.10823@g5.osdl.org>
References: <20060518074630.GA2994@code-monkey.de> <7vac9f69la.fsf@assigned-by-dhcp.cox.net>
 <1147945298.1320.35.camel@mjollnir> <7vodxvkws8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Rosenstand <mark@borkware.net>, git@vger.kernel.org,
	Tilman Sauerbeck <tilman@code-monkey.de>
X-From: git-owner@vger.kernel.org Thu May 18 20:49:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgnZC-0004rT-75
	for gcvg-git@gmane.org; Thu, 18 May 2006 20:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWERStm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 14:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWERStm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 14:49:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51150 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751377AbWERStl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 14:49:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4IInEtH026145
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 May 2006 11:49:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4IIn73a030052;
	Thu, 18 May 2006 11:49:11 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodxvkws8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20298>



On Thu, 18 May 2006, Junio C Hamano wrote:
> 
> That's a consequence of _your_ choice to build the documentation
> files from the source, when I give you preformatted files in
> html/man branches and/or prepackaged binary distributions.  Even
> plain "make all" nor "make install" do not build them.

Btw, in case others didn't notice, the easiest way to install the 
pre-packaged branch is a truly disgusting hack:

	cd git
	git tar-tree man | (cd /usr/share/man ; tar xvf -)

or similar (yeah, you need to be root to do the unpack, of course, and 
you may need to change the /usr/share/man to whatever is appropriate for 
your distribution).

No need to actually even check out the 'man' branch.

		Linus
