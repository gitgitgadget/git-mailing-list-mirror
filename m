From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Autoconf/Automake
Date: Wed, 14 Jun 2006 15:45:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606141538500.5498@g5.osdl.org>
References: <1150324030.23268.12.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 00:45:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqe7P-0006Ji-9I
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 00:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWFNWph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 18:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWFNWph
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 18:45:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38835 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964882AbWFNWpg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 18:45:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5EMjTgt017581
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Jun 2006 15:45:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5EMjTgW023632;
	Wed, 14 Jun 2006 15:45:29 -0700
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1150324030.23268.12.camel@dv>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21870>



On Wed, 14 Jun 2006, Pavel Roskin wrote:
> 
> Is there any interest in converting the build system used by git to
> Autoconf and Automake?  The ad-hoc configuration in Makefile is getting
> too big.

NO! At least the Makefile is debuggable and understandable.

If we need a better build system, I'd much rather use something 
higher-level that can generate VC++ project files etc. 

In other words, I'd much rather see us using CMake or something like that, 
which actually adds real value-add.

(And no, I've never used cmake, so maybe it has horrors waiting for us 
too, but autoconf is just worthless).

			Linus
