From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 08:15:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
 <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
 <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 17:15:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcNzw-0001HF-Gv
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 17:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWJXPPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 11:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWJXPPU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 11:15:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965161AbWJXPPT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 11:15:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9OFF6aX029821
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 Oct 2006 08:15:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9OFF5Tn003503;
	Tue, 24 Oct 2006 08:15:06 -0700
To: David Rientjes <rientjes@cs.washington.edu>
In-Reply-To: <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29982>



On Mon, 23 Oct 2006, David Rientjes wrote:
> 
> Some of the internal commands that have been coded in C are actually much 
> better handled by the shell in the first place.  It's much simpler to 
> write and extend as well as being much more traceable for runtime 
> problems.

Yes. However, from a portability (to Windows) standpoint, shell is just 
about the worst choice.

Not that perl/python/etc really help - unless the _whole_ program is one 
perl/python thing. Windows just doesn't like pipelines etc very much.

So I'd like all the _common_ programs to be built-ins..

		Linus
