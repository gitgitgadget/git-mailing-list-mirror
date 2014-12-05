From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 06:12:35 +0000
Message-ID: <1417759955.10992.2.camel@segulix>
References: <1417732931.20814.16.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 07:13:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwm8k-0006C6-RP
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 07:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbaLEGNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 01:13:12 -0500
Received: from host1.easyho.st ([62.210.60.225]:45439 "EHLO host1.easyho.st"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750909AbaLEGNL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 01:13:11 -0500
Received: from bl8-175-54.dsl.telepac.pt ([85.241.175.54]:54577 helo=[192.168.1.67])
	by host1.easyho.st with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <sergio@serjux.com>)
	id 1Xwm84-003yn2-1e
	for git@vger.kernel.org; Fri, 05 Dec 2014 06:12:37 +0000
In-Reply-To: <1417732931.20814.16.camel@segulix>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260857>

Hi,

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

this is a bug .

thanks
--=20
S=E9rgio M. B.
