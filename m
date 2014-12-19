From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote: allow adding remote w same name as alias
Date: Fri, 19 Dec 2014 10:37:51 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412191034560.13845@s15462909.onlinehome-server.info>
References: <20141216021900.50095.24877@random.io> <alpine.DEB.1.00.1412160944180.13845@s15462909.onlinehome-server.info> <CAChhagAFTxmFVvCUiKp3a369awPJtZEuVsfFMcdiqeB9ZwYnKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Anastas Dancha <anapsix@random.io>
X-From: git-owner@vger.kernel.org Fri Dec 19 10:38:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1u0Y-0004PV-32
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 10:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449AbaLSJh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 04:37:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:61029 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbaLSJhy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 04:37:54 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MZ7bs-1YMkFI0j6a-00KxYj;
 Fri, 19 Dec 2014 10:37:52 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CAChhagAFTxmFVvCUiKp3a369awPJtZEuVsfFMcdiqeB9ZwYnKg@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:G8IWZaf+EuqFeLKkLwyo2QhZ7ktOplKWbAdYYfLEaLgwdUtvwRs
 fUrw4QDj8bkSV2Ks3C9dZKt7U+EkSG+ADkHYqkzGHP3w0HSuw+4CNjtn9/0AJfq+04Ll5nb
 aFwyDpMliFtWV1LEC9p5KD2tayxGJQWOAkDfS9GKfmDKvVAxA33JSylsjE/7Cs3WeWjXhCk
 dx96wupIXYeIkhJ+7V50A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261552>

Hi Anastas,

On Tue, 16 Dec 2014, Anastas Dancha wrote:

> Then I wrote "alias", I've meant the following:
> ```
> [url "git@githost.com"]
> insteadOf = myalias
> pushInsteadOf = myalias
> ```
> Unfortunately, your suggested fix will not allow my [poorly] described
> use case.

There is one bit left to clarify: let me guess, you have a $HOME/.gitconfig
like this:

	[url "anastas@company.com"]
		insteadOf = backup
		pushInsteadOf = backup

and then you want to add the "backup" remote in a Git working directory
like this:

	git remote add backup me@my-laptop.local

but my suggested fix will still disallow this because the URL does not
match the url.anastas@company.com.insteadOf?

Ciao,
Johannes
