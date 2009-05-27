From: Aaron180 <aaron@vanstralen.net>
Subject: Access Denied when pushing git
Date: Tue, 26 May 2009 18:40:47 -0700 (PDT)
Message-ID: <1243388447198-2978561.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 03:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9899-00070v-GA
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 03:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670AbZE0Bkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 21:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756203AbZE0Bkq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 21:40:46 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48848 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbZE0Bkp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 21:40:45 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1M988N-0008FB-6e
	for git@vger.kernel.org; Tue, 26 May 2009 18:40:47 -0700
X-Nabble-From: aaron@vanstralen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120018>


I am a newbie with git but seem to have a problem with pushing a git
repository over a network.
Here is what I do to recreate the problem:

1. create a new git repository on the computer to push to
    mkdir ~/git/test.git
    cd !$
    git --bare init-db

2. On my local computer I then create a new git repository and add a random
file to it:
   mkdir test
   git init
   touch TEST
   git add .
   git commit -m "initial commit"

3. Then add the remote computer via:
   git remote add origin ssh://user@site.com/~/git/test.git

4. Then I try to push the local repository to the remote via:
   git push origin master

This is what I get when I do that:

fatal: protocol error: bad line length character  <---- sometimes this is
not there
Access denied
Access denied
Access denied
Access denied
FATAL ERROR: Server sent disconnect message
type 2 (protocol error):
"Too many authentication failures for user"

I am using cygwin on an XP machine and trying to push to a unix server.

I have also tried it between my two computers I have at home and I have the
same problem, both are windows machines by the way.

I have set up passwordless login via ssh and I can ssh no problem via: 
ssh user@site.com

I've been trying to figure this out for two days now, any help would be
appreciated

Thanks,
Aaron
-- 
View this message in context: http://n2.nabble.com/Access-Denied-when-pushing-git-tp2978561p2978561.html
Sent from the git mailing list archive at Nabble.com.
