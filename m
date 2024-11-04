Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF6718CC0C
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748267; cv=pass; b=IK/6hc2UTIBGqMuI2z3ANEudceAzHFJa4aNB83cjL4kKuhtUYHRbKn4bYhyvBaj0FR1eUBPoGfd+0IMu53HtOC8Snmsv1m4nCjlh7pHDeXCUpIuj4r3MOd4evmHm5LSIBxujbv3VTdAAlbU3XkcFxdmqHdzIk+V1GtIjNVIamEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748267; c=relaxed/simple;
	bh=R46NRWLvYXTr+A+k9XJrrmP+qIDc4inog8o8qOd4eOQ=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=Sr4QbA3Z8We4vU6ttY7QYg5Z0cYQOKu08ExvW9OApqDtLVv69G/zz/a9DfSxRaF8Sd/RNb/r9/yKVyzA3QTfGT8MHvhrYFgnIy7WSJEVKt3C8bDD5eDXamKKr7Cs2dm7wqkznr9U4LBNhPCTW+PmAq7yYa7I4REbHOaTPqLEn8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org; spf=pass smtp.mailfrom=scientia.org; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scientia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 478B090460A
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:24:18 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (trex-5.trex.outbound.svc.cluster.local [100.107.241.166])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id 865A4905523
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:24:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1730748257; a=rsa-sha256;
	cv=none;
	b=zQinaAroAwOxWWIJLC8Y+qLafSCj+WXp5QZ18kO2GPVMZgUud8xaRjSYjo7jXTJ7XWsBBQ
	c18x8hB4iKSJJ39C81k5FbPxmoD5PUxnIj7Oy4cdbkcG4O1cF+u8f0zRiBMhgcuuJzBcG6
	g0HPW33bnHT0Y/P7/ebTSK5eLEto6gnLHb4wtwI+rk2eZEFWQJfX5ipkLIH38gNEY4E1WM
	65FeIYjTtSUrsGOKmici0QEwT64/FqbQf/HHglWWUnHaRR9hdz268aosotoSF8DLZ8+xeT
	CRJSk4c+rPRvJy3MJ+NL5xXYA3/xkeGtX6xDYZh+rfH/xq8VBhKNZ6JW0hU6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1730748257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0QjPndBVzFVyI2K3LHtI8OomI5u91zMXMrlpWtLtzxY=;
	b=zlBsq0BuNntUXYXitZ3XVQUg93YBMacW28ayZ/GzD354Q8ZCvLBTeLNtFg82dMsVi2huVE
	HxQtC1B79b390iu0rabu4rBk0tblx6YxMbUAnejGpLgew9o54Q8xB1OdttNyJSZKu+phA+
	lXU3tK1FC2R4I8FcKLAhNvAkIveRsr3ja4wZpbjNlnOlIJ2JGdixy3r4iE7/inUq/5iS2h
	uLIW8RV1Z7T8x1d8NhmjIbKV5//rbqkTHaI4TSBg5uw2ha3Rdwj3MwoGIA6DqGJIaknIVS
	Azqnmjf7OLBwKyH5NBwNEINCSTopTOhVQpczXEoGrPsj4H3l7OrlIFiEJ1WdbQ==
ARC-Authentication-Results: i=1;
	rspamd-78f87fbb6-9hvhs;
	auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Blushing-Trail: 1bbf2da31cb2ea2c_1730748258037_2806029123
X-MC-Loop-Signature: 1730748258037:1082806759
X-MC-Ingress-Time: 1730748258037
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.107.241.166 (trex/7.0.2);
	Mon, 04 Nov 2024 19:24:18 +0000
Received: from p5b0ed864.dip0.t-ipconnect.de ([91.14.216.100]:60482 helo=heisenberg.fritz.box)
	by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <calestyo@scientia.org>)
	id 1t82gR-000000045Ul-3EMb
	for git@vger.kernel.org;
	Mon, 04 Nov 2024 19:24:15 +0000
Message-ID: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
Subject: git format-patch escaping issues in the patch format
From: Christoph Anton Mitterer <calestyo@scientia.org>
To: git@vger.kernel.org
Date: Mon, 04 Nov 2024 20:24:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org

Hey there.

For some special use case, I wanted to write a parser for the patch
format created by git format-patch, especially where I can separate
headers, commit message and the actual unified diffs.

There seems unfortunately only little (written) definition of that
format, git-format-patch(1) merely says it's in UNIX mailbox format
(which itself is, AFAIK, not really formally defined).


Anyway, it seems to turn out, that no escaping is done for the commit
message in the patch format and that this can cause actual breakage
with valid commit messages.

Consider the following example:
1. I create a fresh repo, add a test file and use a commit message,
   which contains a From line (even with the "magic" timestamp) and
   some made up commit id (0000...)

   ~/test$ git init foo; cd foo
   Initialized empty Git repository in /home/calestyo/test/foo/.git/
   ~/test/foo$ echo a >f; git add f
   ~/test/foo$ git commit -m "msg1
  =20
   From 0000000000000000000000000000000061603705 Mon Sep 17 00:00:00 2001
   --
   ---"
   [master (root-commit) c08debc] msg1
    1 file changed, 1 insertion(+)
    create mode 100644 f
  =20
  =20
