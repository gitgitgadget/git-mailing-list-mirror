From: Phillip Susi <psusi@ubuntu.com>
Subject: cherry-pick generates bogus conflicts on removed files
Date: Thu, 17 Oct 2013 15:58:30 -0400
Message-ID: <52604166.8000501@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 17 21:58:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWtiS-0005Vt-JU
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 21:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762336Ab3JQT6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 15:58:37 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:51334 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233Ab3JQT6g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 15:58:36 -0400
X-Authority-Analysis: v=2.0 cv=RqFH3VaK c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Qsx_du5GiBkA:10 a=sCfsyOEanakA:10 a=MYoRuGhZM_AA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=0RF_B95KBlcA:10 a=QfKxxUxMAAAA:8 a=UkWXJEkDkiNzEkEEiocA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:56724] helo=[10.1.1.236])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 00/43-05783-66140625; Thu, 17 Oct 2013 19:58:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236314>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a commit I am trying to cherry pick that removes a number of
files.  It seems to generate conflicts for those files that have been
modified on this branch since the common ancestor.  Since they are
being removed, I don't care about what changes have been made on this
branch, just remove them.  Even git cherry-pick -Xtheirs does not
help.  How can I avoid these conflicts, or accept the deletions?  I
tried git add -u, but that seems to take my version rather than accept
the deletion, and there is no -u switch to git rm.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSYEFlAAoJEJrBOlT6nu75kSEIAMjqXl6nhfEhIMC66Zh4W/y0
MZ/+acDUNdvpCDtEpf9nPIFBQUKxdqAhUg0qYLSOvdvhQIvxkgo6nMo15MAA5Dd/
jNPZD78m0qwvNooUhFiHdqSEwob+2ntA9/VVP+LgCsRcK6BUqHs1Z3MKbe4vXPYr
+/bs11daxcnHH81aXOwRcOlUZRsG+yCDQiD9qjhPyv0BCCdS9splC+R7JZy4VaYb
6GQ03G7oY0yFGV9UAOXD1OqDwVPc30tinXlCM2GaBQNc11IQzpi813nEyxTOaf3Z
P5BXXH5ZzDNQS5F6Dn/VVNM6MMxVugIgGJafd4EkJiRHw4fIcUCX3/aeDoEDHlc=
=uy2D
-----END PGP SIGNATURE-----
