From: Joi Ellis <gyles19@visi.com>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Sun, 1 Mar 2009 09:56:46 -0600 (CST)
Message-ID: <Pine.LNX.4.44.0903010945290.4675-100000@localhost.localdomain>
References: <7vskmr43le.fsf@gitster.siamese.dyndns.org>
Reply-To: gyles19@visi.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Miles Bader <miles@gnu.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 16:59:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldo4K-0000a6-0O
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 16:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbZCAP5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 10:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755487AbZCAP5i
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 10:57:38 -0500
Received: from mailfront2.g2host.com ([208.42.176.213]:42193 "EHLO g2host.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755443AbZCAP5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 10:57:37 -0500
Received: from [209.98.98.8] (account gyles19@visi.com HELO localhost)
  by mailfront2.g2host.com (CommuniGate Pro SMTP 5.1.16)
  with ESMTPSA id 90943551; Sun, 01 Mar 2009 09:57:34 -0600
X-X-Sender: joi@localhost.localdomain
In-Reply-To: <7vskmr43le.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111850>

On Fri, 6 Feb 2009, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Now, in this case, it was only one tweak and other responders have
> > already pointed him in the right direction. So just making that tweak
> > manually is probably the sane thing to do in this situation.
> >
> > But I wanted to point out that autoconf is not totally without value
> > here.
> 
> I am not saying something that strong, either.  If autoconf generated
> configure works _for you_ without hassle, great.  Keep using it.
> 
> The original message that started this thread was what to do when it does
> NOT work for you, and my point was in general it is much nicer to point at
> the knob to tweak from the make invocation command line (or in config.mak)
> than having you spend time on upgrade autoconf, generate configure and run
> it.

Actually, guys, if you go back and re-read my original message, I was
pointing out that if you use a 'git clone' to get a build tree, THERE IS
NO CONFIGURE SCRIPT in the tree.

The problem is not that the configure script does not work.  I pointed
out in the first paragraph that the configure script in the TARBALL
works just fine.  What I pointed out is that the build tree DOES NOT
PROVIDE THE CONFIGURE SCRIPT.  All I asked you to do is to consider
adding the configure script to the repository so that it gets pushed out 
in a clone.

> Fanboys may say that autoconf generated configure is the greatest thing
> since sliced bread.  But let's face it.  Honestly, the track record of
> those people in keeping autoconf part in this project up-to-date has not
> been all that great.  There are things that the generated configure file
> does not detect nor configure correctly (we had --with-expat patch, and we
> also saw "the trailing slash in template_dir definition in config.mak.in"
> discussed fairly recently).  You are much better off tweaking known
> peculiarity of your platform in config.mak, when configure does not work
> out of box for you.

I've been building and installing multi-platform *nix software on
various flavors for two decades now.  "./configure && make && make install" has 
been the standard build process even before GNU.  The whole point of
autoconf/configure/make tools is to eliminate the need to manually tweak
makefiles so that software is easily portable between platforms. 

I got such a rash of SNOTTY messages from you folks, all directed to me
privately, that I nearly deleted git from my laptop altogether.  You can be
sure I will not bother attempting to build git from a clone ever again.
I took the time to debug and diagnose the build failures I was getting,
and I tried to politely pass it along in case anyone cares.

Clearly, you don't.  I shall not waste your or my time any further.

-- 
Joi Ellis                    
gyles19@visi.com

No matter what we think of Linux versus FreeBSD, etc., the one thing I
really like about Linux is that it has Microsoft worried.  Anything
that kicks a monopoly in the pants has got to be good for something.
           - Chris Johnson
