From: "LongChair ." <longchair@hotmail.com>
Subject: how do I ignore a directory for diff
Date: Sun, 5 Apr 2015 11:31:54 +0000
Message-ID: <BLU168-W455AD13F694F68E77DFD0EB4FF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 13:40:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeiuS-0005Kl-Ih
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 13:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbbDELjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 07:39:54 -0400
Received: from blu004-omc3s11.hotmail.com ([65.55.116.86]:60916 "EHLO
	BLU004-OMC3S11.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751023AbbDELjy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Apr 2015 07:39:54 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Apr 2015 07:39:53 EDT
Received: from BLU168-W45 ([65.55.116.72]) by BLU004-OMC3S11.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.22751);
	 Sun, 5 Apr 2015 04:31:53 -0700
X-TMN: [wqCmnZwo9dtWI7vscVn3cd0JapAlMOcO]
X-Originating-Email: [longchair@hotmail.com]
Importance: Normal
X-OriginalArrivalTime: 05 Apr 2015 11:31:53.0741 (UTC) FILETIME=[1DAC2BD0:01D06F94]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266802>

Hello,

I have been looking into ignoring a subdirectory of my tree for diffing with upstream.
I'll explain the situation below :

My tree is a fork of an upstream repo.
There is a specific directory in my tree lets call it foo/bar that i would like to ignore for diff. This directory includes only files that i added to my repo and is therefore irrelevant for diffing (i know all files in there have been added and are not in upstream). Having there in the diff is just making a lot of files to appear and that is confusing to see what is changed from upstream.

I have read the docs and found a way mentioning that i should add a line to .gitattributes with :
foo/bar/* -diff

But this still lists the files in there when i'm diffing.

Is there any way to achieve this ? i cant find any clear explanation in the docs.

Any help would be greatly appreciated :)

Lionel.

 		 	   		  