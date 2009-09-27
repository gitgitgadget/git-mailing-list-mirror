From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Deciding between Git/Mercurial
Date: Sun, 27 Sep 2009 20:01:47 +0200
Message-ID: <200909272001.48180.robin.rosenberg.lists@dewire.com>
References: <h9nlhj$heq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net
X-From: git-owner@vger.kernel.org Sun Sep 27 20:01:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mry4M-0005Nu-Kv
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 20:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbZI0SBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2009 14:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbZI0SBs
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 14:01:48 -0400
Received: from mail.dewire.com ([83.140.172.130]:18197 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbZI0SBr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Sep 2009 14:01:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 88083147D71C;
	Sun, 27 Sep 2009 20:01:49 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id grbu9hJ9jUDq; Sun, 27 Sep 2009 20:01:48 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id D85A0139DE6A;
	Sun, 27 Sep 2009 20:01:48 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <h9nlhj$heq$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129210>

s=C3=B6ndag 27 september 2009 14:24:32 skrev Anteru <newsgroups@catchal=
l.shelter13.net>:
> Hi,
>=20
> I'm currently evaluating DVCS for a project, and we're at a point whe=
re
> it comes down to either Mercurial or Git. Right now, I'm advocating f=
or
> Git, while my co-workers like Mercurial, so I'd like to provide some
> good arguments in favor of git. Unfortunately, I'm not a git expert, =
so
> I hope I can get some help here ...

You have to read carefully. This (or the mercurial list) may not be the
most objective sources of information.

> First of all, what's the matter with git and Windows, is there some
> long-term commitment to make git work on Windows as well as on Linux?

Besides msysgit there is JGit and a port of it to C# (and  thus any dot=
net-ish=20
language). The msysgit teams seems very committed and passionate about
the project, but they need more assistance from genuine Windows users. =
Note
that the current model of file locking can never work as well on Window=
s
as it does on Unix. Something better is needed for flawless operation.

> I'm using msysgit on Windows, and personally I'm happy with it, but m=
y
> co-workers constantly nag that Mercurial has superior portability ...

Might be somewhat true, but msysgit works very well. Not sure how
mercurial handles unicode issues. CRLF issues seems to be ignored (not =
handled).

> Mercurial's revision number system: With git, I get an SHA1 hash for
> every commit, but it's not possible to see whether Hash1 is newer tha=
n
> Hash2, while Mecurial also adds a running number to each commit. What=
's

But those numbers cannot be communicated since they are local to your
clone.

> the rationale behind this decision for git, and is it possible to
> emulate Mercurial's behavior somehow?

git-cvsserver has to do something along those line  The numbering is
per file.

Maintainers tend to tag versions using the common numbered schem
and that is typically enough.

-- robin
