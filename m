From: Caleb Cushing <xenoterracide@gmail.com>
Subject: mergetool feature request - select remote or local
Date: Wed, 14 May 2008 07:21:00 -0400
Message-ID: <200805140721.13719.xenoterracide@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1338329.NDRkf4IWFi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 13:24:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwF61-0002OG-Fv
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 13:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbYENLXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 07:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756111AbYENLXm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 07:23:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:30619 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639AbYENLXm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 07:23:42 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1835492ywe.1
        for <git@vger.kernel.org>; Wed, 14 May 2008 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        bh=v6zhh451GREhq6NwPOexanOZEaqmcthedsZbnGoPfrU=;
        b=o+ounVh/pa+gWqpG3K4CseaALNQvsUb179AR1A6+BjdtwpooyLpd0eZw9i+F/wnjoItncNejHawXtGFl3XrqgOs0EkuoPT8TtYkAOjfnj8rhIc0UVYMQsViL1ADtAeDKVl7WuIRVpg0TsjO2wmFPwLL+mVWEZUDeY1aLyiOHPMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=UlPRzDZrA9NRMoxctLBJFwrfIZqFXodEqikD+r+WfFwvIe9RkoxEBtTpfATER68YDYDUL+qD7RKllgQuQVcBZAf6+fXCxsAL8Dhoaceo/Z+4+sZGaHL72rmOQaGS3GnzdLIlMye7nXbUQJ1YP+q6m658v2Wr35VeSq7KOo+jbAE=
Received: by 10.150.12.3 with SMTP id 3mr897034ybl.14.1210764218102;
        Wed, 14 May 2008 04:23:38 -0700 (PDT)
Received: from ?192.168.0.101? ( [75.128.154.7])
        by mx.google.com with ESMTPS id 33sm944768yxr.3.2008.05.14.04.23.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 14 May 2008 04:23:37 -0700 (PDT)
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82097>

--nextPart1338329.NDRkf4IWFi
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

sometimes when merge-ing fast forward doesn't work. but you know what the=20
resolution you want is.

example (current behavior)
Normal merge conflict for 'css/main.css':
  {local}: modified
  {remote}: modified
Hit return to start merge resolution tool (vimdiff):

but I don't want to. I know the remote updates are right. I could do a git=
=20
checkout remotebranch filename but when you have 20 files that need updatin=
g=20
this is annoying

my suggestion is this
Normal merge conflict for 'css/main.css':
  {local}: modified
  {remote}: modified
Use (l)local or (r)remote or (m)anual?=20

also in the event of having 20 files with this issue it would be nice to ha=
ve=20
an option after first starting mergetool for remote all or local all.

(note: I am not subscribed to the list)
=2D-=20
Caleb Cushing

my blog http://xenoterracide.blogspot.com

--nextPart1338329.NDRkf4IWFi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkgqyykACgkQQ201sGJR45I3bQCgiNRKSR8rtd9D+0craCyw+Fk0
gQUAn2gXmbKG2TDkR9jP3VRrS95mHcaW
=iMlc
-----END PGP SIGNATURE-----

--nextPart1338329.NDRkf4IWFi--
