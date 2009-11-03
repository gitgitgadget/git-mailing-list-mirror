From: "Joshua J. Kugler" <joshua@eeinternet.com>
Subject: Problem signing a tag
Date: Mon, 02 Nov 2009 16:58:16 -0800
Organization: EE Internet
Message-ID: <200911021558.17550.joshua@eeinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 02:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N58fb-0000lm-TP
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 02:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756961AbZKCB6l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 20:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756862AbZKCB6l
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 20:58:41 -0500
Received: from msgmmp-2.gci.net ([209.165.130.12]:60722 "EHLO msgmmp-2.gci.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756784AbZKCB6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 20:58:40 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2009 20:58:40 EST
Received: from hyperion.eeinternet.com ([206.174.62.163])
 by msgmmp-1.gci.net (Sun Java System Messaging Server 6.2-3.03 (built Jun 27
 2005)) with ESMTP id <0KSI006O4DDS7980@msgmmp-1.gci.net> for
 git@vger.kernel.org; Mon, 02 Nov 2009 15:58:40 -0900 (AKST)
Received: from hosanna.eeinternet.com (unknown [192.168.100.194])
	by hyperion.eeinternet.com (Postfix) with ESMTP id 57E083F21D	for
 <git@vger.kernel.org>; Mon, 02 Nov 2009 15:58:25 -0900 (AKST)
X-Face: %RQZkR-ZZZ/},^dzp$qPotQ8:EI[dl6TX^9<K):};#rjcB`apZ95_e*NbqV8Db$,=?utf-8?q?r=7C7x=5FK=0A=09TOpQkS5A?=>=R9nGN)Qva<p+^;@rEbe*bA5XUd<=?utf-8?q?csl=3BT0d=5FP=3AdH21=2EuJAZ=24iao=26H!K=3A9u=7E=7B9=0A=09WV4=5BX4?=
 =?utf-8?q?*=7B=60=5Evlz=5FIVZ?=)R^X5{:l6#=%fLpM^!}~B"CN.R%wwU-Ni-L2TgD](24jBa=_G@
 =?utf-8?q?Zga=0A=09KNcSq4/Lv=3AJm!z=5D=2Ee5=25IgMb=5Cl-xGs=2EN5M4=5D=3A?=
 =?utf-8?q?vz2?="XrHM]j$h/aNM2J_1}}i@"
 =?utf-8?q?l=26Phy5=3FU1=0A=09mfdxMpo=7D?=)/ixNj03,scN>w*od72RYo9i+XAj
Content-disposition: inline
User-Agent: KMail/1.9.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131940>

Nobody on the git IRC channel responded to this question, even after=20
asking it a few times, so I thought I'd try here.

I'm having trouble signing a tag.  I'm using this command:

git tag -u EAFD344D14EA086E -F .git/TAG_EDITMSG tag_name

I type in my passphrase, and am then told:

error: gpg failed to sign the tag
error: unable to sign the tag

However, if I use this command:

gpg -s -u EAFD344D14EA086E

and use the same passphrase, it works fine. Is there any way to find ou=
t=20
why a key-signing is failing?

This is git 1.6.5.2 and gpg 1.4.9

Thanks!

j

--=20
Joshua Kugler
Part-Time System Admin/Programmer
http://www.eeinternet.com
PGP Key: http://pgp.mit.edu/ =A0ID 0x14EA086E
