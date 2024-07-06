Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4441BDDB
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720294536; cv=none; b=JWkk11OzKNxlbxOKRBBMz9nY4afcdppfWd7Gr60TAKGOsmy9sUt5bpwcsEbkIz0w+LuEN6QMKoAjLzrvz1ICJT2unzOQsQXwtD1wMd+UkfNEAH1MED9QPeVnm8NYpgR/RzpBECNN2XWbuqyBFeRwfO2Nph+1cT3aDdiBH2Xhdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720294536; c=relaxed/simple;
	bh=95TkF3bpZa32RImuCR9XdtZsWdjL0r9ud8rfnjzjp1o=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=rvh4swoPlugYUuh/LJ/4GfUaf0XOxvIFIBOFb0zFv0KtqMOL7uYLSuPhIlL43GDJFKz9Z8RgDDRJTOtwzSrUrXSaMpYV99Rdm3sxGTYntoZd2jMgoZxdwFa6io1EEPIKhqfKCAc5ayaev4O3sycWK8nF21FvV6a2rFUr+oWELQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=online.ms; spf=pass smtp.mailfrom=online.ms; dkim=pass (2048-bit key) header.d=online.ms header.i=github@online.ms header.b=OMBuHJM1; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=online.ms
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.ms
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.ms header.i=github@online.ms header.b="OMBuHJM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.ms;
	s=s29768273; t=1720294530; x=1720899330; i=github@online.ms;
	bh=95TkF3bpZa32RImuCR9XdtZsWdjL0r9ud8rfnjzjp1o=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Content-Transfer-Encoding:Date:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OMBuHJM1JjdYhv8syfVaFIvaXB8Ds98euqXAgS8kByyBc0rtGQ2PmNHUCC0L+nP4
	 zgrSwO8hcvdxdqxOI974AzIV54gs8kTl2s0u3N1BIUxDGIaGiy5aZfdpniIQr4bxj
	 zqxUQkVZqU4EPrGRcvjhqW8uxGBDuqm+wpcOf+gjwwm2njRvQHlStDaa1vD5lHDS5
	 N1hdt1u4QPO6jTLaKyspUHepfxlNeq6rwvQ4x8L37XyfoStxjwNF8hBCubKZVecGJ
	 yUN+0nzv5BSodX1tl+XvO/efsPEiG4Gm4yf/Fu008O+PLgDm2HOC29B/EilmVjgRr
	 iJO/3+iCV1wrgYszxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.236.14.2] ([10.236.14.2]) by msvc-mesg-web001 (via HTTP);
 Sat, 6 Jul 2024 21:35:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-ea5945a3-0663-4e48-b995-913003b5e932-1720294530422@msvc-mesg-web002>
