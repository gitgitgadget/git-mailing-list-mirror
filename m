From: Pavel Roskin <proski@gnu.org>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 02 Jun 2006 00:39:24 -0400
Message-ID: <1149223164.2443.33.camel@dv>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
	 <20060602041107.GA5429@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, Keith Packard <keithp@keithp.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 06:39:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm1Rh-0005gF-CE
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 06:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWFBEje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 00:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWFBEje
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 00:39:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:4007 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751118AbWFBEjd
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 00:39:33 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fm1Rc-00068K-Tr
	for git@vger.kernel.org; Fri, 02 Jun 2006 00:39:33 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fm1RU-0001lt-Sq; Fri, 02 Jun 2006 00:39:24 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060602041107.GA5429@spearce.org>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21145>

On Fri, 2006-06-02 at 00:11 -0400, Shawn Pearce wrote:

> GIT today requires not only a decent UNIX shell but also, GNU tools,
> Perl and Python.  Porting to Solaris has recently had some more
> effort put into it to remove some of the GNU tool dependencies but
> perhaps one of the most important features (git-merge-recursive)
> is a Python script.

The great thing about git is that it's modular.  A single utility can be
replaced and retested in the same environment, without having to rewrite
the rest of the scripts.  A dedicated programmer with good C and Python
skills could rewrite git-merge-recursive.py in C in 2 days, I believe.
Add a few days of bug fixing, of course.

Dependency on Cygwin, Perl and Python is too much.  Windows is becoming
a legacy system in some circles, and it may run on legacy hardware.  Yet
it's irreplaceable as a testing platform for many projects.

I really need to rewrite git-clean in C, since it doesn't handle
embedded newlines properly.

-- 
Regards,
Pavel Roskin
