From: Matthew Cengia <mattcen@gmail.com>
Subject: Re: Bizarre git merge behaviour
Date: Wed, 20 Nov 2013 23:03:31 +1100
Message-ID: <20131120120326.GD26413@debian.cengia.id.au>
References: <l6hbgg$oej$1@ger.gmane.org>
 <528C62BE.7060803@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 20 13:04:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj6Vr-0002m4-T3
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 13:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab3KTMDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 07:03:53 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:51370 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab3KTMDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 07:03:52 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so1886818pdj.4
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 04:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Pfvz5E0AXxHi3VdXIb6XU9KFhm8mHCRytLRNic/xisE=;
        b=anU+bLXKhCtALZCxvW3lqEylgQsnXwxgT8PG8rpUGCqs/v8o3qpkT4sF2IvF69r29Y
         IYeICmMK88yFJbopeyiKu73u4EzhIFeUTq9roe1O2LBH6xX9j4l+n3gMMG+a4CwAnsVM
         3UdgFrQgSPNjWKLcc6WXeAe1CGyNNa8eoNjULTvAeTFbmqX0LLbeEpQ33Wc0TFu0pkA3
         SPIlMSiTAEqd3BGIPch0++L6FmIlWSAEGMsEJWTwqdwlyJOOD3XWhcvCRKf+a7RmKWpe
         5j5EBZJIW4c5gwV7CvG6+M7xWDtWVIQq5YKQiqk5FRQZWfDyCfbNXQdOCr/G81bROTsf
         bLJA==
X-Received: by 10.66.66.161 with SMTP id g1mr206529pat.175.1384949027650;
        Wed, 20 Nov 2013 04:03:47 -0800 (PST)
Received: from localhost (c110-22-201-130.sunsh4.vic.optusnet.com.au. [110.22.201.130])
        by mx.google.com with ESMTPSA id ae5sm37066973pac.18.2013.11.20.04.03.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Nov 2013 04:03:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <528C62BE.7060803@viscovery.net>
X-PGP-Fingerprint: DB91 CFEF 322D C608 385F  563C 2F88 1AC6 4A16 1033
X-PGP-Key: http://cengia.id.au:2080/~mattcen/pubkey.asc
X-Homepage: http://cengia.id.au:2080/~mattcen
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238073>


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-11-20 08:20, Johannes Sixt wrote:
[...]
> Not really. It's impossible to tell what's wrong if you

Hi Hannes,

