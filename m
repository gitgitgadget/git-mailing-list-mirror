Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F9D2E40E
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184687; cv=none; b=C/5wjQ1fC/76NwgZM/ET4CM+rDa4GZM6cp8YMPzRfMeu7unYikDa8iQUQWCNsfaRSmkCfdom9OhUGL6Suu0cn1HSVBHt9KIJEda1TF+4jQi7KmanEkwj5lWZEYv8ORqnMNyZ3WHrtlTw90cAUaSETjr+lR6X9RqfGOC8vU63MHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184687; c=relaxed/simple;
	bh=KZhC/f+p9XUBCroCTjQo9z1TkKDkhoULb6U/tw11pwA=;
	h=Date:From:To:Subject:MIME-Version:Content-Type:Message-ID; b=VEvz747mvdmUnxOCBBzvnIbls51Wt3WS8cBbpMX7ed32ZoCcIAAuj/Zel5AM9tR+d4YpYEW4hJU/W3E6/A7JIf8N2pJEPHWvvOCM9f0zOUbiX3JK0GFPTOtTmB//010A5lX7ZP+bZK81HmOtSRjjJJaQJRai4HQbwGL19oSgXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=NNER5W0T; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="NNER5W0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759184682; x=1759789482;
	i=johannes.schindelin@gmx.de;
	bh=ADHib671EUKL7TanQtoix9e6mkgz0pb0LPbMXML7M98=;
	h=X-UI-Sender-Class:Date:From:To:Subject:MIME-Version:Content-Type:
	 Message-ID:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=NNER5W0TrvqcyUKRrL0sQ93lLBf7WbqbaDed2hxHNopqK6TMdbMjt2CYwOUCD13A
	 vIyVLt+gafg8BFZzJFYFWoNoIbwQ543PHhfvqdPVBOGzWjQDt9ZVREFApGNS5UqfK
	 yNzo2xxoKjePybUNFgqBx7GB5puJsbiQN2Z6tL2MRMuuYArbvBYZa5RPnG7J8qb92
	 rp3CYWc3CSMSXHLcKUMvEycal9ibVVtvNN5zRfsuHHHuTZ+6Mwhr+8gPQTVW0DzJj
	 n1KuVDbHj+juM7eNmM+7yPN9KOXQrrkDVbtj1D9fqBYytjz171PrgHuZ6tHh0+D1K
	 MkDvTT4GQs+58hyKbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.228]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnJhO-1ueEDG1f8O-00nss6; Tue, 30
 Sep 2025 00:24:42 +0200
Date: Tue, 30 Sep 2025 00:24:41 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.51.0(2)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-ID: <1N2mBa-1uKVV81q0a-017bZy@mail.gmx.net>
X-Provags-ID: V03:K1:1rrRCi8Uf1dELMir3MsU+5CNnQ6NLNRd/DLsVmlNx4T4j4Gs3HR
 /O0r6xxpEE4HuVdSdt8nmWd5dXLlk2y2frtfVtbaQNa+yiJQqSn1H60eHkE7os0jM/TbEXG
 XVqdS/rQ3/md+fnnBWWzTG9AZmurdVMMX8ez4f6W1bGrJe0cJz0tT7c8NbFjedbFyiuslH6
 sr8cJGayGWHSNPzlbRbYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lSWbNQDyc2A=;qzZOLT7BX/ScMvOoZSDamwbpQXc
 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

Dear Git users,

I hereby announce that Git for Windows 2.51.0(2) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.51.0 (August 19th 2025)

New Features

  * Comes with PCRE2 v10.46.
  * Comes with cURL v8.16.0. This addresses a bug where fetches/pushes
    could fail with failed to read data from server:
    SEC_E_CONTEXT_EXPIRED (0x80090317) under certain circumstances.
    Also included: a back-port of a fix for a bug where connection
    failures were mistakenly reported as time-outs.
  * Comes with Tig v2.6.0.
  * Comes with MinTTY v3.8.1.
  * Comes with OpenSSL v3.5.3.

