From: Phillip Susi <psusi@ubuntu.com>
Subject: git am and mangled subject lines
Date: Mon, 24 Feb 2014 14:28:16 -0500
Message-ID: <530B9D50.6020705@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 24 20:28:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1CR-0000hh-HE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 20:28:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbaBXT2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 14:28:19 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:54876 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbaBXT2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 14:28:17 -0500
X-Authority-Analysis: v=2.0 cv=GMaK45xK c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=JipEcVzqA9wA:10 a=xWGVVLIfpKYA:10 a=S1A5HrydsesA:10 a=Qsx_du5GiBkA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=cjR-qXcwzYUA:10 a=QfKxxUxMAAAA:8 a=GUWf_Em-vh2_6UilTdwA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:53544] helo=[10.1.1.236])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id EC/A8-00728-F4D9B035; Mon, 24 Feb 2014 19:28:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242630>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

git am already ignores the "[PATCH X/Y]" prefix that format-patch
adds.  Is it possible to get it to ignore any additional prefix that a
bug tracker mangles into the subject line?  i.e. "bug #nnnn:"?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTC51PAAoJEI5FoCIzSKrw5YYH/R6t5fS71UAfFomsD/8HWHoI
ve1tIyyruHeriOV8qttlNQGynuEXkI2IBMWJaB7jV5oK8d4OsVQZ/7Nfcxoj52SO
JXDSs0MVDB2Ro2lHXRnQsaCy/TUm+ALWsNiTy0kYMTeC7Iqtri1T1l8gaG2rwRJh
AGT1sgGssl9CvGFgDHJxRZ4WHSl/XrcjErZeJHz59hGIeJSeq2tJXjfNzNTHrNpw
B4rcW8AxXhx+3vWPx8PSJsiVeWR1ndILXwxBsUHPuUW5SdsNBrty1L+4xrGIbxm7
qV7HVJ6BvJ4MXuTEOec3a9ACmvUTDNNMGRf2xonjXMcguojRZHjltRazsI34n8o=
=sWTQ
-----END PGP SIGNATURE-----
