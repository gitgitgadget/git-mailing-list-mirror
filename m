From: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
Subject: Silly revert question workflow...
Date: Thu, 06 Mar 2008 03:29:34 -0300
Message-ID: <47CF8F4E.5010809@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 07:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX9cK-0002Fe-Ft
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 07:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937AbYCFG3d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2008 01:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756066AbYCFG3d
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 01:29:33 -0500
Received: from gundagai.terra.com ([66.119.66.236]:53879 "EHLO
	gundagai.terra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbYCFG3d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 01:29:33 -0500
Received: from gulana.terra.com (gulana.terra.com [66.119.66.229])
	by gundagai.terra.com (Postfix) with ESMTP id 58F5A43447
	for <git@vger.kernel.org>; Thu,  6 Mar 2008 01:29:32 -0500 (EST)
Received: from gerogeri.terra.com (gerogeri.terra.com [66.119.66.89])
	by gulana.terra.com (Postfix) with ESMTP id 5AC0610CC1C0
	for <git@vger.kernel.org>; Thu,  6 Mar 2008 01:27:30 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: 9a19b38d60921a3fdbab69db9ef3ed4e
Received-SPF: none (gerogeri.terra.com: 66.119.66.89 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.89; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.59.160])
	(authenticated user ggarra@advancedsl.com.ar)
	by gerogeri.terra.com (Postfix) with ESMTP id AB0622F28D9
	for <git@vger.kernel.org>; Thu,  6 Mar 2008 01:27:29 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76342>


I'm wondering if there's any easy way to basically "fix" the last commi=
t=20
from the history.  To explain a little bit...

Being the silly guy I am, one of the very common things I do is that I=20
may be working on two features simultaneously.
Then one feature is done, I will do a check-in and then seconds later=20
I'll realize that I forgot to add, say, another .h file that was also=20
modified and that I thought was not needed for that commit.
Sure enough, without that .h file the tree as checked in is really in a=
n=20
uncompilable state.

git revert allows me to revert the commit and do it again.  But it stil=
l=20
leaves a commit in the history tree that is uncompilable.

This also happens to me when I am in a different branch doing fixes and=
=20
I need to quickly go to another branch to do changes there (ie. in the=20
same dir, without cloning), so I end up doing a commit in the fix branc=
h=20
of my temporary stuff and then do a co of the stable branch.
I would like to then later go back to the fixing branch and remove that=
=20
temporary commit (or ammend it changing all its history).


--=20
Gonzalo Garramu=F1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
