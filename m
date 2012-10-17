From: Peter Krefting <peter@softwolves.pp.se>
Subject: L10n regression in 1.8.0.rc2: diffstat summary (git diff --stat,
 git format-patch)
Date: Wed, 17 Oct 2012 11:53:20 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1210171145360.12699@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 12:53:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TORFt-0003Q9-V5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 12:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab2JQKx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 06:53:27 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:52434 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754954Ab2JQKx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 06:53:26 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9HArLC9027312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 17 Oct 2012 12:53:21 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9HArKOJ027308;
	Wed, 17 Oct 2012 12:53:21 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 17 Oct 2012 12:53:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207909>

Hi!

The output of "git format-patch" and "git diff --stat" no longer=20
becomes localized when using 1.8.0.rc2, compared to 1.7.12

Running both versions of "git format-patch -1" from the same=20
repository, with the same settings otherwise, has 1.7.12 output the=20
diffstat summary in Swedish, while 1.8.0.rc2 doesn't:

   diff 1.7.12.txt 1.8.0.rc2.txt
   8c8
   <  1 fil =E4ndrad, 1 till=E4gg(+)
   ---
   >  1 file changed, 1 insertion(+)
   18c18
   < 1.7.12
   ---
   > 1.8.0.rc2

The same applies to "git diff --stat" and "git show --stat". I can=20
understand for "git format-patch" to default to English (but as its=20
output is ignored on read, it doesn't hurt to have it localized), but=20
for diff and show, it is annoying (even if the rest of the "git diff"=20
output also needs to be translated eventually).

--=20
\\// Peter - http://www.softwolves.pp.se/
