From: "Brown, Len" <len.brown@intel.com>
Subject: RE: new file leaked onto release branch
Date: Wed, 14 Dec 2005 14:20:04 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30056B83F2@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C600E3.642DDC75"
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 20:23:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmcBG-000457-ME
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 20:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVLNTUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 14:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVLNTUp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 14:20:45 -0500
Received: from fmr14.intel.com ([192.55.52.68]:58508 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S964903AbVLNTUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 14:20:42 -0500
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id jBEJKALN026343;
	Wed, 14 Dec 2005 19:20:10 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id jBEJJpBl023605;
	Wed, 14 Dec 2005 19:20:10 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005121411200931828
 ; Wed, 14 Dec 2005 11:20:10 -0800
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 11:20:09 -0800
Received: from hdsmsx401.amr.corp.intel.com ([10.127.2.60]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 14 Dec 2005 11:20:09 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: new file leaked onto release branch
Thread-Index: AcYAzwJkk4YopRfiS0Wk3VKoYuRsmgADZQaw
To: "Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 14 Dec 2005 19:20:09.0098 (UTC) FILETIME=[65BB2EA0:01C600E3]
X-Scanned-By: MIMEDefang 2.52 on 10.253.24.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13638>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C600E3.642DDC75
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20
>So Len, since you seem to use "git merge" in your scripts, I=20
>suspect you have an old version of git lying around. Can you try doing =
just

Should I be using something different than git merge?
is Documentation/howto/using-topic-branches out of date?

>	git merge-base -a=20
>0a47c906342e2447003e207d23917dfa5c912071=20
>d2149b542382bfc206cb28485108f6470c979566
>
>to see what the result is for you?

$ git merge-base -a 0a47c906342e2447003e207d23917dfa5c912071 =
d2149b542382bfc206cb28485108f6470c979566
d2149b542382bfc206cb28485108f6470c979566

>Also, maybe the _reason_ you have an old git lying around is=20
>that you have two installations

Doesn't appear to be the case, as I don't have a /usr/bin/git
IIR, months ago I tried to install the rpm and
it failed due to some incompatibility like not groking
a SuSE destination.  I got Dave's git tarball according
to Jeff's howto: http://linux.yyz.us/git-howto.html
and have been building and installing from a git repo since.
(I found git-current tarball dated 7/21/05, so maybe it was then)
I did, however a few months ago copy my i386 home directory over to the
x86_64 box I use now, re-build and re-install.  Dunno
if there may have been a hickup in that process...
I found a backup copy of my i386 bin directory from 2005-08-25 --
binaries still in i386 format.  But I don't think I ran that b/c
it isn't on any PATH.  Git lives in ~/bin which is 1st in my PATH.

I think the lesson I'm taking away from this is that
as I continue to stumble forward using git I should
immediately report anything that doesn't look quite right
while I can still guarantee that all the clues are still
at the scene of the crime.  I expect that I've re-built
and re-installed git several times since the merge
in question was made.

-Len

------_=_NextPart_001_01C600E3.642DDC75
Content-Type: application/octet-stream;
	name="to-linus"
Content-Transfer-Encoding: base64
Content-Description: to-linus
Content-Disposition: attachment;
	filename="to-linus"

Z2l0IG1lcmdlLWJhc2UgLWEgMGE0N2M5MDYzNDJlMjQ0NzAwM2UyMDdkMjM5MTdkZmE1YzkxMjA3
MSBkMjE0OWI1NDIzODJiZmMyMDZjYjI4NDg1MTA4ZjY0NzBjOTc5NTY2CmQyMTQ5YjU0MjM4MmJm
YzIwNmNiMjg0ODUxMDhmNjQ3MGM5Nzk1NjYK

------_=_NextPart_001_01C600E3.642DDC75--
