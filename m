From: =?windows-1250?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
Subject: Re: Branch renaming not updating the configuration correctly.
Date: Mon, 28 Jul 2008 16:06:27 +0200
Message-ID: <488DD263.8020100@docte.hr>
References: <g6ki09$81c$1@ger.gmane.org> <alpine.DEB.1.00.0807281445340.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 16:08:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNTO5-0007RS-Jf
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 16:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbYG1OGp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 10:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbYG1OGp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 10:06:45 -0400
Received: from main.gmane.org ([80.91.229.2]:41017 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbYG1OGo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 10:06:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNTN1-0004h4-CA
	for git@vger.kernel.org; Mon, 28 Jul 2008 14:06:39 +0000
Received: from 87.252.133.29 ([87.252.133.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 14:06:39 +0000
Received: from jurko.gospodnetic by 87.252.133.29 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 14:06:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.133.29
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <alpine.DEB.1.00.0807281445340.8986@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90461>

   Hi Johannes.

>> -- .git/config: --
>> [branch "aaa"]
>> 	remote =3D .
>> 	merge =3D bbb
>> ------------------
>>
>>   > git branch -m aaa patched
>>   > git branch -m bbb original
>>
>> -- .git/config: --
>> [branch "patched"]
>> 	remote =3D .
>> 	merge =3D bbb
>> ------------------
>>
>> And as you can see above, the branch.patched.merge configuration set=
ting=20
>> did not get updated and still holds the old branch name 'bbb'.
>=20
> I deem this not an "important" bug.

   Just wanted to chip in and report... not comfortable enough yet with=
=20
git from the user side to contribute with much else...


> We usually do not set up tracking information for local branches, and=
 I=20
> still do not know valid common scenarios for that workflow.

   I was playing around with setting up a local branch containing Boost=
=20
library sources as there is no official git repository for that project=
=2E=20
  They hold their main repository under subversion and have currently=20
closed down their main development branch for changes while a new=20
release is being prepared. As I do _hate_ svn branching/merging I=20
thought git should be perfect for the task of tracking my own changes t=
o=20
the project and this whole 'project' would give me a chance to get=20
better acquainted with the tool :-).

   Crossing the SVN/Git boundary however is causing a problem since I=20
use Windows and 'git svn' does not seem to be supported here. My initia=
l=20
idea was to manually update my own personal 'origin/master' branch (svn=
=20
checkout & then manually commit to the my git branch) and then update=20
other branches containing my patches from there. Locally-tracking=20
branches seemed like a perfect fit for that.

   Any other suggested patterns/organizations/solutions I should try ou=
t=20
in this case?


> But hey, if it really bothers you, and you can come up with a=20
> non-intrusive patch (i.e. a patch that does not punish all users that=
 do=20
> _not_ set up locally-tracking branches), I am sure it will be welcome=
d.

   Heh... it'll take a little more time for me to get comfortable enoug=
h=20
with git to attempt something like that. :-) Still an infant user here,=
=20
happy with reporting what I find and hoping I don't miss something too=20
obvious or find & report something already reported. :-)

   Best regards,
     Jurko Gospodneti=E6
