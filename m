From: "Goetz, Philip \(NIH/NLM/LHC\) [C]" <goetzp@mail.nih.gov>
Subject: documentation for git-rm
Date: Tue, 16 Jan 2007 12:48:50 -0500
Message-ID: <7A7EC09F0481DB46BC1EF0B0A9844CDB16D463@NIHCESMLBX8.nih.gov>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Tue Jan 16 19:03:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6seG-0002q2-8R
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 19:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbXAPSDA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 13:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbXAPSDA
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 13:03:00 -0500
Received: from nihcessmtp3.hub.nih.gov ([128.231.90.117]:57804 "EHLO
	NIHCESSMTP3.hub.nih.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbXAPSC7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jan 2007 13:02:59 -0500
Received: from NIHCESMLBX8.nih.gov ([156.40.71.208]) by NIHCESSMTP3.hub.nih.gov with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 Jan 2007 12:48:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: documentation for git-rm
Thread-Index: Acc5lpShhYK4UL5YQpSO32UZV28wlg==
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 16 Jan 2007 17:48:51.0208 (UTC) FILETIME=[95100080:01C73996]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36952>

Hello!  The documentation for git-rm at
http://www.kernel.org/pub/software/scm/git/docs/git-rm.html says

EXAMPLES

git-rm Documentation/\*.txt

    Removes all *.txt files from the index that are under the
Documentation directory and any of its subdirectories. The files are not
removed from the working tree.


I think that this should say


git-rm --cached Documentation/\*.txt

?

Otherwise I don't see why it wouldn't remove the files from the working
tree.  If this is a documentation error, it could cause some bad
problems for people who follow it.
