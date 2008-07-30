From: =?windows-1250?Q?Jurko_Gospodneti=E6?= <jurko.gospodnetic@docte.hr>
Subject: [StGit] stg import documentation incorrect.
Date: Wed, 30 Jul 2008 15:52:33 +0200
Message-ID: <48907221.5030608@docte.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1250;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 15:53:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOC7c-0003w5-2b
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 15:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbYG3Nwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jul 2008 09:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756409AbYG3Nwm
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 09:52:42 -0400
Received: from main.gmane.org ([80.91.229.2]:45709 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771AbYG3Nwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 09:52:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KOC6Z-0007al-Tb
	for git@vger.kernel.org; Wed, 30 Jul 2008 13:52:39 +0000
Received: from 93.159.76.43 ([93.159.76.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 13:52:39 +0000
Received: from jurko.gospodnetic by 93.159.76.43 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 13:52:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 93.159.76.43
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90787>

   Hi.

   StGIT 'stg import' documentation at=20
http://wiki.procode.org/cgi-bin/wiki.cgi/StGIT_Tutorial states that thi=
s=20
command is equivalent to:

> "stg new" followed by "patch -i <file>", then "stg refresh -e"

   However, 'stg refresh' does not accept the -e option (which most=20
likely has something to do with calling an external editor to edit the =
a=20
log message).

   Hope this helps.

   Best regards,
     Jurko Gospodneti=E6
