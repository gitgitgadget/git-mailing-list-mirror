Received: from mail.marc-jano.de (mail.marc-jano.de [116.203.25.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37913E03F
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.25.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027549; cv=none; b=OWAKg0VgKmIQUlTi1yo6ZtUarMl8mi/k78v4gZ9RLSgLFxPX/n04HgadRxE8to0wOv/TAiBfuGRn/yPETv09WW54P9J0kpfF2P2Quc1xQ89IKTsJxGeofES2e4qHVojXeHaPSMgDK/qbYlOgCHUXkDpz2T4r0Ieo4I0pgVLIGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027549; c=relaxed/simple;
	bh=Z1d0VnoXdYjcs8nCpiEYDBeDN4GNFxZfFW2+qF8/ddc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SroXZ/FnkSBRtauSSJFwZbGQdAucSfKKfYmLhwDprNGN8IXJZ9Yl3/rn6nrY8Yy1vHQWqxUD2lrFq39bAOLOKNs8zPbeHj491AhA5AKLkQT7vVm68DOWgP+pZDZ/n3QUOiWkTCbRpuQY3IQ3Rta5NsM0HYBxytAf2i4nfFHm+m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de; spf=pass smtp.mailfrom=marc-jano.de; dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b=iqJkH7wv; arc=none smtp.client-ip=116.203.25.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marc-jano.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marc-jano.de header.i=@marc-jano.de header.b="iqJkH7wv"
Received: from pc1.trash.bin (IP-212232089104.dynamic.medianet-world.de [212.232.89.104])
	by mail.marc-jano.de (Postfix) with ESMTPSA id 019EC7FF53
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 15:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marc-jano.de;
	s=default; t=1718026965;
	bh=Z1d0VnoXdYjcs8nCpiEYDBeDN4GNFxZfFW2+qF8/ddc=;
	h=Date:From:To:Subject:From;
	b=iqJkH7wvz7mcsZq6Gng963wqPn1JY2Q24qWtUrmjm8hLmAzy37ScDd3qzzdQz3h+L
	 rrCS/GbD/qlvdKEgmhdAvP/KQO06OI7uz0jE42OoM0tu8Ub0ROAx2g058ExK5mVmJa
	 1znCKD1l8VL8Fndk6r1gQ4szt42336GFwUXfAqy3YIU6iYarqA9B8k2Nrg7KFYwYcx
	 tk/7VnZ4DE83KnGNpJWWU6OIVTSs08Whx+xfDyILB9HkkidNaCyhlXJzDa+9tZmcn0
	 rL4stTSYMKIgKX4B0gTG8CEqzCnJ/205KDdslTzMeFP7kQqKfWeTMKCB7WRUesiWIB
	 Tv61AtmQs4MAg==
Received: from pcdm2.trash.bin (unknown [192.168.4.89])
	by pc1.trash.bin (Postfix) with SMTP id DFC0C1B0006D
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 15:42:42 +0200 (CEST)
Received: by pcdm2.trash.bin (sSMTP sendmail emulation); Mon, 10 Jun 2024 15:42:42 +0200
Date: Mon, 10 Jun 2024 15:42:42 +0200
From: Marc-Jano Knopp <y--gitbugs@marc-jano.de>
To: git@vger.kernel.org
Subject: [Wishlist Bug] git-shell: Support libreadline
Message-ID: <tovyij5wnnliqqn443n6ksjrnwgs7xthopxvqlieacix7jjdqg@2mnwgzlpj7fo>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all!


I would like git-shell to support libreadline:

  https://tiswww.cwru.edu/php/chet/readline/rltop.html


------------------- snip ---------------------
Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

  Live in peace.

What did you expect to happen? (Expected behavior)

  git-shell letting me edit the input (Emacs/vi/cursor-keys) and
  access the command history.

What happened instead? (Actual behavior)

  git-shell gave me Thompson shell vibes and sent me into foul-mouthed
  screaming tantrums.

What's different between what you expected and what actually happened?

  Expected libreadline support, got sent to labor camp instead.

Anything else you want to add:

  I installed git-shell as the shell for git users on a git server,
  and filled /usr/local/share/git-shell-commands with various shell
  scripts for git repository maintenance on that server. Having
  git-shell support libreadline would much alleviate two common
  scenarios:
  - commands can be very quickly edited / fixed
  - commands that have been executed before can be quickly accessed
    and either re-executed or edited and executed, especially with
    keybindings like

    ,----[ ~/.inputrc ]---
    | "\C-p": history-search-backward
    | "\C-n": history-search-forward
    `----

    where you start typing "foo", then use C-p/n to go thru all commands
    in history that start with "foo". Life saver.

  Please either simply don't limit the command history (via
  "stifle_history()"), or give users the possibility to define a maximum
  of history lines.

  Location of the history probably does not have to be configurable,
  ~/.git-shell-history will do just fine (for me).

  Thanks for considering this wish-list bug. :-}


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.39.2 {wanted to try 2.45.1 before reporting, but got shoved into dependency hell}
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-21-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.90-1 (2024-05-03) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show
------------------- snip ---------------------


MJK (not subscribed, Cc: welcome)
