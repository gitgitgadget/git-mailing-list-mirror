From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Wed, 20 Apr 2005 15:09:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
References: <20050420205633.GC19112@pasky.ji.cz> <20050420211919.GA20129@kroah.com>
 <20050420215117.GJ19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 00:04:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONHl-0005Y2-44
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVDTWHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbVDTWHT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:07:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:27327 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261830AbVDTWHL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 18:07:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3KM78s4009654
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Apr 2005 15:07:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3KM77LF031358;
	Wed, 20 Apr 2005 15:07:07 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050420215117.GJ19112@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Petr Baudis wrote:
> 
> Grm. Cg is also name of some scary NVidia thing, and cog is GNOME
> Configurator. CGT are Chimera Grid Tools, but I think we can clash
> with those - at least *I* wouldn't mind. ;-)

I realize that there is probably a law that there has to be a space, but I 
actually personally use tab-completion all the time, and in many ways 
prefer a name that can be completed without having to play games with 
magic bash completion files.

So how about using a dash instead of a space, and making things be

	cg-pull
	cg-update

etc? You can link them all to the same script if you don't like having 
multiple scripts, and just match with

	case "$0" in
	*-pull)
		...
		;;
	*-update)
		...
		;;

or something.

Yeah, yeah, it looks different from "cvs update", but dammit, wouldn't it 
be cool to just write "cg-<tab><tab>" and see the command choices? Or 
"cg-up<tab>" and get cg-update done for you..

Just because rcs/cvs/everybody-and-his-dog thinks it is cool to have a 
space there and have different meaning for flags depending on whether they 
are before the command or after the command doesn't mean that they are 
necessarily right..

Just an idea,

		Linus
