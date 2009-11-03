From: =?utf-8?B?PT9VVEYtOD9xPz1DNT1BMHQ9QzQ9OUJwPUMzPUExbj0yME49QzQ9OUJt?=
	 =?utf-8?Q?ec=3F=3D?= <stepnem@gmail.com>
Subject: [PATCH] git-update-index.txt: Document the --really-refresh option.
Date: Tue, 3 Nov 2009 21:59:33 +0100
Message-ID: <20091103205932.GA3695@headley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 21:58:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5QSs-0003Dq-VF
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 21:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbZKCU6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 15:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbZKCU6m
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 15:58:42 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:46054 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZKCU6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 15:58:41 -0500
Received: by bwz27 with SMTP id 27so8075502bwz.21
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 12:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=AryqAh0BYRKxpngJqwimTdR5fTIKIkkcWigSIedqTAU=;
        b=jC0GDrjtPVMZEfIS+h24krSt/GjFwdLTUUY1ul+glaVQtzXCmyhEcLGDPnwREx3YC4
         jLrLmnM4KiSZZ0XaHGx6Jrq+lOiGH6YkEqiNmKIrPl1Chal2AYR6TydsMdQYcphFt1kj
         d2I+oDEQPNEW60Gnb9UQqFNKwyIVDd9rtp9OU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=u8sjGAFaZp+IwkaNl8FEFzq25N1muE0c2DDokWmZpcbZUAvw56toSyZ91zkIvX5SqG
         cHDb01rfIYqTB2PNwj6ltlx8k9/xSA/b/QPqnIk0Jg6mM+8Jbd2ldWuTth1rWwk5kQXA
         Vemr3oUjimf7j/wo7I2bliaz+/2QeKXV4W4G8=
Received: by 10.204.34.9 with SMTP id j9mr520092bkd.10.1257281925363;
        Tue, 03 Nov 2009 12:58:45 -0800 (PST)
Received: from localhost ([88.103.132.186])
        by mx.google.com with ESMTPS id 22sm1185415fkr.47.2009.11.03.12.58.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 12:58:44 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131993>


Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
I noticed that --really-refresh is included in SYNOPSIS, but otherwise
undocumented, although mentioned in the text and example.
This is an attempt at fixing that.

 Documentation/git-update-index.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index 25e0bbe..6052484 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -99,6 +99,10 @@ in the index e.g. when merging in a commit;
 thus, in case the assumed-untracked file is changed upstream,
 you will need to handle the situation manually.
=20
+--really-refresh::
+	Like '--refresh', but checks stat information unconditionally,
+	without regard to the "assume unchanged" setting.
+
 -g::
 --again::
 	Runs 'git-update-index' itself on the paths whose index
@@ -308,7 +312,7 @@ Configuration
 -------------
=20
 The command honors `core.filemode` configuration variable.  If
-your repository is on an filesystem whose executable bits are
+your repository is on a filesystem whose executable bits are
 unreliable, this should be set to 'false' (see linkgit:git-config[1]).
 This causes the command to ignore differences in file modes recorded
 in the index and the file mode on the filesystem if they differ only o=
n
--=20
1.6.5.2.74.g610f9.dirty
