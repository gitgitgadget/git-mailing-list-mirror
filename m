From: Michael Olson <mwolson@gnu.org>
Subject: Script to backdate tags
Date: Sat, 29 Sep 2007 23:16:32 -0400
Message-ID: <87bqbklu5r.fsf@hariken.mwolson.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 05:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibpp6-0005aL-4E
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 05:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbXI3DuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 23:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbXI3DuP
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 23:50:15 -0400
Received: from main.gmane.org ([80.91.229.2]:39757 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbXI3DuN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 23:50:13 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ibpog-0002UL-1f
	for git@vger.kernel.org; Sun, 30 Sep 2007 03:50:02 +0000
Received: from pool-72-69-4-31.sbndin.dsl-w.verizon.net ([72.69.4.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Sep 2007 03:50:02 +0000
Received: from mwolson by pool-72-69-4-31.sbndin.dsl-w.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 30 Sep 2007 03:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pool-72-69-4-31.sbndin.dsl-w.verizon.net
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAGFBMVEU1QytIVTlZY0dqc1N6
 hGGJl3qZpZCtuKXsjxzFAAACW0lEQVR42l2UXXrqIBCGk67Aoe29Ac4CTPDcGwZ73wLdQDOuQLP9
 8wHG9hT1Mc6bb/5jp7Xed92TVrqeCYfKRVc+XdfDbqbJ8TixG1UDu2a3xkf2H+z+A6Qn7Xk71AA8
 kdJmZg4xpcTshgr2JQSurAswhwDFYQN9r4yxx1BIQqBTBbvqahw9hxRSLOBdFVA89TTOvgSoMaLf
 ABTWOg5Z8lLRNyD7x4WSVHU1DZurThn2HI9Oa561JhTSDUWxq64YqRlmrcdhA73y3rmJY1okotDT
 NzDO2XNGZPnS7A4b6NQ8foQFN2eJmEBR7Du1Q/DRh7R4O50BrGmu0F8i49Iya+ScvtDNqkADB8zD
 pwU9wTu9c8msdNYOO0JvYYyREd9xBOh7zSNc2WMZUYzIDHOpU0Kxe5o9o0eccsr5mNLcwHhC8DoM
 SQkJ5wbUxAdlbDELEpDbclc8sT2gV2HJIrj/si7hDgzPpY4sqxTV+pWkgt7EGesDIFWUnGuK7pkn
 erZoieCVZPGcG3jCJimLwS7IVZY4R3mvoNfzoCfOF0mIG1nna+TadAxzgF5u0b3JTaxcmZtCF1dn
 WSOv63oNl4U3BQCLXOQKWZIHUBWcUci6iuTL7eMOelVAKfp+NkA0kOElN3BbV26AiGZsXEqfa0EQ
 NtATvTAKCeHh7AEEi4knM6S3HwB2eo1zeZQ5fDbgNkCpbEwh8HUTqYDqwUhIG2NQ/k2WH+CVB9LK
 aINy0EeAvgF6KRK0wIaPiX8CioRNpQF7X/8EOnoAPpUvrX8DED7t8B/Bv8ErfnpSfxv4B9rx7BDd
 lxXRAAAAAElFTkSuQmCC
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEUWGCQ0MzgzNUdFR1hQ
 UU9mXl9cYHJ3eoiCe3idlZO6sKzSzcj5OUjrAAACVElEQVR42oXSz0/TYBgH8Gfv2jjnZSWYDE7d
 iyJ4ZBCyeXmLIzK5DEPUjZszXeLVZA3hMpeZALtsCoSWizMBaXsydgn0/ed82nX9gRrfXZrns+e7
 Z89bqPzjwP9BopQW/gSFTo5wBxidnjswE0IhAVGd0kcxeB6VVVWNwaRhoai2tJamvQ/Bn0jV2qra
 LOLTaggbC6qqqc3kYB68aWt0EQsyfui0xYN3WNjwgCQBfyK98oriBN5WSDAwAn450/1MpQoVsJyE
 7LAxk8lviIRQiECh8NTZ7uZ3Tgo1QnNxSJVv5i8Lo2M2JFSWSQiy8NKtu+yTJB0CwkwEmYZ0zi/n
 lEMJAcKOipyRzg3u9pjQ79wBW9nj/PYm1RjRQi4CJt7UEPgVnIzo8oDMhpB2vj9D6IrXDl0aQrgr
 lhqvHCA4m9yhyyMIt8vA/trn/hnT0oDE4ILzKVRZBApcWF7VtTCqDmIM+tMOhzIQYoDDTtJ+UYDZ
 CHIPOLdC2I1eH/n+NOqnHCRNgKVsznX7LwANzEJwBwVhNQYKiLafdNtZ6iVeahCr/h/RB3NKEjJb
 xwjn+qDaEZMdW5s2vzaszhGDYjEODyF/alhm7RRIcd1qBbCZy64BwLFu7jIg61Zzvxd07GRfIFQt
 QwFIG80DPp6ddJjZEsKRYeYAnlzhpblBFJ+vI+jmNQD98YFz2931Yd7WNQZgGkMgy02bu5z3fNi2
 +dk3SHlJi+2yvwMfpG3c9xkI+gmQ/TW8GHsKey6/LecEowalj2+5lxRAHx9ffxFMuHf1uD65mN5v
 iFhnxfbKacIAAAAASUVORK5CYII=
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:E3oDAXUwSZc6+bDdMFogmXk+ER0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59519>

--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=

After importing one of my projects from Arch, I wanted to add tags that
indicated its major releases.  Unfortunately, these tags for older
releases would show up before the more recent releases in the gitweb
output.  I searched in vain for a way of backdating tags, and finally
decided to make a script to do this for me.  Here it is.

This may run into issues if someone uses the "\" character in their tag
names, but I didn't want to bother fixing this until it was affirmed
that this script would be considered generally useful.


--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG/xUT+1Ho2POo0xkRAmKyAKCRt8G0fRZpNjeAhNcACZCtL4MqLgCfXT6A
+axoY/Kr/CQmWU9Sool3yp8=
=xPPn
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=
Content-Type: text/x-sh
Content-Disposition: attachment; filename=git-backdate-tag

#!/bin/sh
#
# git-backdate-tag: Change the date of an existing tag, replacing the
# tag reference with the newly-generated tag object.
#
# Usage: git-backdate-tag TAG DATE

usage () {
    echo "Usage: git-backdate-tag TAG DATE"
}

if [ -n "$3" ]; then
    usage
    exit 1
elif [ -z "$2" ]; then
    usage
    exit 1
fi

# Set parameters
tag="$1"
date=$(date --date="$2" +%s)

if [ $? -ne 0 ]; then
    echo Could not parse date
    exit 1
fi

# Replace old date with new date
newtagobj=$(git cat-file tag "$tag" | \
    sed -r -e "s/^(tagger .+) ([^ \\n]+) ([^ \\n]+)\$/\1 $date \3/1" | \
    git mktag)

if [ $? -ne 0 ]; then
    echo Could not create replacement tag object
    exit 1
fi

# Set tag to new tag object
git update-ref refs/tags/"$tag" $newtagobj

--=-=-=


-- 
       Michael Olson -- FSF Associate Member #652     |
 http://mwolson.org/ -- Jabber: mwolson_at_hcoop.net  |  /` |\ | | |
            Sysadmin -- Hobbies: Lisp, GP2X, HCoop    | |_] | \| |_|
Projects: Emacs, Muse, ERC, EMMS, ErBot, DVC, Planner |

--=-=-=--
