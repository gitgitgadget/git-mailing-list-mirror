From: Peter Krefting <peter@softwolves.pp.se>
Subject: gitk fails to start after upgrading to 2.6.3 (cannot load
 translation)
Date: Tue, 10 Nov 2015 10:48:47 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1511101040180.27599@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 10:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw5hp-00076Q-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 10:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbbKJJ6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2015 04:58:21 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:34783 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752354AbbKJJ5v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 04:57:51 -0500
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2015 04:57:51 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id tAA9mlPs029058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 10 Nov 2015 10:48:47 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id tAA9mloj029054;
	Tue, 10 Nov 2015 10:48:47 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 10 Nov 2015 10:48:47 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281105>

Hi!

After upgrading Git to 2.6.3 (from 2.5.0), gitk refuses to start when=20
trying to load the Swedish translation if I pass it a commit range:

   $ gitk v2.5.0..v2.6.3
   Error in startup script: bad menu entry index "=C4ndra vy..."
       while executing
   ".bar.view entryconf [mca "Edit view..."] -state normal"
       invoked from within
"if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {=
}} {
     # create a view for the files/dirs specified on the command line
     se..."
     (file "/usr/local/bin/gitk" line 12442)

If I start it without any parameters, it does start up, but the main=20
menu is untranslated.

The translation for this entry is defined in gitk-git/po/sv.po line 135=
=20
and hasn't changed since 2008, even if the sv.po file does have a few=20
updates since the previous version in some other places.

--=20
\\// Peter - http://www.softwolves.pp.se/
