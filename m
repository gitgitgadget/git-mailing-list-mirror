From: Phillip Susi <psusi@ubuntu.com>
Subject: New directory lost by git am
Date: Tue, 04 Mar 2014 21:49:07 -0500
Message-ID: <531690A3.3040509@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 03:49:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL1tR-0001ua-7u
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 03:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640AbaCECtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 21:49:09 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:56530 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299AbaCECtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 21:49:08 -0500
X-Authority-Analysis: v=2.0 cv=S8pbMfQP c=1 sm=0 a=S/gQ7PeTrZbCJAhh99lbaw==:17 a=cs1xLa0W9aIA:10 a=AjaFmKlbhAgA:10 a=S1A5HrydsesA:10 a=ossw24rp0ecA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=QfKxxUxMAAAA:8 a=hvtkeyCJAAAA:8 a=jA6ef_oAWKtpWPPB8AQA:9 a=wPNLvfGTeEIA:10 a=tDfr2UcQz9MA:10 a=S/gQ7PeTrZbCJAhh99lbaw==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 72.238.67.160
Received: from [72.238.67.160] ([72.238.67.160:56998] helo=[192.168.1.107])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 24/1D-17312-2A096135; Wed, 05 Mar 2014 02:49:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243414>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I applied a patch with git am that adds a new source file to a new
directory, and later noticed that file was missing from the commit.
It seems that git am fails to add the new file/directory to the index.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCgAGBQJTFpCjAAoJEI5FoCIzSKrw1CsH/1E/0Wgs3RtXPLqWbwVoFy+U
Bc7dW7TBmb8EScC+3DedI4u9ryjZigjbsnBg1Y8V/gEtmUSmvt1e8CWTdvMLQpvx
bnasL4uia/CBOg/aZkJ1iEBiHA3sUi9Es4FqoHbuGBn0bkDrA2NQvt3bCqNf6n8H
PCeWx/qb8+F4niI0I8T5ASeqOHMxxSegHvlGezl6XZoGHa5SeLRrg7JtW3ZoWKCO
q6GRzR6dV4FWJckfajUo34IUQNS4YA7wLpmC3PVUn3+EgF+affAEigjVWGRWdf2k
cuaNu6hUAuD/2EHhCt6YP+ubV+FYiU86QOvmVifVpH1Apd29Fw4Kqnvyq2zJVC0=
=hXsK
-----END PGP SIGNATURE-----
