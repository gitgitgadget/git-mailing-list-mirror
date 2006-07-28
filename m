From: Pavel Roskin <proski@gnu.org>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Fri, 28 Jul 2006 03:08:59 -0400
Message-ID: <20060728030859.n8ks44ck8884ss44@webmail.spamcop.net>
References: <20060728063620.GD30783@spearce.org>
	<slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 09:09:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6MTD-00050e-GU
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 09:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWG1HJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 03:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbWG1HJB
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 03:09:01 -0400
Received: from mailgate.cesmail.net ([216.154.195.36]:35010 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP
	id S1751796AbWG1HJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 03:09:00 -0400
Received: (qmail 18920 invoked from network); 28 Jul 2006 07:08:59 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 28 Jul 2006 07:08:59 -0000
Received: (qmail 12317 invoked by uid 99); 28 Jul 2006 07:08:59 -0000
Received: from pool-68-236-7-143.phil.east.verizon.net
	(pool-68-236-7-143.phil.east.verizon.net [68.236.7.143]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Fri, 28 Jul 2006 03:08:59 -0400
To: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
In-Reply-To: <slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24371>

Quoting Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>:

> On 2006-07-28, Shawn Pearce <spearce@spearce.org> wrote:
> > My Java GIT library and Eclipse GIT team provider is now at a point
> > where it may be partially useful to someone else who is also trying
> > to write something which interacts with GIT.  Or who might also
> > be interested in seeing a pure-Java Eclipse team provider for GIT.
> >
> > So I've posted my repository (currently ~200 KB) on my website:
> >
> >   http://www.spearce.org/projects/scm/egit.git
> >
>
> Doesn't work for me.

Neither does it for me:

$ git clone http://www.spearce.org/projects/scm/egit.git
error: File ac32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2
(http://www.spearce.org/projects/scm/egit.git/objects/ac/32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2)
corrupt
Getting pack list for http://www.spearce.org/projects/scm/egit.git/
error: XML error: not well-formed (invalid token)

> *** glibc detected *** double free or corruption (!prev): 0x080933b0 ***
> /usr/bin/git-clone: line 29: 10712 Aborted                 git-http-fetch -v
> -a -w "$tname" "$name" "$1/"

I'm not getting that.  I hope you are just using an obsolete version of git.

--
Regards,
Pavel Roskin
