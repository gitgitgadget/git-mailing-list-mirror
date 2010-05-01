From: Adam Monsen <haircut@gmail.com>
Subject: migrating Mifos from svn to git
Date: Sat, 01 May 2010 15:08:45 -0700
Message-ID: <1272751725.21622.57.camel@scraps>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-PMqj8/A2yfdtbWHq1SCw"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 00:08:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Krl-000334-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 00:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755463Ab0EAWIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 18:08:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59878 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766Ab0EAWIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 18:08:47 -0400
Received: by pwj9 with SMTP id 9so717880pwj.19
        for <git@vger.kernel.org>; Sat, 01 May 2010 15:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer;
        bh=7TGsWNhKNPOZUaslb3h/4ZlcvlrLcymxU/POePt58wE=;
        b=M2FdJ61zSecOl3LjqFvwLclcbaHGOcXHZUzUOjEI3Qa4XeOeEw8oVVdVJFFIu2W8Kp
         Tzd7Q7zfXLjdXuMOy9rzvrPhGrd1YJ1Z4tjofQ78Md4z/rL0dIyI2gKMeE44EaRw8Y5l
         ZxAi5MY/ZwDrE+0KSBngtH6opdjWQzhINi01E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer;
        b=LQjhifqfTrxUQo49IYeS8YvTCUI0+VGwAa4M8Y1FaM29SXomNqw2Wp964ir0u0eZZ/
         AaOhZ1CPacy5PmjSnO/LKnnd56TnBu25NnFZR3TxFQEmHyyjjohY4ohf6OATpCCxC0q9
         X00Xs/ydKylrbB5cxeH47J2z9lyrR9bjOLCxY=
Received: by 10.142.248.21 with SMTP id v21mr7973019wfh.347.1272751727138;
        Sat, 01 May 2010 15:08:47 -0700 (PDT)
Received: from [192.168.0.8] (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id 22sm3172331pzk.5.2010.05.01.15.08.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 15:08:46 -0700 (PDT)
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146121>


--=-PMqj8/A2yfdtbWHq1SCw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(If you'd like to skip the fluff and get to the point, skip down to the
numbered questions.)

I'm a developer on a project called "Mifos". Mifos is FLOSS used by
banks who manage loans and savings accounts for the poor.

We're currently using an svn repo hosted at sf.net, and are experiencing
pain with Subversion that we feel a great dVCS could alleviate. For
instance, our devs (especially those far from sf.net's servers) hate
going to the server just to examine logs, branch, and commit. I'm
getting us on a dVCS.

I've spent some time with svk and hg, and neither really felt right to
me.

git's features are very compelling, and the speed appears unmatched. I
like that "git svn" actually reads svn 1.5+ mergeinfo, which we've been
relying on heavily in Mifos. I am having some difficulties learning the
details of examining history, merging, and rebasing, but I'll figure
that stuff out eventually.

The strongest indicator I've had to try git was that everyone I asked
for help with dVCS said "what's svk?" and "don't use hg, use git". Git
seems to have a huge, successful community.

Questions:

1. Is anyone willing to help me migrate Mifos from svn to git? If so,
please contact me on or off list, or in #mifos or #git on FreeNode IRC
(my nickname is "meonkeys"). It's for a good cause: our vision is to end
world poverty!

2. I'm trying out git-svn (a) to get used to git and (b) to actually try
migrating our svn repo to a git repo. Is there a better way? (cbreak in
#git seemed to think so)

3. When using git-svn, can I first "init"/"git svn fetch" from a local
mirror ( file:///opt/mifos_mirror ), then switch to our real repository
( https://mifos.svn.sourceforge.net/svnroot/mifos ) once I'm mostly up
to date?

4. When using git-svn, "git svn init" works against my local mirror, but
"git svn fetch" dies on svn revision 16072
( http://article.gmane.org/gmane.comp.finance.mifos.scm/6053 ). Can I
maybe just skip that changeset ....nevermind, "git svn fetch
--ignore-paths=3Dbranches/removeFinancialActionCache" seemed to do the
trick. Hrm, now I'm stuck at some other commit. Anyway, thanks for
enduring this ramble. Here's the latest problem I'm running into, in
case anyone has ideas on what Fu I might use to get out of this hole:


$ git config svn-remote.svn.url
file:///opt/mifos_mirror

$ git svn fetch --ignore-paths=3Dbranches/sungard
Found merge parent (svn:mergeinfo prop):
6e749fea53b200b609ac12239b6d824a78090f7d
Found merge parent (svn:mergeinfo prop):
a2fdb47825503de62db74cd349e3feec4c899a88
Found merge parent (svn:mergeinfo prop):
827c31be708522130258cdfd2339cd3d7c94c8df
W:svn cherry-pick ignored (/branches/sungard:15786-16227,16237) -
missing 3 commit(s) (eg 887a7b93bdec64393230bda45e20e41affde7a4e)
fatal: ambiguous argument
'6f43cde2a0e277bb7730dfaff3c5c11b67a54009^..ae3b7383b4dc6a15172346623dee3e9=
c887c8afc': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
rev-list
6f43cde2a0e277bb7730dfaff3c5c11b67a54009^..ae3b7383b4dc6a15172346623dee3e9c=
887c8afc: command returned error: 128


--=-PMqj8/A2yfdtbWHq1SCw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvcpmgACgkQI/2Fnd3kXZKmtgCfTpO3mF2lzPl6B7xWNC4yhj70
3swAnRkwSs4r+Tq/mqSBhHSqaD33cAdp
=skcZ
-----END PGP SIGNATURE-----

--=-PMqj8/A2yfdtbWHq1SCw--
