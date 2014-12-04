From: Mike Gerwitz <mikegerwitz@gnu.org>
Subject: Re: git log --pretty="format:%H$t%aN$t%s$t%G?" --show-signature
Date: Thu, 04 Dec 2014 13:05:38 -0500
Message-ID: <871tofuw7h.fsf@gnu.org>
References: <54809802.6030609@whonix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Whonix-devel <whonix-devel@whonix.org>
To: Patrick Schleizer <patrick-mailinglists@whonix.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:05:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwamp-0001DB-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbaLDSFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 13:05:48 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:46082 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861AbaLDSFq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 13:05:46 -0500
Received: from cpe-69-204-47-184.buffalo.res.rr.com ([69.204.47.184]:34774 helo=mikegerwitz-pc.gerwitz.local.gnu.org)
	by fencepost.gnu.org with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <mikegerwitz@gnu.org>)
	id 1Xwamf-0002g0-FT; Thu, 04 Dec 2014 13:05:45 -0500
In-Reply-To: <54809802.6030609@whonix.org> (Patrick Schleizer's message of
	"Thu, 04 Dec 2014 17:21:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260773>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey Patrick,

On Thu, Dec 04, 2014 at 17:21:06 +0000, Patrick Schleizer wrote:
> git log --pretty="format:%H$t%aN$t%s$t%G?" --show-signature
> [...]
> But when I run that command, spaces are missing. (Using a user that does
> not know my gpg public key for testing purposes.) See output:
>
> -----
>
> user2@host:/home/user/testrepo$ git log
> --pretty="format:%H$t%aN$t%s$t%G?" --show-signature

That is because the variable `$t' is defined in my script on the
preceding line, as a tab character.  You can insert it directly using
C-V <TAB>, or $'\t' in bash.

> Mike, could you please put your various git commit verification helper
> scripts into a publicly visible?

You can use this:

  https://gitorious.org/easejs/easejs/source/ee85b058df783ffaa9f8d5ae58f9eb6d7586b0ca:tools/signchk

But note that the default value of the `chkafter' var is
ease.js-specific.

> By the way, any chance that these useful helper scripts could make their
> way into the official distribution of git as a stopgap until native git
> commit verification support gets improved?

It has since improved; I'm looking for the time to update the article,
or write a follow-up.

Git has since added other pretty formatting options as well:

  https://github.com/git/git/blob/master/Documentation/pretty-formats.txt#L140

Git v2.1.0 also added a `verify-commit' command:

  https://github.com/git/git/blob/master/Documentation/git-verify-commit.txt

I haven't used it yet.

Hope that helps.

- -- 
Mike Gerwitz
Free Software Hacker | GNU Maintainer
http://mikegerwitz.com
FSF Member #5804 | GPG Key ID: 0x8EE30EAB
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJUgKJyAAoJEPIruBWO4w6rdS8QAMEtQhklDe4zXju0uc6ksqYl
aXdXhE7HcyUDl6yWXEheXH4oCRLSthS+8MPQfuY8gae1eRvyHx3rViGpMEyB8s5B
xhAQpOLVmro0QIwIZ/HGX4IKoGVq/QyqvLNR8iqnV8GXPu+ckGIG/UvrkFFSaLW8
eFUvQLbNITViVgQljCzzfptL9dQvdra0D1EXxRk8+h8Sw4vKRN54h0tqKVw5PcsT
4sFUBVwgmzILNKydFkMu1C+pDwnemhS04PtcrpmUTniOzLPhWJiZwzgDV5j9tOPq
7noLrnw0kpm6PbX90i2+uSVGmh6zgoR69h7SAZGJEiHQj4BiZetLMwxJL25o73/c
1/9tWT/7kAcpvzAjPjRMS3BqV7AVwNqTKKblCszfunS87aWLs1t/bgUg4e6x3lTJ
JxyxkKnSnn3dzntMfB9UuuJ6bdtn1pJci4Ptvl2yzKHaZv7ImV78UIuxdthtMgMn
eBawq3wm7HBMETkDDyRSpuPOEycBSnWZL2dL4Xc9IxPKDTJUvHTRUXxy4v2Juiv9
Pogao25j6EpTlOqx29Y9Y95ITw/UdQU7NjPAGFNxIZZTgjzHrcIlaEKuoHp+t6oh
s8OPhD+FMNWBFdAda+zP785sUbyF93/2xBK/HFyTUinOLn1/BJBC0FqHfeYd1hQe
cJ0rYnOtckycQv+re9hz
=+Rub
-----END PGP SIGNATURE-----
