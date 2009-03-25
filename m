From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Reference for git.git release process
Date: Wed, 25 Mar 2009 14:32:31 -0400
Message-ID: <49CA78BF.2020101@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 19:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmY2y-0002Ac-7Y
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbZCYSjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZCYSjW
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:39:22 -0400
Received: from smtp120.rog.mail.re2.yahoo.com ([68.142.224.75]:20675 "HELO
	smtp120.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753600AbZCYSjV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 14:39:21 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2009 14:39:20 EDT
Received: (qmail 20422 invoked from network); 25 Mar 2009 18:32:39 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp120.rog.mail.re2.yahoo.com with SMTP; 25 Mar 2009 18:32:39 -0000
X-YMail-OSG: QSdAQokVM1nzy7XrCahT2Wpx0IDjCh2dXFXoweq1NMeQvIM.RD2s6q9K8J_4ovBoPw--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id A982821C051A
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 14:32:38 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sUyyRH1b2zu8 for <git@vger.kernel.org>;
	Wed, 25 Mar 2009 14:32:31 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 98C0221C051B
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 14:32:31 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114643>

Hi I'm relatively new to git and I've been reading the git.git notes
about how git itself is maintained, as I'm interested in using a
similar workflow. I've read the MaintNotes document, the
howto/maintain-git.txt addendum, and Documentation/gitworkflows.txt.

I believe I understand reasonably well the concepts presented in those
three documents. However, those documents have a lot of detail about
the development process, but not much about the release process.


One question about the dev process:

1) I don't see any topic branches available in git.git. Are these
generally kept in a private repo and/or shared between individual
developer's public repositories?


Some questions about the release process:

1) After a release is made (master is tagged with vX.Y.Z), is the
maint branch deleted and recreated from the new release tag? e.g.

git branch -d maint
git branch maint master

2) MaintNotes states:

"After a feature release is made from "master", however, "next" will
be rebuilt from the tip of "master" using the surviving topics"

Does this mean:

git branch -d next
git checkout -b next master
git merge ai/topic1_to_cook_in_next
git merge ai/topic2_to_cook_in_next
...

Lastly, I note that the gitk --all representation of a repository
maintained in this way is very difficult to follow (at least for me)
because of all the merging. Are there some canned gitk invocations
that can be used to make the visualization of the integration and
topic branches more intuitive?

Thank you all very much for an excellent tool.

Cheers,
Raman
