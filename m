From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 13:26:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605171325200.10823@g5.osdl.org>
References: <8aa486160605161507w3a27152dq@mail.gmail.com> 
 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>  <8aa486160605161542u704ccf03w@mail.gmail.com>
  <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de> 
 <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com> 
 <8aa486160605170641p2ab8704o@mail.gmail.com> <e4f9eo$b60$1@sea.gmane.org> 
 <1147893786.16654.5.camel@dv>  <20060517153903.6b896fdd.seanlkml@sympatico.ca>
 <1147895816.30618.6.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 22:26:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgSbU-0008Cp-MV
	for gcvg-git@gmane.org; Wed, 17 May 2006 22:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWEQU0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 16:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWEQU0l
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 16:26:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751088AbWEQU0l (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 16:26:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HKQXtH008015
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 13:26:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HKQWmQ025274;
	Wed, 17 May 2006 13:26:33 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1147895816.30618.6.camel@dv>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20240>



On Wed, 17 May 2006, Pavel Roskin wrote:

> On Wed, 2006-05-17 at 15:39 -0400, Sean wrote:
> > On Wed, 17 May 2006 15:23:06 -0400
> > Pavel Roskin <proski@gnu.org> wrote:
> > 
> > Shouldn't git just always respect the ignore rules?  Forcing someone to
> > remove a file from the .gitignore or employ the other work around
> > mentioned earlier doesn't seem too bad.  How often are people adding
> > files that are explicitly ignored?
> 
> That's a good idea!  And the implementation should be easy - if the file
> is present, but git-ls-file doesn't show it, tell the user to
> adjust .gitignore or to use some flag like --force.

Umm. That's exactly the semantics for "git add" right now. We _always_ 
respect the ignore rules.

That was what people were complaining about.

Although I think Santi realized why we do it, and isn't even complaining 
any more. 

So we're all good again.

		Linus