Thanks for your response, and sorry for providing insufficient
information; this is a company Git repo (it's also about 200MB), so I've
got be careful what I post, but I can certainly give more than I've
shown already.

>=20
> - show only ..topic
> - but not topic..

I won't show the same (git log) output as I did previously, because
there are lots of commits and is a bit difficult to read (but can do so
as an attachment if you genuinely think it may be useful), but here's a
diff from wtf to merge-base:

mattcen@sonar:prisonpc(wtf)$ git --no-pager diff --numstat --oneline \
    "$(git merge-base wtf origin/22869-new-kernel)" wtf
1       1       .gitignore
1       1       bios-monitoring/bios-alert
4       4       bios-monitoring/check_bios.sh
1       7       bios-monitoring/ppc-bios.conf
3       0       client/scm/20-security.scm
14      0       client/scm/30-apps.scm
5       10      client/scm/30-branding.scm
2       7       client/scm/30-password-reset.scm
7       9       client/scm/50-kernel-prisoner.scm
7       9       client/scm/50-kernel-staff.scm
0       10      client/scm/50-prisoner.scm
4       1       client/transmute
2       1       client/transmute.scm.in
0       1       config-files-internet.txt
66      1       debian/NEWS
24      0       debian/changelog
6       3       debian/control
0       13      debian/postinst-cfg.sh
0       6       debian/prisonpc-core.config
8       5       debian/prisonpc-core.cron.d
12      6       debian/prisonpc-core.cron.daily
2       1       debian/prisonpc-core.install
35      94      debian/prisonpc-core.postinst
25      0       debian/prisonpc-core.ppcadm-yuk.init
0       4       debian/prisonpc-core.ppcadm.upstart
14      0       debian/prisonpc-core.preinst
27      0       debian/prisonpc-core.squid-yuk.init
0       11      debian/prisonpc-core.templates
16      2       debian/prisonpc-dev.cron.weekly
6       6       debian/prisonpc-dev.install
7       0       debian/prisonpc-dev.postinst
1       0       debian/prisonpc-internet.cron.daily
6       5       debian/prisonpc-internet.install
4       19      debian/prisonpc-internet.postinst
7       1       debian/rules
11      10      disc/disc_access
7       0       doc/Test_plan.txt
11      0       doc/Vectors.txt
-       -       doc/adminguide/images/streaming_media-screen.jpg
-       -       doc/adminguide/images/streaming_media-screen.png
-       -       doc/adminguide/images/web_filtering.png
8       17      doc/adminguide/streaming_media.rst
8       3       doc/adminguide/system-status.rst
13      16      doc/adminguide/web_filtering.rst
127     0       doc/current-mail-status.txt
55      0       doc/prisonpc-mail-plan.dot
90      0       doc/prisonpc-mail.dot
2       0       doc/user_acceptance_tests/.gitignore
22      0       doc/user_acceptance_tests/README
581     0       doc/user_acceptance_tests/default.css
1011    0       doc/user_acceptance_tests/user_acceptance_tests.rst
2       2       dovecot/dovecot-staff.conf
0       579     dovecot/email_quarantine
8       5       eric/apps/complain.py
5       3       eric/apps/links.py
7       3       eric/apps/media.py
5       3       eric/apps/whitelist.py
4       0       eric/eric
1       0       eric/eric_cfg.py
48      0       generate-mail-stats
12      2       post-install.sh
10      0       postfix/alias-list
2       0       postfix/by-week.procmailrc
0       11      postfix/flush-queued-mail
2       0       postfix/invariant.procmailrc
49      67      postfix/main.cf.in
3       36      postfix/master-basic.cf.in
51      144     postfix/master-filter.cf.in
145     156     postfix/maxwell
0       15      postfix/maxwell.cfg.in
31      0       postfix/maybe
76      0       postfix/plainify
0       0       postfix/plainify.d/cur/00-nothing
6       0       postfix/plainify.d/cur/01-nonmime
12      0       postfix/plainify.d/cur/02-th
8       0       postfix/plainify.d/cur/02-tp
35761   0       postfix/plainify.d/cur/f0-many-types
832     0       postfix/plainify.d/cur/f0-rfc822
244     0       postfix/plainify.d/cur/f0-th_tbird_cascade
0       167     postfix/smtp_archiver
0       240     postfix/strip_quarantine_markers
119     248     postfix/whitelist
85      37      ppcadm/modules/disc_access.py
80      0       ppcadm/modules/emailstats.py
8       7       ppcadm/modules/mailfilter.py
130     49      ppcadm/modules/media.py
58      74      ppcadm/modules/quarantine.py
87      37      ppcadm/modules/wwwfilter.py
3       0       ppcadm/resources/admin.css
31      0       ppcadm/templates/disc_access.tpl
5       0       ppcadm/templates/disc_summary.tpl
7       6       ppcadm/templates/home.tpl
2       2       ppcadm/templates/mailfilter_menu.tpl
1       2       ppcadm/templates/quarantine_list.tpl
33      17      ppcadm/templates/quarantine_mail.tpl
67      0       ppcadm/templates/streaming_media.tpl
3       3       ppcadm/templates/user.tpl
100     0       ppcadm/templates/wwwfilter.tpl
36      27      pre-install.sh
17      21      squid/check_greylist
2       1       squid/make_url_regex
8       34      squid/remove_user.sh
8       24      squid/update_user.sh
7       16      squid/validate_url_comment
2       1       streaming-media/autodvdencode
2       1       streaming-media/m3u-slurp
4       4       streaming-media/media-stream
2       1       streaming-media/vobcopy_wrapper
2       1       switch/switch-cmd
23      1       tca/parts.d/pxelinux-cfg
14      6       tca/rebuild_prisoner_realm_access
7       4       tca/rebuild_prisoner_realm_service_access
48      147     tca/tca.pm
18      10      tca/tca_realm_access
6       5       tca/tca_realm_service_access
0       9       trimserver/trimserver.cfg.in
14      43      trimserver/trimserver.pm
0       42      webmin/rcs_ci
6       0       webmin/reset_user_desktop_config
10      49      webmin/sort_ci
1       4       webmin/sort_ci.8
0       12      webmin/sort_ci_correct
11      14      webmin/whitelist_update

> - and you keep secret which of the changes is unexpected.

The only changes I expect are these:

mattcen@sonar:prisonpc(wtf)$ git --no-pager diff --numstat --oneline \
    "$(git merge-base wtf origin/22869-new-kernel)" origin/22869-new-kernel
37      0       client/kernel/README
2797    0       client/kernel/config-3.5.7.20-1
0       3525    client/kernel/config-3.5.7.21-1
-       -       client/kernel/linux-firmware-image_3.5.7.21-1_i386.deb
-       -       client/kernel/linux-image-3.5.7.20_3.5.7.20-1_i386.deb
-       -       client/kernel/linux-image-3.5.7.21_3.5.7.21-1_i386.deb
1       0       client/scm/20-security.scm
6       7       client/scm/50-kernel-prisoner.scm
1       0       client/scm/50-staff.scm
22      0       doc/user_acceptance_tests/README
581     0       doc/user_acceptance_tests/default.css
1548    0       doc/user_acceptance_tests/user_acceptance_tests.html
4268    0       doc/user_acceptance_tests/user_acceptance_tests.pdf
940     0       doc/user_acceptance_tests/user_acceptance_tests.rst

> Perhaps you did the following:
>=20
> - On one branch, you made a change A and then another change B that rever=
ts A.
> - On the other branch, you also made the same changes as A, but there is
> no equivalent of B.
>=20
> In this case, it is expected that the changes made by B (i.e. the reversal
> of change A) are *NOT* in the merge, i.e., the changes of A survive. It
> looks as if the merge reverted change B.

I have found no evidence that this happened, but am not confident enough
to rule it out.

>=20
> If that is not the case, it could be helpful that you pick one of the
> files that contains an unexpected change and post the output of
>=20
> git log --left-right --oneline wtf...origin/22869-new-kernel \
>     file/with/changes | cut -c1-70

Sure. I don't expect the merge to cause any changes to quarantine.py:

mattcen@sonar:prisonpc(wtf)$ git log --left-right --oneline \
    wtf...origin/22869-new-kernel ppcadm/modules/quarantine.py | cut -c1-70
< 5b5f552 Fixed msg vs msg.as_string because smtp.sendmail is picky
< 03618f2 Use Return-Path, not X-Original-Envelope-From.
< dc1169e Bug squashing.
< 8e20216 Changed quarantine module to run maybe and send directly to
< d79ad42 Change final port, name the magic number.
< e44d1b3 Merge remote-tracking branch 'origin/staging' into 22912-ppc
< a03db6d Modified quarantine UI to handle the new reports format

Further, there are other files that don't change at all on either side
of the symetric diff:

mattcen@sonar:prisonpc(wtf)$ git log -M -C  --left-right --oneline \
    wtf...origin/22869-new-kernel generate-mail-stats | cut -c1-70
<no output>

I'm truly stumped. It's also worth noting that I've gone through and
manually resolved this merge one file at a time, and I'm about 90% sure
I ended up with the correct result, but it'd be nice to have had the
merge do the right thing in the first place, and I obviously want to
avoid having to do this again in a few months' time.

--=20
Regards,
Matthew Cengia

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQJ8BAEBCgBmBQJSjKUOXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQwMjI1MjY2QUFCMThBOUQwNEMxOUQ0QjY3
QTdFMzdGMzNCMjI3MkU4AAoJEHp+N/M7InLoR8kQAKmon3DZ0aV7ZPCeWy3wSrKN
sBiVE2eOabZXCXrPhhPDNJFrmkc0K+t5i3dO0IolAsprCM4ubr7DPFYTMvIQ7WzV
2Yt1JsRRDACDlb+MAzrncqRCLS7obH+L1wBZTQDITa95XAnir//tF8z/WyVI6UIw
SKuQdQBnJvQ9qgTvshBbyW30a3m8Tb2T5SmZFthWa8NcweWf/GFykahi0MWbGyZP
scWcngpG+FXsDoVTO0YatzkSkyp7cl7LDRVPp/atYkoWpiENqVGrcshB+RVIa4kn
Aw8187ACgUJDIgbBMMQlE5A3K+PN1Qn8ZM7fYpvfKk6tDPRTP64mIUp8rrdC3wPy
eFRKOZMyalgRAh5i+RjYayBaaE0o32RvRZ3gZmHeEKmjAj+68Wf0EsGcL5mIZiuW
m3JOzZ/NatAq6RGVkFGgt6D8xhSfWUrmfL3gQ3VKqb5JlTIIS+JiSqECOsfhxy1I
oaPlXX7y6Kp1plDGTBlAEVJoFiCdbbazCVOkAXZAkM4NOTDi8DAzz+cyKJs6JmLZ
Ao9X1JRTQ6gtwZA5QgsXEpMiBV2uEHvlnjKqFN3IxbRgYCLX4k9UBEBYOL3tKbX0
BCvDimZsV1YWELkzQGMBZVfNU/bAisvEAra7V4i7zqa4bZ1Xld3YK/DwEkU48iPJ
MbIqoeAhMSbB6oHli07K
=O1HF
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
