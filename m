From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: GIT: ignoring changes in tracked files and bug report
Date: Thu, 04 Dec 2014 22:42:11 +0000
Message-ID: <1417732931.20814.16.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 00:32:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwfsn-0007Ju-Cv
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbaLDXcV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 18:32:21 -0500
Received: from host1.easyho.st ([62.210.60.225]:58883 "EHLO host1.easyho.st"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776AbaLDXcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:32:20 -0500
X-Greylist: delayed 3004 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Dec 2014 18:32:20 EST
Received: from [194.65.5.235] (port=23188 helo=[10.134.132.194])
	by host1.easyho.st with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <sergio@serjux.com>)
	id 1Xwf6C-0021E4-RP
	for git@vger.kernel.org; Thu, 04 Dec 2014 22:42:14 +0000
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host1.easyho.st
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - serjux.com
X-Get-Message-Sender-Via: host1.easyho.st: authenticated_id: sergio@serjux.com
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260837>

Hi, I'm trying find a solution where I can change file in a devel
environment , and not commit it into git .=20

git update-index --assume-unchanged <file>=20

is one solution , not the best solution but one solution.=20

I add 2 files that I want ignore on commits=20

git update-index --assume-unchanged configurations/local.defs
git update-index --assume-unchanged processor/default.defs

git diff -a=20
is clean=20
git diff .
is clean

git commit -a=20
nothing added to commit
but=20
git commit .=20
# Changes to be committed:
#       modified:   configurations/local.defs
#       modified:   processor/default.defs

this is a bug ?=20

Anyway what is best way to deal with some files where we want change
locally and not commit in git .=20
The solution of have one environment variable that says if we are in
devel or in production , and system read the variable and choose the
files to read can't be applied in my case, and is a no solution , is
save a variable outside of source code which I can't.=20


Thanks,
--=20
S=E9rgio M. B.
