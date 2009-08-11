From: "=?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?=" <stepan.nemec@gmail.com>
Subject: [PATCH] Fix typos in git-remote.txt and git-symbolic-ref.txt
Date: Tue, 11 Aug 2009 02:52:07 +0200
Message-ID: <20090811005207.GE24183@headley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 02:50:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MafZk-0007Ti-Du
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 02:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbZHKAun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 20:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbZHKAun
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 20:50:43 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:61830 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZHKAum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 20:50:42 -0400
Received: by fxm28 with SMTP id 28so1247547fxm.17
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 17:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=OxwvbmCsEHkNItYBUHolmOj2Znk01Twiv3YO5uqJk4I=;
        b=k4eBcn7wQIU2aWIsYKzkwZaRSZX3X3lIakjfaMcuk0uw3/zQCZ/9AK8xFlpmuyQ1mf
         0QyF81VF0Rt9oGn3IAFj7Rm958hPoXD9xCT2I6rnwr7ILw2BXDJhVD37xjRPNs1K7/gb
         Y7IT+tBAM/s35ntJak44iuVIOqulYmM1ysxC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=C29pE/O1Z5V8igVjGY+8tANjGqKUhMY8tbq6IUwZLenz3Ifh5SNtCdjLRnBXFsvrSw
         bcUUC9ollWyo0ce92xxeIcrTR/0SHK7YarlKFs7WVnJvQjPm1AnEIeOKaQ/orcz8UH8D
         ooGaWY9zbEFd5/7c6YMKxNh3MjusfFzh6+S2E=
Received: by 10.204.113.208 with SMTP id b16mr5292405bkq.57.1249951842299;
        Mon, 10 Aug 2009 17:50:42 -0700 (PDT)
Received: from localhost (topol.nat.praha12.net [78.102.11.1])
        by mx.google.com with ESMTPS id 1sm7481588fkt.27.2009.08.10.17.50.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 17:50:40 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125504>

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---
I apologize for the previous mail.
Thank you for clarification and guidance.

I did look at some of the other documentation files (and now also grepp=
ed
the whole directory for `--' and `\--' occurences), but wasn't able to =
see
any rule or consistence in the usage. Whether it is an indication of
real inconsistence or just another example of my ignorance I do not kno=
w
(not now, at least).

The stray backslashes were fixed by setting ASCIIDOC8, thanks again.

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec


 Documentation/git-remote.txt       |    4 ++--
 Documentation/git-symbolic-ref.txt |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.tx=
t
index 9e2b4ea..82a3d29 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -114,14 +114,14 @@ These stale branches have already been removed fr=
om the remote repository
 referenced by <name>, but are still locally available in
 "remotes/<name>".
 +
-With `--dry-run` option, report what branches will be pruned, but do n=
o
+With `--dry-run` option, report what branches will be pruned, but do n=
ot
 actually prune them.

 'update'::

 Fetch updates for a named set of remotes in the repository as defined =
by
 remotes.<group>.  If a named group is not specified on the command lin=
e,
-the configuration parameter remotes.default will get used; if
+the configuration parameter remotes.default will be used; if
 remotes.default is not defined, all remotes which do not have the
 configuration parameter remote.<name>.skipDefaultUpdate set to true wi=
ll
 be updated.  (See linkgit:git-config[1]).
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-sym=
bolic-ref.txt
index 210fde0..6392538 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -14,9 +14,9 @@ DESCRIPTION
 Given one argument, reads which branch head the given symbolic
 ref refers to and outputs its path, relative to the `.git/`
 directory.  Typically you would give `HEAD` as the <name>
-argument to see on which branch your working tree is on.
+argument to see which branch your working tree is on.

-Give two arguments, create or update a symbolic ref <name> to
+Given two arguments, creates or updates a symbolic ref <name> to
 point at the given branch <ref>.

 A symbolic ref is a regular file that stores a string that
--
1.6.3.3
