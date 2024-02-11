Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2C5A791
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664507; cv=none; b=TIhPDS5h6geyPwHQ/UtZlAmTZfQhKti8v7l1mche9mrPnBeRxDZdEJthNkxLojqF7pPe5rSmHWfohEskJJUIZVFsuJzGY++u5LNher5gxhwqxVy5tYuu4Wh1cPDuwQ8H5N5H53OAHZ3OIfeapEx/rc/WJn7+9JM7IxH0AiYBem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664507; c=relaxed/simple;
	bh=q5V7R/5vWE3mzYn5hTShUNiSVeqvN3XooDG0AwNxpT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjFqvjqqoDDSqK2utQMna89guXHirClwTZkMo/9I8sG7AzPR9YoVDMYEhXwbd7a8BLyOgGa2XFliGIn8KfUSkrc2I/2c02OB4UmM6PkLgFXfLQlpOffsjS8G4UCNw3pThmG9/Qhowuw5TiJTAgJMAzTd6QKEjB6cnGZFvpoXW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=WC9f8IFK; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="WC9f8IFK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707664496; x=1708269296; i=tboegi@web.de;
	bh=q5V7R/5vWE3mzYn5hTShUNiSVeqvN3XooDG0AwNxpT8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=WC9f8IFKx7VSNmi0ccj0g3OMDCA3kXZlBQA9iqk+acdNCcv8YHU0GAmh3W3DBj/8
	 0x+KAwnTak9bQGGbJpyvrwZQE+e/oSWy0tvLuTZntNxi+PkG53DAkR8qn9Rs12eIb
	 0R2Mky5upjMth+W2D/YYWegD5sjTUxlV7WlmHXjnS2DnkJZls/F20kjrZNonbS+TZ
	 CicFiMLgT0fJGFGCcwb/DQ5wkP6sVGI9eN8NspDNu8S6wPIr+KEWfrKNbOLapcjku
	 nDR8L+KFdeELaf9ayGaGVbTkt47UhKFQL1oKq9+zE/g7eRwnf8ibCcO0BfuD/Q8P7
	 4a0D5O6826whp5c0cg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sG3-1qv64d2GJr-018Mfa; Sun, 11
 Feb 2024 16:14:56 +0100
Date: Sun, 11 Feb 2024 16:14:55 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: K_V <zinen2@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git gc changes ownerships of files linux
Message-ID: <20240211151455.GA27103@tb-raspi4>
References: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABkRduQNdgdF8WhZadP5hyYvpEWgP_AE8=qzxNiRNA71bdJcYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:hy16Bs73g7x9gB3PtbObpLrhEVaVil73Mlnqs0ZHzP3b9ZLBZVZ
 WHs2zccq8Ku/APHCcblIuovv8Vz7KRfYNmnm3uBVm2kMAadekpBpcakrK9axr8x0lu02gve
 Ix8t+9Zk3nN5oI/XZuZghr/6Heu0kdKVpJyR11GysW+QIDpgAk0yCx1Rf1QdUMVIBuO+4IF
 thbX2jK+Pdm6JXgXh1Rzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y2LfeR3cBIM=;3WaaIUDoggG1NA9LW5WkDMa9B3o
 rZHCetxl66WUuPGwbX3O3Ugr6KgKG5HrEwUgdfJMYtiGNjkVd2lNBEC6HQtAbNmkKACM8BslP
 OCGcs67Hsq4I1an2ZMMFd56uuSNZJelepgQ2IRC2BWmTEnpwWXs2XT4A2lg4pbdNE2BwRDLFT
 hLMgfQ5aLcrkT5CdgGIaTUQQtnhJiwap7y4LJ5Rx9fjI2F94IC9KkywrKGanXE2jRQzh4sfQ7
 t0YiZA39HPx94U2o3jvketMiWvOUzMiiKoPSToxFZQv1jty8L6QSyz+PVu5beUscePHyY87UC
 xZxREus3fqjSe1fra95LMBSga1kHsCPo30SgxM6tyMK49oda3CSQO0yh/mz1lJNPne4baG4+O
 rgMxA1RxiwA/8u7BfJtyCaC30GCu+Q/T9Ns8viJvm556eWKLh/zCYKwaNzn7Kuu/w+WfiEJoz
 juUPmu44P672bdqZaxKB6LX78YBOD+9cchBjqmapMgA5E3+D9sK8G7sL9YCkTkfsOkyXiIoQc
 rtypQQNwRs97FEOeAB5Xba+yaRjLaY92fz7SlMd4T6V0DHyeQcsFkwWd0wAaDZe+QaMO1sWGM
 Zj9QOwBAlK+38E/bA5Nu18VWW6cHuug1O8IS5xH8k9WN1MZ4kTAKT+4FVvyI/+7GORxfr9MUP
 snCnm4dtOFKapJEbd9Dhn2tduca4BSsUirUwCxQyH7ahccnIVw4BrGtdbFIsPog/yOW7/UBwM
 C12AVPzzYxeKTCgurIorQqcgkSXIb4UDdkhNLfHwQ+2mUJmw60M/q9gwWMy0piH6xMyG0QNVZ
 izESvvZTQLYqv+m3LQr1SYWsYYmTlFwzPgmJiu6G9dUUw=
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 08:52:22PM +0100, K_V wrote:
> Hi team git
>
> Running 'git -C /srv/mssioncontrol/.git gc' on linux from a user which
> has access to another users files will occasionally change the
> ownership of the file 'packed-refs'. I believe git actually overwrites
> the file with a new one at the end af the gc command. But details
> about this is not writen in the help text. Could it be a bug?
>
> Use case: I'm using ansible to cleanup .git directories across
> multible servers and this issue is starting to cause problems.
>
> My solution is to make a variable containing the user and group id
> before running gc command and then reapply it afterwards:
> current_owner_uid_gid=3D$(stat -c "%u:%g" /srv/mssioncontrol/.git)
> git -C /srv/mssioncontrol/.git gc
> chown -R $current_owner_uid_gid "/srv/mssioncontrol/.git"
>
> Details:
> Debian GNU/Linux 12 (bookworm)
> git version 2.39.2

Thanks for reporting this -
I think that you have a working workaround ?

However, Git has a feature called "shared repository".
You need to define a (unix) group that is shared between
your user(s) and the ansible user.

The basic trick is to do
git config core.sharedRepository true

(And then change the ownership of all files/directories to the new group)

There is a docu here, please search for core.sharedRepository
https://git-scm.com/docs/git-config

I wonder, which solution is easier to maintain ?

>
> Best:
> zinen
>
