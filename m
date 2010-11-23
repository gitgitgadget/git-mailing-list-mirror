From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: [PATCH] Hint at "checkout -p" in the "reset --patch <type>" error message
Date: Tue, 23 Nov 2010 15:20:58 +0100
Message-ID: <87mxp086k5.fsf_-_@gmail.com>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
	<AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
	<AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com>
	<AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
	<AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
	<AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 15:22:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKtlm-0001z6-IZ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 15:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab0KWOWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 09:22:48 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44023 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab0KWOWs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 09:22:48 -0500
Received: by bwz15 with SMTP id 15so7137478bwz.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 06:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=bYKxpXJW877zm8GL379HHfkPMI7oaNkm0SLM1gYIGe0=;
        b=UtMjCzWWVRw0TeVsyCalsXL+4xeRxI4ZVQ5TBhm3keSFG9rqKrHqVS//GDdzictak3
         iEcSYJFZkkAAyAfxVWkP1uOj8NnI0ZJwGy97emMJF26ZvXybD/CzK3xrsU+dYcx+7zdN
         LUMRr2ilfmFsWJNu8dOFi5BWOJ+L/Ryzi2z8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=jbKpyPENh/JVBZ+BiTeM1T5fknddNaZLiJJp4hNo40r0W9b9EKtdGe2nCxdE9BtctU
         ZF5q7lNk0dXWbU/4V9z3EBmsLp4NEOtBX/dPbw6haqQzgtdgGHn/0BHkqmUJdIthnnKr
         8kCAup1WweyUpkGl6bC5j3UWALnwdGvoypwlk=
Received: by 10.204.46.226 with SMTP id k34mr6656618bkf.38.1290522164966;
        Tue, 23 Nov 2010 06:22:44 -0800 (PST)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id d27sm3121048bkw.2.2010.11.23.06.22.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 06:22:41 -0800 (PST)
In-Reply-To: <AANLkTimEOULR8_PAs5iPu7z+n4DQPSyDKYg8RghZxosz@mail.gmail.com>
	(Jeenu V.'s message of "Tue, 23 Nov 2010 18:30:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161966>

The --patch option to git-reset is not compatible with the type
specifiers (--hard et al.), but some users try that first when what the=
y
really want is "checkout -p" (cf.
<http://permalink.gmane.org/gmane.comp.version-control.git/161955>).

Mention "git checkout -p" in the error message to point users in the
right direction.

Signed-off-by: =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com>
---

Jeenu V <jeenuv@gmail.com> writes:

> On Tue, Nov 23, 2010 at 4:28 PM, knittl <knittl89@googlemail.com> wro=
te:
>> `git reset` seldomly affects the working tree, unless using `--hard`=
,
>> `--merge` or `--keep`, and those switches are potentially dangerous =
if
>> you are not aware of the implications to your worktree and index.
>>
>> without options reset undoes a previous add, i.e. remove changes fro=
m
>> the index, but not the working tree.
>>
>> git reset manpage mentions git-checkout:
>
> Agreed. What I'm saying is most manuals/guides out there tips user to
> use 'git reset --hard' to discard changes in the working directory an=
d
> restore the pristine copy of files. 'reset' then becomes synonymous t=
o
> discard, and it kind of is but for a different reason. Because other
> commands offer -p for selective operations, one might try to discard
> selectively, and end up using 'git reset -p --hard', which obviously
> isn't going to work.
>
> Knowing the users intention in such cases, I was suggesting the error
> message could hint the right command (just like git commit hints user
> to use git-add when one does 'git commit' with a dirty working tree).
>
> But that's just me.

Well, maybe something like the patch below wouldn't hurt?

 builtin/reset.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 0037be4..fc530d2 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -309,7 +309,8 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (patch_mode) {
 		if (reset_type !=3D NONE)
-			die("--patch is incompatible with --{hard,mixed,soft}");
+			die("--patch is incompatible with --{hard,mixed,soft}\n"
+			    "(use \"git checkout -p\" to selectively discard changes in wor=
king directory)");
 		return interactive_reset(rev, argv + i, prefix);
 	}
=20
--=20
1.7.3.rc2.221.gbf93f.dirty
