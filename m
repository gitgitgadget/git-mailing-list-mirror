From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: Unable to Revert Commit
Date: Fri, 28 Nov 2014 08:37:10 -0500
Message-ID: <20141128133709.GA28178@test-chamber-1.castopulence.org>
References: <547752ED.8010208@macey.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Cc: git@vger.kernel.org
To: Rex Macey <rex@macey.us>
X-From: git-owner@vger.kernel.org Fri Nov 28 14:37:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuLjc-0005kf-3S
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 14:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbaK1NhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2014 08:37:14 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:47495 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbaK1NhM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2014 08:37:12 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so6067043ier.32
        for <git@vger.kernel.org>; Fri, 28 Nov 2014 05:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dkDoVG7LM3Wq6ol8pYbEDyZMpApyJxtullZcbEExznk=;
        b=wpJjp0Zd76mfThpnNwkzBwrZWjZYKiQfiNw8FP/RYoPpIKEB05E3ayk5zZALgNwRoq
         EGY/4KqVWCM5f/Qi+6+LzZO19tQBaNOmTOYB400T0yuFwRoxW7p39oC9Lk/EJmGWABxB
         M5TxZ12LdcMNvHE4FhdBjUujSgwXRZwbJgO4Z3x6fX5rGuBa4BL+Kp2zO5geBVAFhWhT
         SoGWzyO+7zvZnMK4jJ6XrK6atCjc4BARRm97Ll5AZfbH35tRVPal/FXzQPh+8gq4zw6O
         VoHdAGGTHK9OXTqn08eNtb2zG6a1Y46CXHcp3Rq9hyB3XzRXeMiRrsd0F41FolySYk82
         yLrw==
X-Received: by 10.42.167.1 with SMTP id q1mr42042126icy.48.1417181831549;
        Fri, 28 Nov 2014 05:37:11 -0800 (PST)
Received: from localhost (b03s17le.corenetworks.net. [64.85.162.126])
        by mx.google.com with ESMTPSA id m63sm4988186ioe.40.2014.11.28.05.37.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 28 Nov 2014 05:37:10 -0800 (PST)
Mail-Followup-To: Rex Macey <rex@macey.us>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <547752ED.8010208@macey.us>
X-PGP-Key: https://castopulence.org/bamccaig/castopulence.asc
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260363>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rex:

On Thu, Nov 27, 2014 at 11:35:57AM -0500, Rex Macey wrote:
> "Unable to Revert Commit ... Resolve the conflicts in your working
> directory and commit them before trying the revert again".  Please
> help me understand how to resolve the conflicts.  Here's what
> happened (as best as I remember).
> Created a windows folder "github_learn" (not under my
> \documents\github  folder) ;
> Created a file file1.r.
> Dragged folder into Github for Windows.  Committed; I could see the
> file in my directory, Github for Windows, and on the server
> (github.com);
> I modified the first file.  Checked that there were different
> versions and then committed it.;
> I created a second file, file2.r Committed it.  All good.;
> Then I tested whether I could retrieve the first version of file1.r
> (before modification).  In the History area of Github for Windows, I
> can see this version.  I click on that, and then I click on "Revert"
> which produces the error.
>=20
> I am very new to Git and have read some of the documentation and
> this exercise is my attempt to test myself.  So far my grade is not
> good.  I appreciate any guidance including links to instructions.

"GitHub" and "GitHub for Windows" are not "Git". I don't think
you will find official support for those proprietary products on
this mailing list (I may be wrong). It looks like you can request
support for those products from the "contact" page on the GitHub
Web site: https://github.com/contact.

My personal recommendation would be to get rid of those anyway
and learn to use the real Git. It's not very difficult, and it is
likely to do things better in the long run. As a general rule,
GUI programs are limited, clumsy, and try too hard to hide the
details of what they are doing from you that you need to
understand to effectively use the software. Do not fear the
command line. It is just like writing code. If you are interested
in Git then you are probably interested in code. Think of the
command line interface as a more direct interface to tell the
computer what you want with high-level code instead of expensive
graphics and event loops and spaghetti code.

I can tell you that git-revert(1) basically means "create new
commits that undo the changes introduced by the specified
commits." That is likely accomplished by applying a reversed
patch, and that is likely to fail if the tree (files) has changed
much.

Conflicts are OK! They are normal when you work with version
control software. You can manually resolve the conflicts and
continue with the revert. Google can help you to understand how
to resolve conflicts. You can do so manually (my preference, and
a good thing to learn to help you understand why conflicts
occurred in the first place) or you can use software tools to
help. I recommend you create backups of your repository (.git)
and working tree (...folder where your files are) using something
like 7-zip (but a simple copy suffices) when you're new to Git so
that if you make a wrong move it's easier to go back and try
again with confidence.

That said, if you just want to *see* the state of the file at a
particular point in history you can use git-cat-file(1). Another
way would be (with a clean tree) git-checkout(1), though that
will make changes to your tree (and if you aren't careful can
destroy changes that you have already made) that you may not
want. The file can be restored to the "latest" committed version
using git-checkout(1) again (or git-reset(1) with the --hard
option). Both of these options need to be used with care. In this
case, git-reset(1) could also be used to reset the state of your
working tree to a clean state if you do decide that git-revert(1)
isn't what you wanted.

I recommend that you just find a plain Git tutorial and learn to
the use the real thing. It's really not that hard. And "Git for
Windows" works well without the need for GitHub's own
proprietary, platform-specific solution. It even includes a Git
GUI if you're still reluctant to use the command line (but my
above wisdom regarding GUIs probably still applies).

If you use the real Git then not only can we help you, but you
can get real-time advice and guidance from the #git channel on
irc.freenode.net.

Regards,


--=20
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bamccaig.com/>
perl -E '$_=3Dq{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUeHqFAAoJEN2n1gIi5ZPyZtIP/0/k76e2xOMFtxO2LDOHGKXt
NtYGnCBepJiMwTAPWNVpWZevGfunvf+8NeV2lEVH1P1Rb7RcFs9gQchyAmgdy+z+
PQ413ahydJdU6y2uArODzn2HKGdft+Tq2cY3NZaKpm/8dXCBT/FGoZhkekMp5gE5
iqt011Xv8E8ym0IWiF2/rlfVimqk/8KWwUG5LQH5WMRh/FkerjFHL28Rz/EbVWMK
nYSo2+lx184gEtKM6FVO8l89Xia73eRyzR2GJUdtl4vTKFnNBN3qImbh0vRmflNt
fc39KR8J69NK3llOS7wWv/PfG0EkOTfOCafpqrHIsx0UVBq4FAUzJH4b+d5u0T3Y
mhwAjEo6MLId4rflfj8NxuXphZhfRZzi/hculiiiwPoEgT0P5+VuKuMYQKeTLWMq
ZdEuDSIfiojJbcY6odRplwglsbQH4WA4cI24Wl0uJoDmlgmHEHK/+LtgHlGTQMju
N/w0AlAOGR8Ijyf7hc76bt3WqeUQnUq0JCe70F8kbffMLDm2qUNueNoHFDMlY/2Y
VCW4j7X3CHOhA3bckqz99DSpkT27D7Tll1cpO3MJ6G/P7QvB5mO6EhbIVK4PDTkO
bkFuLkMt8xZt2b8gRE5zjbIhqNbmG3huEn9X0e4o5/YORP0xscyB/UWhkBHK7XTk
dbljKgyH7hsPOup6EUf2
=8lrc
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
