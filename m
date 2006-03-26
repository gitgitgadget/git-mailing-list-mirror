From: Paul Jakma <paul@clubi.ie>
Subject: minimum set of utils for git 'server'?
Date: Sun, 26 Mar 2006 18:13:01 +0100 (IST)
Message-ID: <Pine.LNX.4.64.0603261804180.5276@sheen.jakma.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Sun Mar 26 19:13:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNYnr-0008Tb-Qa
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 19:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWCZRNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 12:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWCZRNU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 12:13:20 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:37005 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751253AbWCZRNU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 12:13:20 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX1+SnNDEAWgdZDTashVVPARpIWFeHyRMfEY@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.6/8.13.1) with ESMTP id k2QHD1BY027982
	for <git@vger.kernel.org>; Sun, 26 Mar 2006 18:13:13 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18048>

Hi,

What is the minimum set of git utilities required for a git 'server'?

 	git-receive-pack
 	git-daemon
 	git-init-db
 	git-repack
 	git-fsck-objects
 	?
 	?

I have an old server, but it lacks recent python (for 
merge-recursive), so I'd like to ensure no one accidently tries to do 
actual merging locally. Only the bare minimum needed for a central 
git 'server' desired.

?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
The faster I go, the behinder I get.
 		-- Lewis Carroll
