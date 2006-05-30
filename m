From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: irc usage..
Date: Mon, 29 May 2006 17:43:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291742520.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org> 
 <46a038f90605220042v369e9ff5o3dc7841472171d02@mail.gmail.com> 
 <Pine.LNX.4.64.0605220203200.3697@g5.osdl.org> 
 <46a038f90605220554y569c11b9p24027772bd2ee79a@mail.gmail.com> 
 <44720C66.6040304@gentoo.org>  <Pine.LNX.4.64.0605221234430.3697@g5.osdl.org>
  <447215D4.5020403@gentoo.org>  <Pine.LNX.4.64.0605221312380.3697@g5.osdl.org>
  <447231C4.2030508@gentoo.org> <447B6D85.4050601@gentoo.org>
 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
 <447B7669.8050805@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Yann Dirson <ydirson@altern.org>,
	Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 30 02:44:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FksLP-0005S7-3E
	for gcvg-git@gmane.org; Tue, 30 May 2006 02:44:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWE3AoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 20:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWE3AoU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 20:44:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751262AbWE3AoT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 20:44:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4U0hx2g029184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 17:43:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4U0hvOA022793;
	Mon, 29 May 2006 17:43:58 -0700
To: Donnie Berkholz <spyderous@gentoo.org>
In-Reply-To: <447B7669.8050805@gentoo.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21001>



On Mon, 29 May 2006, Donnie Berkholz wrote:
> 
> Looking closer, I see that the memory suckers do appear to be git, from
> dmesg:
> 
> Out of Memory: Kill process 17230 (git-repack) score 97207 and children.
> Out of memory: Killed process 17231 (git-rev-list).

Sounds like you had the "git repack -a -d" thing in your cvsimport.

The current git rev-list should use only about a third of the memory of 
the one you used, so hopefully you could just update your git version, and 
then continue with the "git cvsimport" without having to start all over.

		Linus
