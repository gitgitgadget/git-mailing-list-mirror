From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: StGit: kha/{stable,safe,experimental} updated
Date: Mon, 14 Apr 2008 08:44:29 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-04-14-08-44-30+trackit+sam@rfc1149.net>
References: <20080413191140.GA1912@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 08:45:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIRS-0003SG-HN
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 08:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYDNGom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 02:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbYDNGom
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 02:44:42 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:35044 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbYDNGol convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 02:44:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 68900E0D54;
	Mon, 14 Apr 2008 08:44:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PXuV60dpcman; Mon, 14 Apr 2008 08:44:31 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id B947AE0485;
	Mon, 14 Apr 2008 08:44:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id DE254C408D;
	Mon, 14 Apr 2008 08:44:30 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QM9j4xV2IMYm; Mon, 14 Apr 2008 08:44:30 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 5CF54C40B9; Mon, 14 Apr 2008 08:44:30 +0200 (CEST)
In-Reply-To: <20080413191140.GA1912@diana.vm.bytemark.co.uk> ("Karl
 =?iso-8859-1?Q?Hasselstr=F6m=22's?= message of "Sun\, 13 Apr 2008
 21\:11\:40 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79466>

>>>>> "Karl" =3D=3D Karl Hasselstr=F6m <kha@treskal.com> writes:

Karl> In the experimental branch, I've updated the reset command a bit
Karl> -- it should now be quite usable. Bug reports and feature
Karl> requests and general comments welcome. (Note to those who
Karl> already run my experimental branch: I've changed the stack log
Karl> format, so you'll have to nuke your <branchname>.stgit
Karl> branches. StGit will remind you if you forget.)

Karl,

I was using the StGit in Debian/unstable and just switched to your
experimental branch.

When doing "stg pull", I get, at the end:

Pushing patch "pr20822" ... done
Pushing patch "pr22387" ... done
Pushing patch "pr30614" ... done
Error: Unhandled exception:
Traceback (most recent call last):
  File "/usr/local/lib/python2.4/site-packages/stgit/main.py", line
  280, in main
    ret =3D command.func(parser, options, args)
  File
  "/usr/local/lib/python2.4/site-packages/stgit/commands/pull.py",
  line 109, in func
    log.log_entry(log.default_stack(), 'stg pull')
  File "/usr/local/lib/python2.4/site-packages/stgit/lib/log.py", line
  45, in log_entry
    stack.repository.refs.get(ref))]
  File "/usr/local/lib/python2.4/site-packages/stgit/lib/log.py", line
  94, in __init__
    self.unapplied, patches =3D pl('unapplied')
  File "/usr/local/lib/python2.4/site-packages/stgit/lib/log.py", line
  89, in pl
    return ([pn for sha1, pn in patches],
ValueError: need more than 0 values to unpack

Note that I have no unapplied patch in case it matters, only hidden
ones (and applied ones of course).
