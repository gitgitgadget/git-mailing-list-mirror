From: David Hanson <drh@drhanson.net>
Subject: importing multi-project svn repositories
Date: Sun, 6 May 2007 11:56:32 -0700
Message-ID: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=WINDOWS-1252;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 20:56:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkluS-0004gJ-DM
	for gcvg-git@gmane.org; Sun, 06 May 2007 20:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbXEFS4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 14:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbXEFS4h
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 14:56:37 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:65021 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbXEFS4g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 14:56:36 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1340862nzf
        for <git@vger.kernel.org>; Sun, 06 May 2007 11:56:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer:sender;
        b=oudelAJL+Lq9ZHkdiiZOlfuwrvFcJ9tGEMjZopPgCFdR//5lhfQ5AbsHl9PtZNRtqfV3JDPOvdtAntjRKq3aCYDt3gJhNKv22MTB16qFc4s71uTSQjiXk5Zf3xtLYMA4HCVLFGcPZBQciy3U8g9V/pEHf9tyCmkC5G42iTUDrz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer:sender;
        b=HQMWmVgxaF51PPuai4Y/dR6RQsVWb38BbRST48hxslxcKXcUixHyM6rfO8ALRfoVpt0PBx1LSchpnua5/vJsUEmZHZozrupEv3HXuW7PqdJkKIUDjM8yzlrJl2wOmeq8Y4EomgQMJa8RTC2euqBvd70I0I+6mn68VK9knTnhWRk=
Received: by 10.64.250.7 with SMTP id x7mr8100009qbh.1178477795716;
        Sun, 06 May 2007 11:56:35 -0700 (PDT)
Received: from ?192.168.0.34? ( [71.231.78.70])
        by mx.google.com with ESMTP id 38sm26136272nzk.2007.05.06.11.56.34;
        Sun, 06 May 2007 11:56:35 -0700 (PDT)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46361>

What's the recommended way to import the full history from an svn =20
repository organized as a group of projects? E.g., as described at =20
http://svnbook.red-bean.com/nightly/en/=20
svn.reposadmin.planning.html#svn.reposadmin.projects.chooselayout:

/
    calc/
       trunk/
       tags/
       branches/
    calendar/
       trunk/
       tags/
       branches/
    spreadsheet/
       trunk/
       tags/
       branches/
    =85

I'd like to import calc at the top level, put calc/tags/foo in git's =20
tags/calc/foo and calc/branches/baz in git's heads/calc/baz. Ditto =20
for calendar, spreadsheet, etc.

I suspect there's a way to use git-svnimport repeatedly with =20
appropriate editing of .git/svn2git.
thanks,
dave h
