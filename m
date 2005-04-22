From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] git-pasky debian dir
Date: Fri, 22 Apr 2005 11:45:51 -0700
Message-ID: <20050422184551.GB5324@shell0.pdx.osdl.net>
References: <200504220918.06977.jcorbin@wunjo.org> <20050422161635.GA5324@shell0.pdx.osdl.net> <200504221400.11507.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 20:43:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP35n-0000BA-AS
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 20:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVDVSqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 14:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVDVSqA
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 14:46:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:30102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262105AbVDVSpx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 14:45:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MIjps4027354
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 11:45:51 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MIjpcY007185;
	Fri, 22 Apr 2005 11:45:51 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j3MIjpUY007184;
	Fri, 22 Apr 2005 11:45:51 -0700
To: "Joshua T. Corbin" <jcorbin@wunjo.org>
Content-Disposition: inline
In-Reply-To: <200504221400.11507.jcorbin@wunjo.org>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Joshua T. Corbin (jcorbin@wunjo.org) wrote:
> On 22 April 2005 12:16, Chris Wright <chrisw@osdl.org> wrote:
> > This whole bit should be formalized.
> Agreed, hence why I did it as a package-build-time patch instead of changing 
> directly in my repository.
> 
> > Ideally, I'd like to do /usr/bin/git frontend, with all scripts
> > in /usr/libexec/git/.
> How standard is this '/usr/libexec'? I have no such directory on my Debian 
> boxes. If /usr/share rubs you the wroung way, what of 
> simply /usr/lib/git-pasky?

Hrm, it's not in FHS, but it's certainly in use on my install:

$ find /usr/libexec | wc -l
122

I don't care too much, I imagine distros wind up customizing this
anyway.

> > However, this requires something more than hardcoding paths.
> Definately, and it may not play well with the simpler method of installing to 
> $HOME/bin. This was just a quick hack as not to pollute /usr/bin with files 
> that aren't directly executed by the user.

Yup, that's why I dropped 'em in /usr/local/bin for now.

> > You get the idea ;-)  I certainly see how it makes sense for a first
> > run to get it going. But this will need fixing upstream.
> This will all be moot when cogito goes the way of cg-* ;-)

Hrm...good point.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
