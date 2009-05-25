From: Jeff Brown <jeff@jeffandbetsy.net>
Subject: tracking committer vs. author
Date: Mon, 25 May 2009 16:20:02 -0500
Message-ID: <bbd12f0f0905251420l1ab63ca5y32589a4451064b9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 23:20:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8hb5-0002To-Sz
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 23:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbZEYVUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 17:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbZEYVUD
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 17:20:03 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:57007 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbZEYVUC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 17:20:02 -0400
Received: by fxm12 with SMTP id 12so1605919fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 14:20:03 -0700 (PDT)
Received: by 10.204.65.65 with SMTP id h1mr7359232bki.18.1243286402937; Mon, 
	25 May 2009 14:20:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119965>

I have noticed that when we pull changes from non-committers into our
repo, sometimes meta information about who committed the change to the
repo is included along side info about who actually wrote the changes.
 For example, see
http://github.com/grails/grails/commit/8ac450c37d16b0468ba0f92d3008968fd6a41a75
and note that graemerocher has commit privileges to the repo but
ihotary does not.  ihatory's commit was pulled in by graemerocher.

The commit at http://github.com/grails/grails/commit/ff770359d152683d5794887cd743a10ce7d04501
was also authored by a non committer.  I pulled that change in myself
this evening.  Notice that there is no info displayed there to
indicate that I (jeffbrown) am the person who pushed that change into
the repo.

I don't know what was done differently for those 2 scenarios but both
of those commits were authored by folks who do not have commit
privileges to the repo at
http://github.com/grails/grails/commits/master.

I don't think this is a github issue.  If I am wrong, please let me know.

If I want to track not only who authored the commit but also who
pushed it into the repo (like you see at
http://github.com/grails/grails/commit/8ac450c37d16b0468ba0f92d3008968fd6a41a75),
what is the procedure for making that happen?



jb

-- 
Jeff Brown
SpringSource
http://www.springsource.com/

Autism Strikes 1 in 166
Find The Cause ~ Find The Cure
http://www.autismspeaks.org/
