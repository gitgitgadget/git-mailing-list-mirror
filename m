From: "Christoph Buchner" <bilderbuchi@phononoia.at>
Subject: Bug: git ls-files and ignored directories
Date: Thu, 31 May 2012 12:14:51 +0200 (CEST)
Message-ID: <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 12:14:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa2PB-00079v-9O
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 12:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab2EaKOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 06:14:54 -0400
Received: from dd24126.kasserver.com ([85.13.143.154]:53477 "EHLO
	dd24126.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab2EaKOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 06:14:53 -0400
Received: from dd24126.kasserver.com (dd0801.kasserver.com [85.13.143.205])
	by dd24126.kasserver.com (Postfix) with SMTP id C35C5B4C00D
	for <git@vger.kernel.org>; Thu, 31 May 2012 12:14:51 +0200 (CEST)
In-Reply-To: <20120530102218.0625CFC006A@dd24126.kasserver.com>
X-SenderIP: 128.130.169.107
User-Agent: ALL-INKL Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198878>

This is the right place to report bugs, right?
Is there any protocol to follow I'm not aware of, to enable you to process this bug report?

greets,
Christoph

----- Original Message -----
From: bilderbuchi@phononoia.at
To: git@vger.kernel.org
Date: 30.05.2012 12:22:18
Subject: Bug: git ls-files and ignored directories


> Hi!
> 
> I think I've been bitten by a bug in git ls-files - committed directories (and files therein) which are matched by a "dir/" gitignore rule are not shown by "git ls-files --exclude-standard -i", although they should be. Matched files are shown.
> 
> I've found a very brief discussion on this mailing list from March 2011 about this, including a repro procedure which still is valid today, at http://marc.info/?l=git&m=129926031808376&w=4
> 
> Is that a known/in progress bug? If yes, (when) can a fix be expected? How can I work around this in the meantime? 
> If it's not a bug, how do you do this properly? My original problem was that  I want to list files which have been committed to git but match an existing gitignore pattern. Richard Hansen has written a very nice alias for that (http://stackoverflow.com/a/9370094/599884, with some discussion of this bug in the comments), but due to the present bug this does not work totally correctly. 
> 
> Having a built-in git feature for this would be great, btw ("git ls-files --committed-but-ignored"? :-)). Do I have to submit a separate feature request?
> 
> thanks, 
> Christoph
> 
> p.s.: The repro procedure from the linked list discussion:
>> $ mkdir test
>> $ cd test
>> $ git init
>> $ mkdir testdir
>> $ touch testdir/test
>> $ git add testdir/test
>> $ git commit -m "add test"
>> $ echo "testdir/" > .gitignore
>> $ git ls-files --exclude-standard -i
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
