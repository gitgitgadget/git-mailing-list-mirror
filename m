From: "Adam Mercer" <ramercer@gmail.com>
Subject: git cvsimport error
Date: Wed, 21 May 2008 14:14:39 -0500
Message-ID: <799406d60805211214r6315268ard77678eb2ec5d732@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 21:18:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jytn9-00056p-SZ
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 21:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864AbYEUTPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 15:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757520AbYEUTPM
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 15:15:12 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:56540 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756218AbYEUTPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 15:15:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1741545ywe.1
        for <git@vger.kernel.org>; Wed, 21 May 2008 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=+WPAcNSFchGEeTdNv/lVV5W2H7itaZ1nHXbVd7xPs3Y=;
        b=b7Gj0ZlHJtiDTBym1J04qy+LlU/RD3j7JDHqK1xBpWMTks+imss7Rc/z1nYeI92dFkd5JWadk2cVGRwqzk5hIwkal0pY0iCTdDuLE6D44CnOPrSBSuuhY3x4JENLI37TfGt7+tqcjPzK1cxGcGfQ+vPglx+v1yQ9BdyoCDtY5F8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S/AHzC3p6Q4XRsvXbaqziDp9YBCZhwriRc8z69u59N9jEGTpdLWjg7L3szSvyI17q7jias7LyKBIZWktRrde1foUhAsY3tLjRo+PwOCT9q+X7y6hyvSvDRjHwq9bS1BRw0cuMZ43mkLlJV+3TaQEqtTxltew/Jkl1/6nT8zToMs=
Received: by 10.151.102.8 with SMTP id e8mr741871ybm.61.1211397279989;
        Wed, 21 May 2008 12:14:39 -0700 (PDT)
Received: by 10.150.144.5 with HTTP; Wed, 21 May 2008 12:14:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82567>

Hi

I'm trying to convert a CVS repository to GIT (1.5.5.1 on Intel Mac OS
X 10.5.2) using the following:

[ram@mimir ~]$ git cvsimport -v -d :local:/Users/ram/test_cvs -C glue.git glue
Initialized empty Git repository in /Users/ram/glue.git/.git/
Running cvsps...
cvs_direct initialized to CVSROOT /Users/ram/test_cvs
cvs rlog: Logging glue
cvs rlog: Logging glue/bin
cvs rlog: Logging glue/debian
cvs rlog: Logging glue/doc
cvs rlog: Logging glue/etc
cvs rlog: Logging glue/glue
cvs rlog: Logging glue/glue/ligolw
cvs rlog: Logging glue/glue/ligolw/utils
cvs rlog: Logging glue/glue/segfindserver
cvs rlog: Logging glue/glue/segfindserver/segments_1_7
cvs rlog: Logging glue/man
cvs rlog: Logging glue/man/man1
cvs rlog: Logging glue/sbin
cvs rlog: Logging glue/src
cvs rlog: Logging glue/src/conf
cvs rlog: Logging glue/src/conf/db2
cvs rlog: Logging glue/src/conf/mysql
cvs rlog: Logging glue/src/conf/q_replication
cvs rlog: Logging glue/src/conf/q_replication/cit
cvs rlog: Logging glue/src/conf/q_replication/lho
cvs rlog: Logging glue/src/conf/q_replication/llo
cvs rlog: Logging glue/src/segments
cvs rlog: Logging glue/test
Fetching glue/ldbd.py   v 1.1
Unknown: error
[ram@mimir ~]$

How can I get a more verbose error message to try and fix what's going
wrong here?

Cheers

Adam
