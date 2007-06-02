From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] Create a new manpage for the gitignore format, and reference
 it elsewhere
Date: Fri, 01 Jun 2007 17:52:53 -0700
Message-ID: <4660BF65.3000605@freedesktop.org>
References: <46609BC4.9000508@freedesktop.org> <20070601234710.GW3242@planck.djpig.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA030AE7433653D1A078E4614"
Cc: git@vger.kernel.org, 427078@bugs.debian.org
To: Frank Lichtenheld <djpig@debian.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 02:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuHrw-0001Ja-Qf
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 02:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbXFBAxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 20:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754786AbXFBAxR
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 20:53:17 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:51527 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbXFBAxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 20:53:16 -0400
Received: (qmail 4067 invoked from network); 2 Jun 2007 00:53:16 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <djpig@debian.org>; 2 Jun 2007 00:53:15 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <20070601234710.GW3242@planck.djpig.de>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48901>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA030AE7433653D1A078E4614
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Frank Lichtenheld wrote:
> On Fri, Jun 01, 2007 at 03:20:52PM -0700, Josh Triplett wrote:
>> Signed-off-by: Josh Triplett <josh@freedesktop.org>
>> Signed-off-by: Josh Triplett <josh@freedesktop.org>
>=20
> :) (Wanted to make some funny remark, but its too late here to be funny=

> in a foreign language...)

Argh.  git-commit -s --amend signed a second time.  Sorry I missed this.

>>  Documentation
>>  --------------
>> -Documentation by David Greaves, Junio C Hamano and the git-list <git@=
vger.kernel.org>.
>> +Documentation by David Greaves, Junio C Hamano, Josh Triplett, and th=
e git-list <git@vger.kernel.org>.
>=20
> No offence, but adding your name here for removing content? ;)

I intentionally avoided adding my name to the pages in which I only remov=
ed
content, or only added a reference to gitignore(5).  In the case of
git-ls-files, I rewrote some of the material.  However, I don't care that=

strongly about the credit.

>> +Some git plumbing tools, such as git-ls-files(1) and
>> +git-read-tree(1), read `gitignore` patterns specified by
>> +command-line options, or from files specified by command-line
>> +options.
>=20
> Missing gitlink:

Ah, good point.

> Also I don't like the paragraph. It should probably mention that
> these programs actually implement the behaviour described, that
> they aren't hardcoded to the mentioned filenames and that
> all git porcelain just happens to call them with them.

That seems like an implementation detail, only relevant to users of
git-ls-files and git-read-tree.

>> +Patterns have the following format:
>> +
>> + - A blank line matches no files, so it can serve as a separator
>> +   for readability.
>> +
>> + - A line starting with #=20
>=20
> Is here missing something?

Oops.  Yes, this should have said:

- A line starting with # serves as a comment.

>> + - Otherwise, git treats the pattern as a shell glob suitable
>> +   for consumption by fnmatch(3) with the FNM_PATHNAME flag: any
>> +   slash in the pattern must match a slash in the pathname.  For
>> +   example, "Documentation/\*.html" matches
>> +   "Documentation/git.html" but not "ppc/ppc.html".  A leading
>> +   slash matches the beginning of the pathname; for example,
>> +   "/*.c" matches "cat-file.c" but not "mozilla-sha1/sha1.c".
>=20
> I realise this is copy&paste but shouldn't that read:
> "Documentation/\*.html" matches "Documentation/git.html"
> but not "Documentation/ppc/ppc.html"
> ?

I don't know.  Neither file seems to exist in current Git.

>> +Documentation
>> +-------------
>> +Documentation by Josh Triplett.
>=20
> No offence again, but given the amount of copy&paste, maybe the names f=
rom
> git-ls-files should also be added here.

Entirely correct; I don't know why I missed that, as I had intended to co=
py those
names. My apologies.

Expect an updated patch shortly, to fix the issues you pointed out.

- Josh Triplett


--------------enigA030AE7433653D1A078E4614
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGYL9lGJuZRtD+evsRAqlUAKCDINKJROI0Qy+lCwMDG8xdyouAGwCeIv9L
9cYOmC9pDQEsNmiT/dHq+S0=
=WSo7
-----END PGP SIGNATURE-----

--------------enigA030AE7433653D1A078E4614--