Bug Fixes

  * The auto-updater now shows Git for Windows icon in the notification
    also on Windows/ARM64.
  * git clone/git fetch now deals more gracefully with directory / file
    conflicts when the files backend is used for ref storage, by
    failing only the ones that are involved in the conflict while
    allowing others. This is a regression in Git v2.51.0 that was
    reported in Git for Windows and independently also to the Git
    mailing list. This was fixed by merging Git's topic branch kn/
    refs-files-case-insensitive.
  * Support for pathspecs in diff --no-index was somewhat buggy, which
    has been fixed.
  * git sparse-checkout subcommand learned a new clean action to prune
    otherwise unused working-tree files that are outside the areas of
    interest. An earlier version of this had been integrated into
    Microsoft Git already. This was fixed by merging Git's topic branch
    ds/sparse-checkout-clean.
  * git rebase -i failed to clean-up the commit log message when the
    command commits the final one in a chain of "fixup" commands, which
    has been corrected. Backported from Git's topic branch pw/
    rebase-i-cleanup-fix.
  * git subtree did not work correctly when splitting squashed
    subtrees, which has been improved. Backported from Git's topic
    branch cs/subtree-squash-split-fix.
  * Some among git add -p and friends ignored color.diff and/or
    color.ui configuration variables, which is an old regression, which
    has been corrected. This was fixed by merging Git's topic branch jk
    /add-i-color.
  * A corner-case bug in git log -L... has been corrected. This was
    fixed by merging Git's topic branch sg/line-log-boundary-fixes.
  * A broken or malicious git fetch can say that it has the same object
    for many many times, and the upload-pack serving it can exhaust
    memory storing them redundantly, which has been corrected. This was
    fixed by merging Git's topic branch ps/upload-pack-oom-protection.
  * Fixes multiple crashes around midx write-out codepaths. This was
    fixed by merging Git's topic branch ds/midx-write-fixes.
  * git repack --path-walk lost objects in some corner cases, which has
    been corrected. This was fixed by merging Git's topic branch ds/
    path-walk-repack-fix.
  * Under a race against another process that is repacking the
    repository, especially a partially cloned one, git fetch may
    mistakenly think some objects we do have are missing, which has
    been corrected. This was fixed by merging Git's topic branch jk/
    fetch-check-graph-objects-fix.
  * Various options to git diff that makes comparison ignore certain
    aspects of the differences (like "space changes are ignored",
    "differences in lines that match these regular expressions are
    ignored") did not work well with --name-only and friends. This was
    fixed by merging Git's topic branch ly/
    diff-name-only-with-diff-from-content.
  * git diff --no-index run inside a subdirectory under control of a
    Git repository operated at the top of the working tree and stripped
    the prefix from the output, and oddballs like "-" (stdin) did not
    work correctly because of it. Correct the set-up by undoing what
    the set-up sequence did to the current working directory and
    prefix. This was fixed by merging Git's topic branch jc/
    diff-no-index-in-subdir.
  * Various bugs about rename handling in "ort" merge strategy have
    been fixed. This was fixed by merging Git's topic branch en/
    ort-rename-fixes.
  * git push had a code path that led to BUG() but it should have
    reported a regular failure, as it is a response to a usual but
    invalid end-user action to attempt pushing an object that does not
    exist. This was fixed by merging Git's topic branch dl/
    push-missing-object-error.
  * git refs migrate to migrate the reflog entries from a refs backend
    to another had a handful of bugs squashed. This was fixed by
    merging Git's topic branch ps/reflog-migrate-fixes.
  * During interactive rebase, using drop on a merge commit lead to an
    error, which was incorrect. This was fixed by merging Git's topic
    branch js/rebase-i-allow-drop-on-a-merge.

Git-2.51.0.2-64-bit.exe | 5cf583441ccd8d98d3492936235b6ee30c6847d1b3f49365d6a025b3432094ad
Git-2.51.0.2-arm64.exe | ba95adc559e2d91ae28aa354c0ffb06b2c54f2bf42985f278dded9ca31194816
PortableGit-2.51.0.2-64-bit.7z.exe | 85d6e9f865b73827e22d532fd6cd5b93987c8d264142786b0721956619d5c00e
PortableGit-2.51.0.2-arm64.7z.exe | f35e795224349c63b7d6c429c2d8404a6ce7e2e8f91934a3f6ba2ca8e7e285a8
MinGit-2.51.0.2-64-bit.zip | 314fc2b7425ca116ea201e493fcb72008376c64997e866e6c8b8a5b360b3b8a9
MinGit-2.51.0.2-arm64.zip | 4feecfaea2647a2a0b25b7bfa518b9a65eb3434d9be7016e4dd348f07bcc6d2f
MinGit-2.51.0.2-32-bit.zip | 617a1433fbf5e23deaa17b7559d79f465a08fea7e09a0cff32ac0f2216003a8e
MinGit-2.51.0.2-busybox-64-bit.zip | deb7e15ec1e33cad225a6be4401617e21569d188da0a1ca71c29d8018ad087b6
MinGit-2.51.0.2-busybox-32-bit.zip | b2ed51815e858497c2399004a855d5ebb0f8eacd93e0a81a6afc46b5741efda6
Git-2.51.0.2-64-bit.tar.bz2 | 0e4dcabc37f9749fb57b292611a53155842fe52bcbef8e7f56cc80ced65bf3f5
Git-2.51.0.2-arm64.tar.bz2 | a219d91f5f8e707f5e7ff23402af1e7e6421c972896fa3f33edba170439bae90

Ciao,
Johannes
