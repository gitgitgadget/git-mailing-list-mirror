From: Aaron Dwyer <Aaron.Dwyer@imgtec.com>
Subject: Git-P4 Bug With Filename Case Change
Date: Wed, 17 Jul 2013 22:11:45 +0000
Message-ID: <897B3B32-0200-4290-AA16-DCAF42923CE0@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 00:12:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZxA-0005At-8R
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 00:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796Ab3GQWMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 18:12:02 -0400
Received: from multi.imgtec.com ([194.200.65.239]:56411 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755192Ab3GQWMB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jul 2013 18:12:01 -0400
Thread-Topic: Git-P4 Bug With Filename Case Change
Thread-Index: AQHOgzqfjgxmViGbl0OpuVrZ1jST+g==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.0.174]
Content-ID: <31CE6DF0E0F148439C1598B2EAB84B28@imgtec.com>
X-SEF-Processed: 7_3_0_01192__2013_07_17_23_11_59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230660>

Hello Git Developers,

	We recently have moved our project from Git to Perforce and those of us who prefer Git still are using Git p4 to stay in Git land.  One of the files in our repository was renamed while still in Git, but the rename only consisted of a case change of a character in the name.  Now, on an OS X box with a case insensitive file system (not sure if that matters), one of our guys cloned from perforce with Git p4 and used @all to get all history.  When this operation is finished, the file name is in its original state, not the newer renamed state.  Perforce doesn't respect that file as being in the repository.  We noticed this after making a local Git commit and upon issuing a Git p4 submit, things go haywire with "file(s) not opened on this client" and nothing getting submitted.

Aaron Dwyer
Senior Software Architect
Imagination Technologies
