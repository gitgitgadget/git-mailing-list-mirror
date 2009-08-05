From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] tortoisegit 0.9.1.0
Date: Wed, 5 Aug 2009 22:00:39 +0800
Message-ID: <1976ea660908050700u9b16a8ci169825b121f02cb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com,
	tortoisegit-announce@googlegroups.com, tortoisegit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 05 16:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYh2u-0002on-2Z
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 16:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934434AbZHEOAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 10:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934386AbZHEOAk
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 10:00:40 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:45208 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934363AbZHEOAj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 10:00:39 -0400
Received: by qyk34 with SMTP id 34so85732qyk.33
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=uW1TricM9X0NLnMs6aeOLkxYLAYttRJ4e5ZOA2Htkr4=;
        b=x8+OfIJtX/J9nYr7bmXmg5n2LncIBjHSYvJ3VgPqBWgckpFQ+3EVDgVpZdmwmqEQtr
         c4ltibg71Gga+YdASQkw1+wA4UEvJ/8TKyVx2JuvQ1SZ3cGcZBxS8EGWZH6JQdcIhGmo
         xxLOQboTqhuwUQb9btFKwLxJpjdH9T+vG+GC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rqpF9BCNJk05ocNuMGAzV2233NKOpKtNZ6rGNgOzwd4cgUhvzsdeu9edYL4w8kUFHM
         B4nYuWScdlCUzBxCMJYMyH2svfTYIHv4jVmoh1Z/lBbRezlZ9zdkDHQYExG+Us3bvuvV
         KzXdt5pOEsVt3cbRDacxUr4U527oQ/gv6Ye+U=
Received: by 10.224.19.213 with SMTP id c21mr7071494qab.185.1249480839699; 
	Wed, 05 Aug 2009 07:00:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124908>

http://tortoisegit.googlecode.com/files/TortoiseGit-0.9.1.0-64bit.msi
http://tortoisegit.googlecode.com/files/TortoiseGit-0.9.1.0-32bit.msi

=3D Release 0.9.1.0 =3D
=3D=3D Features =3D=3D

=A0* Add Sync Dialog like TortoiseHg.
=A0 Put pull, fetch, push, apply patch and email patch together. You
can Know what change pull and push. Show changed file list.

=A0* Enhance Rebase dialog. Add force rebase checkbox. Disable start
button when no item rebase. Don't show merge commit

=A0* Add post action button for rebase dialog. Such as send patch by em=
ail
=A0 After rebase, you can click button to send patch email directly.

=A0* Add =A0launch rebase option at fetch dialog.

=A0* Improve push dialog.
=A0 Default settings from local repositories pushing to remote
repository Choose track remote and remote branch! Add short-cut at
push dialog
=A0 Add "F5" refresh remote and branch info at push dialog

=A0* Add Clean Untracked version type
=A0 User can choose clean untracked file, clean ignore file, clean all.

=A0* Enhancement: "Git Clone" from SVN repository with additional start
revision number option (-r xxx:HEAD)

=A0* Improve Commit dialog
=A0 Add recent message back to context menu.
=A0 The "Message" field of the Commit dialog should have a shortcut key
(Alt-M is a good choice)
=A0 Make "Whole project" directory checked by default when the user
commits in the root of the project.
=A0 When using "Commit" to also add files, if you forget to check the
new files and press "Ok", you get the dialog "Nothing Commit" and then
the whole Commit dialog closes. Keep the dialog open after this
message.


=A0* Improve setting dialog
=A0 Settings: Git -> Remote: When creating the first remote, the
"Remote" should have "origin" as default.
=A0 Fix setting dialog remote page tab order
=A0 Push: When you press "Manage" under Destinations, the Settings
dialog opening should have "Git -> Remote" selected by default.

=3D=3D Bug Fix =3D=3D
=A0* Fixed issue #124: Incorrect Date header in patch e-mail
=A0* Fixed issue #122: Garbage text in "Git Command Progress" /
suspected buffer overflow Improve commit speed when many added files.
=A0* Fixed issue #121: Refresh in "Check for modifications" dialog
duplicates added state entries when new repository
=A0* Fixed issue #71: (TortoiseProc problem)Icon Overlays don't work in
root of drive When m_CurrentDir =3DC:\, not C:, =A0pathlist calulate
wrong.
=A0* Fixed issue #116: SVN Rebase doesn't work
=A0* Fixed issue #115: Windows XP: Initial "Git Clone..." from SVN
Repository doesn't work
=A0* Fix "ESC" =3D "push" when after commit and Add Alt-P =A0for Push
=A0* Fixed issue #111: Undo Add does not work (keep added file) and
enable "F5" at revert dialog
=A0* Fixed issue #109: clone on bare local repository fails Clear trail
slash \ or/
=A0* Fixed issue #104: Doubleclicking changed submodule dir in Check Fo=
r
Modifications dlg, crashes TGit Fix log dialog double click submodule
problem
