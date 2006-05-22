From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 22 May 2006 15:18:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605221516500.3697@g5.osdl.org>
References: <Pine.LNX.4.64.0605211209080.3649@g5.osdl.org>
 <Pine.LNX.4.64.0605212053590.3697@g5.osdl.org> <44713BE4.9040505@gentoo.org>
 <Pine.LNX.4.64.0605212132570.3697@g5.osdl.org>
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com>
 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org>
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com>
 <44720C66.6040304@gentoo.org> <46a038f90605221241x58ffa2a4o26159d38d86a8092@mail.gmail.com>
 <Pine.LNX.4.64.0605221256090.3697@g5.osdl.org> <20060522214128.GE16677@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Donnie Berkholz <spyderous@gentoo.org>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 23 00:19:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiIk5-00032x-JG
	for gcvg-git@gmane.org; Tue, 23 May 2006 00:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWEVWTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 18:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWEVWTK
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 18:19:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751273AbWEVWTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 18:19:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4MMIatH001522
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 May 2006 15:18:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4MMIZCe015853;
	Mon, 22 May 2006 15:18:35 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20060522214128.GE16677@kiste.smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20540>



On Mon, 22 May 2006, Matthias Urlichs wrote:
> 
> The beast *was* mainly written to do this remotely...

I don't think the remote usability is valid, except for some really small 
repositories. The fact that it takes hours even when the CVS server is 
local doesn't bode well for doing it remotely for any but the most trivial 
things.

I really think it would be better to have local use be the optimized case, 
with remote being the "it's _possible_" case.

		Linus
