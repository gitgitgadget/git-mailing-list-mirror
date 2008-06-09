From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: Re: [JGIT PATCH v3 0/23] Implementation of a file tree iteration
 using ignore rules.
Date: Mon, 09 Jun 2008 19:11:30 +0200
Message-ID: <484D6442.7070408@web.de>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <200806060222.40654.robin.rosenberg.lists@dewire.com> <484C0ACA.8080702@web.de> <200806082328.49632.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 19:13:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5kvN-0000Ff-Lc
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 19:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbYFIRL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 13:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752860AbYFIRL7
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 13:11:59 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49792 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbYFIRL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 13:11:58 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 760D0DF31FC8;
	Mon,  9 Jun 2008 19:11:57 +0200 (CEST)
Received: from [84.150.100.139] (helo=[192.168.1.50])
	by smtp07.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K5kuT-0003wR-00; Mon, 09 Jun 2008 19:11:57 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <200806082328.49632.robin.rosenberg.lists@dewire.com>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX18j1OPxgmxKYRfHpCZy5JHGgVEfAZPK7rCA02FY
	8DY2yd8j4i/NNSHUSqosX9zZkFBlTWGHCYOMFM6OKWUs5yKrKB
	jZbvfAhle2Lb/HUqsv+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84404>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robin Rosenberg wrote:
| Oh, it does. [:alpha:] is a character class, like a-z. So you use
[[:alpha:]], which is what git as well as bash
| understands.
Naturally I will then implement the POSIX character classes as listed a=
t
(http://en.wikipedia.org/wiki/Regular_expression#POSIX_character_classe=
s)
for FileNameMatcher too.


|
|> The fnmatch function of the python module fnmatch
|> (http://docs.python.org/lib/module-fnmatch.html) does not support
|> :alpha: too.
|>
|> example:
|> $python
|>  >>> from fnmatch import fnmatch
|>  >>> fnmatch("a","[:alpha:]")
|> False
| Hmm. Odd:
[...]
|>>> fnmatch("a","[:alpha:]")
| True
Oops.. of course the output was True for me too, but for
fnmatch("b","[:alpha:]") it wasn't.

Best Regards,
=46lorian K=F6berle
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFITWRC59ca4mzhfxMRAjdrAJ9/6VDQOOHdm0WGP/W+l84LiKrOhQCfdkJn
DEcnz0WTzockGJ+w9S1/4xk=3D
=3D/PpE
-----END PGP SIGNATURE-----
