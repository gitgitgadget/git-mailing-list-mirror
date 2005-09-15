From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 20:29:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509142029210.26803@g5.osdl.org>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
 <7vwtljjzc3.fsf@assigned-by-dhcp.cox.net> <59a6e583050914114054b1564d@mail.gmail.com>
 <Pine.LNX.4.58.0509141321180.26803@g5.osdl.org> <17192.56103.803096.526568@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wayne Scott <wsc9tt@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 05:31:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFkRx-0000IB-56
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 05:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVIODaF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 23:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbVIODaF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 23:30:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26596 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750904AbVIODaD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 23:30:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8F3TqBo011844
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 20:29:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8F3To3o010955;
	Wed, 14 Sep 2005 20:29:51 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17192.56103.803096.526568@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8582>



On Thu, 15 Sep 2005, Paul Mackerras wrote:
>
> Linus Torvalds writes:
> 
> > Damn, too bad valgrind doesn't work on ppc64, so I can't use it on my main 
> > machine. It seems to be in development on ppc32, so maybe some day.
> 
> How about... today? :-)  My port of Valgrind-2.4.1 to ppc32 works
> pretty well.  You can get it from:
> 
> http://www.valgrind.org/downloads/variants.html?pmk

Ahh. Compiling right now.

> I assume you're compiling git as 32-bit executables on your G5.  I
> don't see any reason why the git binaries would need to be 64-bit.

I use whatever the defaults are. And yes, it seems to me -m32.

		Linus
