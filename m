From: =?windows-1250?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
Subject: [StGit] StGit documentation on its configuration file usage.
Date: Mon, 28 Jul 2008 19:01:55 +0200
Message-ID: <g6ku22$mgr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 19:03:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNW7t-0001lh-Hv
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 19:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYG1RCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2008 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbYG1RCK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 13:02:10 -0400
Received: from main.gmane.org ([80.91.229.2]:34082 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758615AbYG1RCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 13:02:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KNW6p-0005HU-2i
	for git@vger.kernel.org; Mon, 28 Jul 2008 17:02:07 +0000
Received: from 87.252.133.29 ([87.252.133.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 17:02:07 +0000
Received: from jurko.gospodnetic by 87.252.133.29 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 17:02:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.133.29
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90475>

   Hi.

   StGIT's project page links to the=20
http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT_Tutorial page for its=20
tutorial information.

   There the 'Configuration file' notes state that StGIT uses=20
/etc/stgitrc, ~/.stgitrc and then .git/stgitrc configuration files in=20
that order and that there is an example configuration file under the=20
examples folder. However, grepping through the StGIT sources I found no=
=20
references to the stgitrc file but only wrappers for using the native=20
GIT configuration system. Also, looking at the examples folder I found=20
only an example that seems to indicate that StGIT's configuration=20
options should be integrated with other regular GIT configuration optio=
ns.

   Did I miss something? Or is this wiki information outdated?

   Testing this I see that StGIT does not read the git configuration=20
correctly on Windows with msysgit anyway, but that's a story for a=20
different thread.

   Best regards,
     Jurko Gospodneti=E6
