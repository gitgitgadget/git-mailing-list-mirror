From: Jose de Leon <jdeleon@ensim.com>
Subject: How to combine git repos with similar code and keep all branches
 and tags?
Date: Tue, 14 Apr 2015 16:44:13 +0000
Message-ID: <BBAA9EAE77388248BCAB045DA762C5A83EFE242F@EXBE01-ENSIM.ms.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 18:49:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi423-0005dY-Pd
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 18:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932976AbbDNQtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 12:49:46 -0400
Received: from shoul9.shouldermarketclay.com ([72.20.112.5]:10394 "EHLO
	EXBE01-ENSIM.ms.ensim.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753945AbbDNQto convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 12:49:44 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2015 12:49:43 EDT
Received: from EXBE01-ENSIM.ms.ensim.com ([fe80::ddf0:e9:a641:4631]) by
 EXBE01-ENSIM.ms.ensim.com ([fe80::ddf0:e9:a641:4631%13]) with mapi id
 14.02.0247.003; Tue, 14 Apr 2015 09:44:13 -0700
Thread-Topic: How to combine git repos with similar code and keep all
 branches and tags?
Thread-Index: AdB2ztI6QJ0o6s2KSh2JuBsCGX2q2Q==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.58.106.21]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267146>

Hi All,


I've got an interesting problem and the possible solutions I've found from searching google don't seem to work for us.  In a nutshell, I need to combine multiple git repositories into single repository and preserve all history, branches and tags from each repository.    

Does anybody have a solution for this, how do this kind of thing, is it even possible?

For some unknown reason to me, our developers started a git project, called Ver1, this was the first version.  Then sometime later, they created a new git repository called Ver2, the initial commit for Ver2 was essentially a copy of the code in Ver1 from the master.  They didn't clone it, they just copied the code at the latest point.  This wasn't done by forking.  Then they repeated this for Ver3 and Ver4, etc.  On top of all that, they have been adding new code to Ver1, Ver2, etc. that has caused each to divert from the other and each have their own branch and tag sets.  They have similar directory structure and similar file names, but there are some slight differences in structure.

Well, this has become unmanageable and now we want to combine them into one single git repository.   

Logically, these are the same project but at different versions, basically, Ver1 and Ver2, etc, should be simply branches at different times if these were combined into a single repository.
