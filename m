From: "VAUCHER Laurent" <VAUCHER@fermat.eu>
Subject: Problem with git-svnimport
Date: Tue, 16 Oct 2007 14:30:30 +0200
Message-ID: <55DDB08CC9CD2941A70E8D626789A2C906A4031A@ec8l7ljvo9h5dde.hosting.exch>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 14:35:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihle3-0003y8-KP
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 14:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758204AbXJPMfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 08:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758319AbXJPMfM
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 08:35:12 -0400
Received: from mail04.net-streams.fr ([213.41.74.9]:2790 "EHLO
	mail04.net-streams.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757337AbXJPMfK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 08:35:10 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2007 08:35:10 EDT
Received: from ec8l7ljvo9h5dde.hosting.exch [10.16.3.20] by mail04.net-streams.fr with ESMTP
  (SMTPD-9.10) id ACAA05CC; Tue, 16 Oct 2007 14:20:58 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with git-svnimport
Thread-Index: AcgP8ADfejCCl6nlQY+ySpGvCMx65g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61155>

  Hi.

  Trying to convert a svn repository to git, I encountered the following
error:

Use of uninitialized value in hash element at /usr/bin/git-svnimport
line 534.

  Line 534 reads:
	my $gitrev = $branches{$srcbranch}{$therev};

  I have installed packages git-core and git-svn on Ubuntu. These
package have versions: "1:1.5.2.5-2-feisty1"

  The tool seems to choke on tags or branches with special characters
(underscore, for instance).


Laurent.
