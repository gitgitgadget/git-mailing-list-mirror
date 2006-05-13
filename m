From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sat, 13 May 2006 14:05:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605131404391.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
 <7vzmhlsksm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 13 23:05:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff1Iz-0000BQ-F0
	for gcvg-git@gmane.org; Sat, 13 May 2006 23:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWEMVFi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 17:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWEMVFi
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 17:05:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41395 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751347AbWEMVFi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 17:05:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4DL5XtH015473
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 May 2006 14:05:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4DL5XQ8021597;
	Sat, 13 May 2006 14:05:33 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmhlsksm.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19947>



On Sat, 13 May 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > [ Maybe this can still hit 1.3.3? ]
> 
> Ah, we did not pass the diffopt to the function builtin_diff() in
> 1.3.X series, so not really.

Ahh, ok. Never mind. It's not like people have been clamoring for it, it 
just seemed to be such a _silly_ thing.

Might as well just go into the curren development tree, and then we'll 
have it fixed eventually (1.4.0?)

		Linus
