From: William Giokas <1007380@gmail.com>
Subject: Conforming to pep8
Date: Thu, 8 May 2014 20:54:29 -0500
Message-ID: <20140509015429.GA550@wst420>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:58:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wia53-0007CK-Ai
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbaEIB63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:58:29 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:44344 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbaEIB62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:58:28 -0400
Received: by mail-ie0-f181.google.com with SMTP id y20so3510803ier.12
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=eBx1XgAcsg7tbCh38IctEun6rA4fAZbr3DkwBUofgXg=;
        b=WfqGuyjh+cojKG2YJYrcxbRqO3hCtMkomsMoLjN9Fg7yzia45xi78SW+816f/RT62T
         8N7+SZt0aenzsl6V6+G+6jOXPxvdhAANmGohrRsBih9MVdW4appIL028oGJSQXZC8Eni
         ff1WfkZG4xuRELfeWLrUI7cU+UC6Fs8VHUZ+PrALuevU19hOzuz1wwDUVveZvIrMjrEd
         ZYjzKh8/A+Si9SZq4Q13WQd1qN5DvShhSvO1YabqUEpcVKpb8qtI0zgQCD1Qyp/0kniJ
         dOYk5PZCkJm5/sVXwsiEW5cNxlmV2gdQ7+BB+EDPmht2WIKEWkl06ge8h/ysW5LWA4IF
         DCjA==
X-Received: by 10.50.128.83 with SMTP id nm19mr2894219igb.28.1399600708126;
        Thu, 08 May 2014 18:58:28 -0700 (PDT)
Received: from localhost (of2-nat1.sat6.rackspace.com. [50.56.228.64])
        by mx.google.com with ESMTPSA id qh3sm3129050igb.17.2014.05.08.18.58.26
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:58:27 -0700 (PDT)
X-Google-Original-From: William Giokas <wgiokas@wst420>
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248497>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

So I have been looking into the python code in the git tree recently
(contrib and core tree) and noticed that almost none of the files fully
conform to pep8. Now I'm not just saying this because I like the code to
be clean, readable and easily parsed by humans, but also because this is
laid out in the coding style document that is distributed with the git
source::

    For Python scripts:

     - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).

It's even the first thing that you see when you go looking for 'python'
in the coding style document. I just ran every file in the tree that
either ended in '.py' or had a python #!, and was greeted with a whole
bunch of output::

    ./git-p4.py
    ./contrib/svn-fe/svnrdump_sim.py
    ./contrib/remote-helpers/git-remote-bzr
    ./contrib/hooks/multimail/post-receive
    ./contrib/hooks/multimail/migrate-mailhook-config
    ./contrib/hooks/multimail/git_multimail.py
    ./contrib/hooks/multimail/README
    ./contrib/hg-to-git/hg-to-git.py
    ./contrib/gitview/gitview
    ./contrib/fast-import/import-zips.py
    20      E101 indentation contains mixed spaces and tabs
    90      E111 indentation is not a multiple of four
    9       E112 expected an indented block
    47      E113 unexpected indentation
    1       E121 continuation line under-indented for hanging indent
    3       E122 continuation line missing indentation or outdented
    3       E124 closing bracket does not match visual indentation
    12      E125 continuation line with same indent as next logical line
    9       E126 continuation line over-indented for hanging indent
    4       E127 continuation line over-indented for visual indent
    63      E128 continuation line under-indented for visual indent
    4       E129 visually indented line with same indent as next logical li=
ne
    3       E131 continuation line unaligned for hanging indent
    37      E201 whitespace after '['
    30      E202 whitespace before ']'
    30      E203 whitespace before ':'
    37      E211 whitespace before '('
    10      E221 multiple spaces before operator
    14      E222 multiple spaces after operator
    8       E223 tab before operator
    1       E224 tab after operator
    35      E225 missing whitespace around operator
    6       E228 missing whitespace around modulo operator
    23      E231 missing whitespace after ','
    10      E251 unexpected spaces around keyword / parameter equals
    1       E261 at least two spaces before inline comment
    1       E262 inline comment should start with '# '
    37      E265 block comment should start with '# '
    1       E301 expected 1 blank line, found 0
    117     E302 expected 2 blank lines, found 1
    19      E303 too many blank lines (2)
    4       E401 multiple imports on one line
    220     E501 line too long (83 > 79 characters)
    5       E502 the backslash is redundant between brackets
    33      E701 multiple statements on one line (colon)
    11      E702 multiple statements on one line (semicolon)
    34      E703 statement ends with a semicolon
    9       E711 comparison to None should be 'if cond is None:'
    2       E713 test for membership should be 'not in'
    1022    W191 indentation contains tabs
    40      W601 .has_key() is deprecated, use 'in'
    1       W602 deprecated form of raising exception
    1       W603 '<>' is deprecated, use '!=3D'
    1       W604 backticks are deprecated, use 'repr()'

Which is a whole bunch of errors and warnings thrown by pep8. Is pep8
just getting put by the wayside? I would much rather have these scripts
conform to that and have an actual coding style rather than just be a
hodge-podge of different styles.

Thanks,
--=20
William Giokas | KaiSforza | http://kaictl.net/
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbDVVAAoJEGkCBthzzQnPsk8QAIxJSfjojuj4zl/42U72eLGC
0+uDeLj3viBpg/i5w6KSKAKQcomJTYoqaKPk+ZrNYJ3uAuPvEtCBIsajjzSi+qgR
fjlOeePatu/mj0HhRtTKHnb/XLGN4NrOc0D9tt4hi8VTiSN2dIh9Vlbek6NOl4fz
v9F9O1FWgIzC86ZnY2OZVftnSoKu85ilj/tlWgUzYDZos5+saKgIXZwdqD9K3UPu
cNWZ6h7ENmB1+8wfeZMWGlbuUWCklArboawJI4cb/Yerk0WaQtFZytsAjyjPev0z
ic8aweVMtKJmoMl+8cz2ayaOFlHs5stIlolIK22m5uRyYj5VUamIrG/oA4SA2OL9
LZ1Vbz+z4K0CR3f4yoT3bsnzQ3uGntYLruOXkarjK5UWioQ/fxKpsqib+vy+wtJE
k5FKz9srmSuf/IUKUgqmjnX0WoUAEJaKAUbUuRXOs88b3FHwyzlsAaEg4XIPppSU
1wPNpMS3r3hICGpk7OVHe65Jp9FkeBEXz3S7EIglWaGqYSa4sCNB1RPIZPQtY6WJ
ME2IsSz54qnAybxay1G3s6MmO44WDyLaQoG46ph0VF9izqndZUum1y3BMX+IzWib
n0Jb7S8qUxYLLrS8gJd3GzQ2kPcUwy/81eyF2mLyT49hHV0cGc6edVcPN1/q/IT3
6Guq7CjTNd/md86tK9vp
=2rJt
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
