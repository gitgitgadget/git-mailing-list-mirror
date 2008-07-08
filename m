From: "James B. Byrne" <byrnejb@harte-lyne.ca>
Subject: GiT and CentOS 5.2
Date: Tue, 8 Jul 2008 13:46:40 -0400 (EDT)
Message-ID: <49523.216.185.71.22.1215539200.squirrel@webmail.harte-lyne.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 20:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGHwD-0005wW-Dv
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 20:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbYGHS2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 14:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753949AbYGHS2T
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 14:28:19 -0400
Received: from inet06.hamilton.harte-lyne.ca ([216.185.71.26]:36419 "HELO
	inet06.hamilton.harte-lyne.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754035AbYGHS2S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2008 14:28:18 -0400
X-Greylist: delayed 2485 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jul 2008 14:28:18 EDT
Received: from inet07.hamilton.harte-lyne.ca (inet07.hamilton.harte-lyne.ca [216.185.71.27])
	by inet06.hamilton.harte-lyne.ca (8.13.1/8.13.1) with ESMTP id m68HknxA017989
	for <git@vger.kernel.org>; Tue, 8 Jul 2008 13:46:50 -0400
Received: from webmail.harte-lyne.ca (inet07.hamilton.harte-lyne.ca [216.185.71.27])
	by inet07.hamilton.harte-lyne.ca (8.13.1/8.13.1) with ESMTP id m68Hke6h009467
	for <git@vger.kernel.org>; Tue, 8 Jul 2008 13:46:40 -0400
Received: from 216.185.71.22
        (SquirrelMail authenticated user byrnejb)
        by webmail.harte-lyne.ca with HTTP;
        Tue, 8 Jul 2008 13:46:40 -0400 (EDT)
User-Agent: SquirrelMail/1.4.8-4.0.1.el4.centos
X-Priority: 3 (Normal)
Importance: Normal
X-Harte_and_Lyne_Limited-MailScanner-Information: For further information contact postmaster@harte-lyne.ca
X-Harte_and_Lyne_Limited-MailScanner-ID: m68Hke6h009467
X-Harte_and_Lyne_Limited-MailScanner: Checked by clamav and Found to be clean
X-Harte_and_Lyne_Limited-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=0.131, required 3, AWL -0.07,
	BDY_PRES 0.20, SPF_PASS -0.00)
X-MailScanner-From: byrnejb@harte-lyne.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87781>

OS = CentOS-5.2
perl = 5.8.8

I get git from the yum repository at kernel.org.  Up until the most recent
update I had no problems.  Now I am getting these dependency errors:

Error: Missing Dependency: libcurl.so.4 is needed by package git
Error: Missing Dependency: perl(:MODULE_COMPAT_5.10.0) is needed by
package perl-Git
Error: Missing Dependency: libc.so.6(GLIBC_2.7) is needed by package git
Error: Missing Dependency: libexpat.so.1 is needed by package git
Error: Missing Dependency: libcrypto.so.7 is needed by package git


Are these dependencies actually meaningful?  By that I mean, are there
features used in the latest release of GiT that depend upon features of
GLIBC 2.7 that are not part of glibc-2.5?  Similarly, are there features
of curl used in the latest git that are not present or work differently in
curl 7.15.2?  Ditto for OpenSSL and libxpat.

I would like to stay current with git but I cannot if these dependencies
are actually required.

Regards,


-- 
***          E-Mail is NOT a SECURE channel          ***
James B. Byrne                mailto:ByrneJB@Harte-Lyne.ca
Harte & Lyne Limited          http://www.harte-lyne.ca
9 Brockley Drive              vox: +1 905 561 1241
Hamilton, Ontario             fax: +1 905 561 0757
Canada  L8E 3C3
