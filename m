From: =?windows-1250?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
Subject: git-gui not working in a non-default Cygwin installation.
Date: Sat, 16 Feb 2008 02:48:38 +0100
Message-ID: <fp5fdj$5fi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 02:51:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQCD5-0002pq-Qh
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 02:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758821AbYBPBuQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 20:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbYBPBuP
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 20:50:15 -0500
Received: from main.gmane.org ([80.91.229.2]:50659 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763500AbYBPBuI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 20:50:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JQCBm-0003wB-QH
	for git@vger.kernel.org; Sat, 16 Feb 2008 01:50:02 +0000
Received: from 87.252.132.227 ([87.252.132.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 01:50:02 +0000
Received: from jurko.gospodnetic by 87.252.132.227 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Feb 2008 01:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.132.227
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73999>

   Hi all.

   I am unsure whether this is the right group for asking this question=
=20
and if it is not please excuse me and/or redirect me to a more suitable=
 one.

   We are looking into using git for our source control needs but ran=20
into some problems.

   One of these is that it seems that with the latest git release the=20
git-gui script changed and started hardcoding some absolute paths in it=
=20
during its build (git-gui/Makefile replaces @@GITGUI_SCRIPT@@ with a=20
hardcoded path). However, this causes the prebuilt Cygwin package to no=
t=20
work in case Cygwin is not installed in its default location at=20
C:\Cygwin (e.g. D:\Cygwin or C:\Program Files\Cygwin).

   Everything works fine if you manually edit the git-gui script and=20
change the hard-coded path defined there.

   Is there something I'm missing here? E.g. is there any way for the=20
Cygwin installation to set the correct path here? Or is the user=20
supposed to modify this by hand on every installation? If this is so,=20
then what other such files are expected to be modified?

   Many thanks.

   Best regards,
     Jurko Gospodneti=E6
