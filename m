From: Paul Jakma <paul@clubi.ie>
Subject: git-cvsimport missed a commit
Date: Tue, 14 Mar 2006 17:34:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603141727450.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Tue Mar 14 18:44:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJDQ6-0001RP-Rm
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 18:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWCNRev (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 12:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWCNRev
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 12:34:51 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:44160 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751521AbWCNRev
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 12:34:51 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1/zNoNidAKCRWXH/XLH4b637GnXMNxfQmM@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k2EHYWPZ023893
	for <git@vger.kernel.org>; Tue, 14 Mar 2006 17:34:44 GMT
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17595>

git-cvsimport missed a commit (one involving 'renamed' files in CVS, 
added/deleted).

I'm wondering how best to fix this. My thinking was to just branch my 
'cvs_head' from the ancestor prior the missed commit, rename the 
heads around, and try again.

Is there a better way? Given I actually have the missing commit in my 
'master' branch?

(I actually have a 2-way thing going with CVS. I export selected 
commit from master to CVS every now and then, and get my own CVS 
commits back again via a later import - seems to work).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
So much food; so little time!
