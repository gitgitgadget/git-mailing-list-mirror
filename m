From: Knittl <knittl89@googlemail.com>
Subject: Re: [PATCH] Improvements to `git checkout -h`
Date: Thu, 23 Sep 2010 22:37:31 +0200
Message-ID: <AANLkTinBoofjS=+ropQnHARn+qtzJWh2Nx6n87cud5Di@mail.gmail.com>
References: <AANLkTikra1iE5JpXvvPnNcwE=XEDF6B=ubCteEi77dqX@mail.gmail.com>
 <AANLkTikjqW5R4p90T3pWACPG9vGqd4uRETiE-Wb_BybS@mail.gmail.com> <AANLkTi=LBzJWGuqtqJT1eUtmQqFTj8jixxB=hONTh+mi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OysYX-0001kD-3T
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544Ab0IWUhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 16:37:53 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53623 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263Ab0IWUhw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 16:37:52 -0400
Received: by gyd8 with SMTP id 8so739114gyd.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=imupWEzbfiDBt2+VqkDax1Qz6ASoIIPHiSRnCQ2GSpg=;
        b=XmojxWG7B+QvEUUasA3jpLY/WVNUmQ2QUlZN0eWkkLfODbQJips6KzoRJGFK7DT8tN
         jHjyp+xdCw9KLw30zh38ygeGZRvodPVxq3iOu1l94tmAWRHr7T5W1RfR61u7vwfu8aKe
         942Mq9pKBJbVMBnkA2ieb6gh4GN/PW7hNbGIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NognjDtZ8/4OtyaQmHMaRJYlSetRMVtMe0ZAQY9bnSU/nkv9BSVC6Nnnne9Onbak/F
         6r+RExwrwYpcg4Ww7VsQWBPH//re7/Q1pzCv0VqrwDnJDJ3LBsmbfLRMe7s8yoNHEnLL
         YV+krm5yXVWQYpLryhYa5HKqMs/slMGxFTHCE=
Received: by 10.220.30.143 with SMTP id u15mr1056010vcc.12.1285274271486; Thu,
 23 Sep 2010 13:37:51 -0700 (PDT)
Received: by 10.220.189.200 with HTTP; Thu, 23 Sep 2010 13:37:31 -0700 (PDT)
In-Reply-To: <AANLkTi=LBzJWGuqtqJT1eUtmQqFTj8jixxB=hONTh+mi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156904>

On Thu, Sep 23, 2010 at 10:05 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Sep 23, 2010 at 18:26, Knittl <knittl89@googlemail.com> wrote=
:
>> any thoughts on this one?
>
> Hi and thanks for patching Git, but could you please submit patches a=
s
> detailed in Documentation/SubmittingPatches ?

as i use gmail i thought i'd link to the patch, not to mess up
whitespace (still haven't got it working the correct way)

anyways, here it goes inlined:

-------8<---------

=46rom 15781ca9a67f406ec4d608b2e3eae2b129eb7c06 Mon Sep 17 00:00:00 200=
1
=46rom: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Sun, 19 Sep 2010 14:04:43 +0200
Subject: [PATCH] Improvements to `git checkout -h`

be a little more verbose about what each option does

Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
---
 builtin/checkout.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f2f355a..9240faf 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -691,16 +691,16 @@ int cmd_checkout(int argc, const char **argv,
const char *prefix)
 			   "create and checkout a new branch"),
 		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
 			   "create/reset and checkout a branch"),
-		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "log for new branch"),
-		OPT_SET_INT('t', "track",  &opts.track, "track",
+		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "create reflog for new =
branch"),
+		OPT_SET_INT('t', "track",  &opts.track, "set upstream info for new b=
ranch",
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, "new branch", "new
unparented branch"),
-		OPT_SET_INT('2', "ours", &opts.writeout_stage, "stage",
+		OPT_SET_INT('2', "ours", &opts.writeout_stage, "checkout our
version for unmerged files",
 			    2),
-		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "stage",
+		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "checkout their
version for unmerged files",
 			    3),
-		OPT_BOOLEAN('f', "force", &opts.force, "force"),
-		OPT_BOOLEAN('m', "merge", &opts.merge, "merge"),
+		OPT_BOOLEAN('f', "force", &opts.force, "force checkout (throw away
local modifications)"),
+		OPT_BOOLEAN('m', "merge", &opts.merge, "perform a 3-way merge with
the new branch"),
 		OPT_STRING(0, "conflict", &conflict_style, "style",
 			   "conflict style (merge or diff3)"),
 		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
--=20
1.7.3.235.g952099




--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
