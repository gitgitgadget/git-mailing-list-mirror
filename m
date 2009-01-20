From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: git fast-import problem converting from CVS with git 1.6.1 and cvs2svn 2.2.0
Date: Tue, 20 Jan 2009 09:46:52 -0600
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302BC6851@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 20 17:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJ4d-0002Q9-5n
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562AbZATQCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 11:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbZATQCF
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:02:05 -0500
Received: from mail.de.mqsoftware.com ([66.192.70.108]:20319 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbZATQCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2009 11:02:04 -0500
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jan 2009 11:02:04 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git fast-import problem converting from CVS with git 1.6.1 and cvs2svn 2.2.0
Thread-Index: Acl7FlA+C4XwNB8tTcebTogzddVJxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106484>

Hello all,

Back in June I had done a test convert of our CVS repo using git 1.5.5.1
and cvs2svn 2.2.0 that went reasonably well (although it takes nearly a
week to finish!).  Recently I wanted to try again with the latest
versions of git and cvs2svn.

When I get to the final stage (running git fast-import to build the
converted repo), I get the following output:
cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git
fast-import
fatal: Unsupported command: '.
fast-import: dumping crash report to .git/fast_import_crash_19097

The crash is 18MB and I'd rather not post it, but the only bits that
seem somewhat interesting are:
fast-import crash report:
    fast-import process: 19097
    parent process     : 19095
    at Mon Jan 19 11:44:42 2009

fatal: Unsupported command: '.

Most Recent Commands Before Crash
---------------------------------
(...)
  reset refs/tags/T_9772
  from :1000007127
  reset refs/heads/TAG.FIXUP
  
  commit refs/heads/TAG.FIXUP
  mark :1000007128
  committer cvs2svn <cvs2svn> 1002043747 +0000
  data 88
* '.


Has anyone got any ideas how to resolve this?

Thanks,





--

Kelly F. Hickel
Senior Product Architect
MQSoftware, Inc.
952-345-8677 Office
952-345-8721 Fax
kfh@mqsoftware.com
www.mqsoftware.com
Certified IBM SOA Specialty
Your Full Service Provider for IBM WebSphere Learn more at
www.mqsoftware.com 
