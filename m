From: "Reynolds, Stephen (GE EntSol, Intelligent Platforms)" 
	<Stephen.Reynolds@gefanuc.com>
Subject: git-p4: submit  to blank p4 repository help please
Date: Thu, 4 Jun 2009 08:16:04 +0100
Message-ID: <F61C2CF29BF32C4A805C6C029452B92004756039@LONMLVEM06.e2k.ad.ge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 04 09:21:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MC7GS-0005FX-3g
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 09:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbZFDHVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 03:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZFDHVQ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 03:21:16 -0400
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:39772 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbZFDHVP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 03:21:15 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jun 2009 03:21:15 EDT
Received: from source ([12.71.149.1]) (using TLSv1) by exprod5ob111.postini.com ([64.18.4.12]) with SMTP
	ID DSNKSid17WxPZkEo5A03pZMvtQvxfzpAox3S@postini.com; Thu, 04 Jun 2009 00:21:18 PDT
Received: from unknown (HELO cinmlef03.e2k.ad.ge.com) ([3.159.213.46])
  by Cinmlip09.e2k.ad.ge.com with ESMTP; 04 Jun 2009 03:16:12 -0400
Received: from LONMLVEM06.e2k.ad.ge.com ([3.159.240.62]) by cinmlef03.e2k.ad.ge.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 4 Jun 2009 03:16:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-p4: submit  to blank p4 repository help please
Thread-Index: AcnkXHctNycaZbe1RwqPHQNw1bPBtwAARW4QACGl0iA=
X-OriginalArrivalTime: 04 Jun 2009 07:16:12.0119 (UTC) FILETIME=[57112E70:01C9E4E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120683>

Hi

There was some discussion of this under the topic "bug in git-p4?" but I
could see no resolution so I am putting the question out again.

Git-p4 does not seem to work (for me at least) when you try to submit a
git repository to a blank p4 repository. It seems that you have to have
pulled your git repository from p4 originally in order for it to work?

This is the kind of thing I have typically been trying  

git-p4 clone //depot/firmware/fred/bloggs.git

(//depot/firmware/fred/bloggs.git is a folder synced to an empty p4
repository)

cd bloggs

(there is now an empty git repository here)

If I then pull from a git repository into the newly created bloggs.git
and do git-p4 submit 

I get...

Syncronizing p4 checkout...
... - file(s) up-to-date.
Applying 0b666f81da14bf46cada222856762f7fd6641c26 Initial revision

fatal: ambiguous argument '0b666f81da14bf46cada222856762f7fd6641c26^':
unknown revision or path not in the working tree.
Use '--' to separate paths from revisions
Command failed: git diff-tree -r
"0b666f81da14bf46cada222856762f7fd6641c26^"
"0b666f81da14bf46cada222856762f7fd6641c26"


I have tried to checkout pre-existing files from P4, change them in git
and put them back and that works fine.

I am using the git 1.6.3.1.fc9 rpms with the git-p4 taken from the
git-1.6.3.1 source tree.


Thanks for your help

Steve
