From: Paul Jakma <paul@clubi.ie>
Subject: seperate commits for objects already updated in index?
Date: Tue, 14 Mar 2006 16:37:40 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Tue Mar 14 17:45:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJCXN-0007pk-Go
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 17:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWCNQiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWCNQiS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 11:38:18 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:56477 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751337AbWCNQiS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 11:38:18 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1/hs7HbSZaO/x9zBVSBkJZirZjx7IQUWs8@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k2EGbejB022722
	for <git@vger.kernel.org>; Tue, 14 Mar 2006 16:37:52 GMT
X-X-Sender: paul@sheen.jakma.org
To: git list <git@vger.kernel.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17588>

Hi,

Dumb question, imagine you made changes to a few files, and ran 
update-index at various stages in between:

$ git status
#
# Updated but not checked in:
#   (will commit)
#
#       modified: foo/ChangeLog
#       modified: foo/whatever
#       modified: bar/ChangeLog
#       modified: bar/other

The changes in bar/ are unrelated to the changes in foo/ - how do you 
commit each seperately? Git doesn't seem to want to let me:

   $ git commit -o bar
   Different in index and the last commit:
   M       bar/ChangeLog
   M       bar/other
   You might have meant to say 'git commit -i paths...', perhaps?

git commit on its own wants to commit all the above files.

what's the silly thing I've missed?

Thanks.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Never tell a lie unless it is absolutely convenient.
