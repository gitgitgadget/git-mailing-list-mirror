From: "Lay, Stefan" <stefan.lay@sap.com>
Subject: How to specify a default <start-point> for git branch
Date: Thu, 8 Sep 2011 10:00:21 +0200
Message-ID: <D3AA6127B29A3048B2939A08CC561AF55EDD6CDD0E@DEWDFECCR01.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "manuel.doniger@googlemail.com" <manuel.doniger@googlemail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	"jgit-dev@eclipse.org" <jgit-dev@eclipse.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 10:06:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Zcy-0002Ar-Md
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 10:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab1IHIGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 04:06:18 -0400
Received: from smtpgw04.sap-ag.de ([155.56.66.99]:12425 "EHLO smtpgw.sap-ag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932302Ab1IHIGN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 04:06:13 -0400
Thread-Topic: How to specify a default <start-point> for git branch
Thread-Index: Acxt/Vo3aKVsdn+lRdiQRwL1PiOlZQ==
Accept-Language: de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: Aiew EhoS FY4a GGKZ JPe1 NnvN P4xs SUiD TQFv VXVd VkKL
 Whue Y0OM ZDat bMdO
 gQAE;3;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA7AGoAZwBpAHQALQBkAGUAdgBAAGUAYwBsAGkAcABzAGUALgBvAHIAZwA7AG0AYQBuAHUAZQBsAC4AZABvAG4AaQBnAGUAcgBAAGcAbwBvAGcAbABlAG0AYQBpAGwALgBjAG8AbQA=;Sosha1_v1;7;{12246E10-6E1B-4CD4-B047-1A1AC3259E99};cwB0AGUAZgBhAG4ALgBsAGEAeQBAAHMAYQBwAC4AYwBvAG0A;Thu,
 08 Sep 2011 08:00:21
 GMT;SABvAHcAIAB0AG8AIABzAHAAZQBjAGkAZgB5ACAAYQAgAGQAZQBmAGEAdQBsAHQAIAA8AHMAdABhAHIAdAAtAHAAbwBpAG4AdAA+ACAAZgBvAHIAIABnAGkAdAAgAGIAcgBhAG4AYwBoAA==
x-cr-puzzleid: {12246E10-6E1B-4CD4-B047-1A1AC3259E99}
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180948>

Is it possible in git to configure a default <start-point> for the git-branch command?

For some workflows it could be useful to define e.g. a remote-tracking branch as the default <start-point> for new branches. Then there would be a tracking configuration for each created branch and tools like ALM tools could easily determine the remote repository.

For EGit-/JGit-development there is a proposal in Gerrit to add a new config parameter workflow.defaultsourceref (http://egit.eclipse.org/r/#change,4168). I suggested to use workflow.branchstartpoint instead.

What do you think about such a property?
