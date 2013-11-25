From: Phillip Susi <psusi@ubuntu.com>
Subject: Filter log based on paths NOT touched
Date: Mon, 25 Nov 2013 15:20:09 -0500
Message-ID: <5293B0F9.1050200@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 21:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2fi-00025c-Ey
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab3KYUWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:22:14 -0500
Received: from [75.180.132.120] ([75.180.132.120]:37185 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753622Ab3KYUWN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 15:22:13 -0500
X-Authority-Analysis: v=2.0 cv=CLiorGXD c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Qsx_du5GiBkA:10 a=h_Sp9wbh10QA:10 a=qcVVwzaSNv8A:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=z6d9NglTn88A:10 a=QfKxxUxMAAAA:8 a=JSFNWkuBpiCMQqeAaRwA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:63975] helo=[10.1.1.236])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id A0/19-07327-AF0B3925; Mon, 25 Nov 2013 20:20:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238340>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I can't seem to find a way to invert the meaning of a pathspec given
to git log in order to find commits touching anything BUT a given
path.  Does such a thing exist?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSk7D5AAoJEJrBOlT6nu75myIIAMoAgihPAhDrCBpRKUHF/X8S
B8vjwIg7zALajU+vrz7B/UyxKFHC54sYn0MaAA5htBXKCtd6L0tHrNa1gYbd9qT+
xgTuF7+Unwv90yFBEsoZgEwlSyaLBAVHknMiE4ecxaJrlhBqESbePNrORCwCAuPq
ANrYunEETN2KNgYBkNszdEp7Ga9RcP7LWisL/pNV2k+ac7YfqGp1jsN00jLMYqvH
c+8Kl154N3xgvk+pGvkKGbO3MavkmEK47lLL929g9iXeP3NkMsrxyEjhnABD9tS3
SxzYZt9G+lpH2Tv8l1/NqMafdNy5P7CEs00C4JZn1EzEcIBqMeYgUhce+WU75qc=
=p2gM
-----END PGP SIGNATURE-----
