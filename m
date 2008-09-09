From: Peter Krefting <peter@softwolves.pp.se>
Subject: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 9 Sep 2008 07:19:55 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 08:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcwb9-0004b1-Ug
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 08:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbYIIGT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 02:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbYIIGT6
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 02:19:58 -0400
Received: from ds9.cixit.se ([193.15.169.228]:35451 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756193AbYIIGT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 02:19:57 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m896JtY1019976
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Sep 2008 08:19:56 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m896JtXV019971;
	Tue, 9 Sep 2008 08:19:55 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 09 Sep 2008 08:19:56 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95338>

Hi!

I find myself tracking OpenOffice files every now and then. Mostly to
synchronise to be able to edit documents in multiple locations, less
for the actual history.

I notice, however, that the Git history tend to grow quite a bit,
especially for larger documents (I have a 175 kilobyte spredsheet that
has a git database of about 8 megabytes).

Since OpenOffice doucuments are just zipped xml files, I wondered how
difficult it would be to create some hooks/hack git to track the files
inside the archives instead?


Alternatively, does anyone know if it is possible to set OpenOffice not
to use compression for a saved document? If it was uncompressed text, I
would think Git's delta compression would fare better.

-- 
\\// Peter - http://www.softwolves.pp.se/