2. The format-patch for that looks already suspicious:
   - The From line is not escaped (as some variants of mbox would do,
     some properly some, causing corruption by the escaping with >
     itself).
   - What the format may think of as a separator after the commit
     message (namely the ---) cannot be used as that either, as a ---
     in the commit message is again not escaped.
  =20
   ~/test/foo$ git format-patch --root; cat 0001-msg1.patch; rm -f 0001-msg=
1.patch
   0001-msg1.patch
   From c08debcc502c78786ec71d50686ff0445a13b654 Mon Sep 17 00:00:00 2001
   From: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
   Date: Mon, 4 Nov 2024 19:58:45 +0100
   Subject: [PATCH] msg1
  =20
   From 0000000000000000000000000000000061603705 Mon Sep 17 00:00:00 2001
   --
   ---
   ---
    f | 1 +
    1 file changed, 1 insertion(+)
    create mode 100644 f
  =20
   diff --git a/f b/f
   new file mode 100644
   index 0000000..7898192
   --- /dev/null
   +++ b/f
   @@ -0,0 +1 @@
   +a
   --=20
   2.45.2
  =20
  =20
3. Adding a 2nd commit, this time using the unified diff from the above
   patch as commit message body(!).
  =20
   ~/test/foo$ echo b >>f; git add f
   ~/test/foo$ git commit -m "msg2
  =20
   diff --git a/f b/f
   new file mode 100644
   index 0000000..7898192
   --- /dev/null
   +++ b/f
   @@ -0,0 +1 @@
   +a
   --=20
   2.45.2"
   [master 6bbe38c] msg2
    1 file changed, 1 insertion(+)
   ~/test/foo$ git format-patch --root
   0001-msg1.patch
   0002-msg2.patch
  =20
  =20
4. To no surprise, git itself of course knows the difference between
   commit message and actual patch, as show e.g. by the following,
   where the commit message is indented (by git):

   $ git log --patch | cat
   commit 6bbe38c33680239ac9767e0e5095f9f32ad41ade
   Author: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
   Date:   Mon Nov 4 20:00:20 2024 +0100
  =20
       msg2
      =20
       diff --git a/f b/f
       new file mode 100644
       index 0000000..7898192
       --- /dev/null
       +++ b/f
       @@ -0,0 +1 @@
       +a
       --
       2.45.2
  =20
   diff --git a/f b/f
   index 7898192..422c2b7 100644
   --- a/f
   +++ b/f
   @@ -1 +1,2 @@
    a
   +b
  =20
   commit c08debcc502c78786ec71d50686ff0445a13b654
   Author: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
   Date:   Mon Nov 4 19:58:45 2024 +0100
  =20
       msg1
      =20
       From 0000000000000000000000000000000061603705 Mon Sep 17 00:00:00 20=
01
       --
       ---
  =20
   diff --git a/f b/f
   new file mode 100644
   index 0000000..7898192
   --- /dev/null
   +++ b/f
   @@ -0,0 +1 @@
   +a
  =20

5. Next I try whether git am can use the patches created above in a
   fresh repo:
  =20
   ~/test/foo$ cd ..; git init bar; cd bar
   Initialized empty Git repository in /home/calestyo/test/bar/.git/
   ~/test/bar$ git am ../foo/0001-msg1.patch
   Patch is empty.
   hint: When you have resolved this problem, run "git am --continue".
   hint: If you prefer to skip this patch, run "git am --skip" instead.
   hint: To record the empty patch as an empty commit, run "git am --allow-=
empty".
   hint: To restore the original branch and stop patching, run "git am --ab=
ort".
   hint: Disable this message with "git config advice.mergeConflict false"
  =20
   That already fails for the first patch, the reason probably being my
      From 0000...
   line in the commit message.
  =20
  =20
6. So trying again with simply that From 000.. line removed
  =20
   ~/test/bar$ sed -i '/^From 00000/d' ../foo/0001-msg1.patch
   ~/test/bar$ git am ../foo/0001-msg1.patch
   fatal: previous rebase directory .git/rebase-apply still exists but mbox=
 given.
  =20
   and again on a freshly created repo:
  =20
   ~/test/bar$ cd ..; rm -rf bar; git init bar; cd bar
   Initialized empty Git repository in /home/calestyo/test/bar/.git/
   ~/test/bar$ git am ../foo/0001-msg1.patch
   Applying: msg1
   applying to an empty history
  =20
   Ah, now it works, so it was indeed the (unusual but still valid commit m=
essage).
  =20
  =20
7. Now that 0001-msg1.patch is applied, let's try the 2nd patch:
  =20
   ~/test/bar$ git am ../foo/0002-msg2.patch
   Applying: msg2
   error: f: already exists in index
   Patch failed at 0001 msg2
   hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
   hint: When you have resolved this problem, run "git am --continue".
   hint: If you prefer to skip this patch, run "git am --skip" instead.
   hint: To restore the original branch and stop patching, run "git am --ab=
ort".
   hint: Disable this message with "git config advice.mergeConflict false"
   ~/test/bar$=20
  =20
   And again, ... the reason most likely git not being able to get that
   the "first diff" is not actually a diff but part of the commit message.
  =20

btw and shamelessly off-topic question:
Any chance that git format-patch / am will ever support keeping track
of the branch/merge history of generated / applied patches?
That would be really neat.


Thanks,
Chris.

PS: Not subscribed, so please keep me CCed in case you want me to read
    any possible replies :-)