From: github@online.ms
To: git@vger.kernel.org
Subject: linux git init/clone on Netapp NTFS security style volumes
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
Date: Sat, 6 Jul 2024 21:35:30 +0200
X-Priority: 3
X-Provags-ID: V03:K1:XKTCEeO//h5ko6pYkGnwCAZ1XoahrJs1kpHOVB2iXTW726dx65xZMpKh2dNJ4HDkV50LN
 NS2k6jjT6rXgxGZiLIH/jxJH7Iwh0ZuQyplMY+YV5rJxySFRZOhjB4uIMav5lrILa7+/nJp1/+RO
 KOszv3Vph1ZK8m0Y95YO8R+F4YTcv9xOHzUsOn62vq/jVhIuECByYzxo35yUMLFFdFqGfSKJjPg6
 hwXDC2MzGMH1T/4dukh3VUDqsGXbZ3eL9kTe2s4xYeV3QZ5hUilX7XaQdULf9sE0OlTYxfxIof4K
 7c=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oGU5u0ISWC0=;7SzpTmfk1UO7ZpEKZV6lhBLfyhn
 B+t2xXJHDZPAkQqi17vN+CCkkBZTGm6av8D+5NyfBjAIrBDtBsYyObTc17jIOuGXCq4np/m19
 lG42hovj+PL+PfNj+Y6/ZfudlComBU/WDBrGm1ASuURYKj2Vqb6lTaam9NBokokwme5VBqyoR
 JmN1aoHHuMugvfmuNdi9l63bbjq5fP+gmebSN6poSLi2es+sXVBVQvB9TP4TWEhD1OGZpNgQU
 ckTDL+p/MZs9rU43R+hUayf3A7RE8V8KQNSzWXb83bEOmibJnVOHWpPMBwOE11fTC14l8nVw/
 DUoT9vaYDXVbdmOAJeqKjwd5HA1GhPfCCJmMRMg76cCI33QNY4HOVq37/oZ6kzhzQnkE3vV/e
 0jEzSgzq4qna4qR7+Ci4q4jZU527auIutkdQAFE1pLowM03awYW0/bGT4zC/uF9Dk8s5Pik9c
 jqtpCj0pQb5rIM4qvJTnZtjnIkQSNEAdxsQ+1I5+E2vK9sTWjKVLnLn4416FEmaySjjs7dvkI
 1D8ASjCArzip2DVvb6hvvdMm2GrytcRwQFAfYxbQ+pU0TZNbRcWT21If8CNEEERZjMiYuWagO
 oZ9elIPosr6lSWNT1tcqc8MLQLYjOrRtT8XWc0yDgRZEUIIqg6DfGE82pLqmQ8iOCRvME8Chn
 EN2TDc897dcNUSpgq2zJGs/e3WZ21YgXDLqW1pvvpgw3hSR47nNNNzsHmpHgiTI=

Hello,
=C2=A0
I'm trying to execute git init and git clone operations on a linux client =
that mounts a Netapp volume with NTFS Security Style=2E Meaning the client =
is Linux based but the filesystem is managed from Windows side - especially=
 linux chmod operations are not permitted=2E
=C2=A0
Maybe a new CLI option might be helpful to skip those chmod operations=2E
=C2=A0
=C2=A0
$ git version
git version 2=2E34=2E1
=C2=A0
=C2=A0
ERROR git clone
$ git clone https://github=2Ecom/git/git=2Egit
Cloning into 'git'=2E=2E=2E
error: chmod on /mnt/git-clone-test/git/=2Egit/config=2Elock failed: Opera=
tion not permitted
fatal: could not set 'core=2Efilemode' to 'false'
=C2=A0
$ git config --global --replace-all core=2EfileMode false
=C2=A0
$ git clone https://github=2Ecom/git/git=2Egit
Cloning into 'git'=2E=2E=2E
error: chmod on /mnt/git-clone-test/git/=2Egit/config=2Elock failed: Opera=
tion not permitted
fatal: could not set 'core=2Efilemode' to 'false'
=C2=A0
=C2=A0
ERROR git init
$ git init
hint: Using 'master' as the name for the initial branch=2E This default br=
anch name
hint: is subject to change=2E To configure the initial branch name to use =
in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint:=C2=A0=C2=A0 git config --global init=2EdefaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'=2E The just-created branch can be renamed via this com=
mand:
hint:
hint:=C2=A0=C2=A0 git branch -m <name>
error: chmod on /mnt/git-init-test/=2Egit/config=2Elock failed: Operation =
not permitted
fatal: could not set 'core=2Efilemode' to 'false'
=C2=A0
$ git config --global --replace-all core=2EfileMode false
$ git init
error: chmod on /mnt/git-init-test/=2Egit/config=2Elock failed: Operation =
not permitted
fatal: could not set 'core=2Erepositoryformatversion' to '0'
=C2=A0
$ cat =2Egit/config
[core]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 repositoryformatversion =3D 0
=C2=A0
$ git status
fatal: not a git repository (or any parent up to mount point /data/care)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)=
=2E
=C2=A0
=C2=A0
Thanks&Best
=C2=A0
JH
