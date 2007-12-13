From: Eric Blake <ebb9@byu.net>
Subject: git describe candidate filtering
Date: Wed, 12 Dec 2007 22:25:36 -0700
Message-ID: <4760C250.5080103@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 06:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2geE-0004Xc-5w
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 06:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXLMF3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 00:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbXLMF3v
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 00:29:51 -0500
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:37162 "EHLO
	QMTA01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751298AbXLMF3u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2007 00:29:50 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2007 00:29:50 EST
Received: from OMTA10.emeryville.ca.mail.comcast.net ([76.96.30.28])
	by QMTA01.emeryville.ca.mail.comcast.net with comcast
	id Q4vC1Y0010cQ2SL0A01P00; Thu, 13 Dec 2007 05:22:55 +0000
Received: from [192.168.0.103] ([67.166.125.73])
	by OMTA10.emeryville.ca.mail.comcast.net with comcast
	id Q5Nt1Y00G1b8C2B0800000; Thu, 13 Dec 2007 05:22:55 +0000
X-Authority-Analysis: v=1.0 c=1 a=xe8BsctaAAAA:8 a=IJjOaUJGJywgkCdiDRgA:9 a=_QCemyXPWz-8IZI3nWQA:7 a=TTbL0v5DxM0hS_TGJtr__VGlcfMA:4 a=eDFNAWYWrCwA:10 a=rPt6xJ-oxjAA:10
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68120>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Would it be possible to add an option to git-describe that limits the
candidate tags to those matching a glob pattern or regular expression?
I've got a repository imported from CVS which has a number of less
interesting tags for events such as branch creation, but I'm only
interested in describing the current commit relative to tags matching
v[0-9]\.[0-9]*, rather than the closest tag of any spelling.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHYMJQ84KuGfSFAYARAsd8AKCwuCZsxZBcV3nd849Saxvch/OZiACfagTe
mitsZEVhXy7hyBg0KALQG0o=
=Qq8n
-----END PGP SIGNATURE-----
