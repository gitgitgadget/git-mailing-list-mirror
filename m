From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: Make test on AIX
Date: Fri, 27 Jun 2008 16:13:41 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302389D09@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCLHG-00025g-Mg
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 23:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756071AbYF0VNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 17:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755905AbYF0VNp
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 17:13:45 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:55594 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbYF0VNo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jun 2008 17:13:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Make test on AIX
Thread-Index: AcjYmqyfD3BZ+yD+SFie2zQh5yM9uQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86634>

Hi all,

I just got through a rather painful build and install of 1.5.6.1 on AIX
and I was wondering if anyone has any clues on how to get the tests to
run a bit better there.

The first thing I encountered was that because the tests all use
#!/bin/sh the exit code was not what the tests expected.  So I ended up
running 'make SHELL=`which bash` all' directly in the git/t/ directory.
That seemed to shake out and work for most of the tests except for
t/t7502-commit.sh.  Try as I might, I could not get SHELL_PATH set to
anything but /bin/sh except to hard-code the SHELL_PATH in this script.

Am I missing something?  Is there an easier way to get the test suite to
work?  If so, I appreciate any advice.  If not, does anyone have any
ideas on how I might fix this and create a patch for git to submit?  I
don't claim to be a make or bash expert, so go easy on me if I've missed
something obvious ;-)

Any help appreciated!

Cheers,
Craig
