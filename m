From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: no diffstat for 'git request-pull' (was Re: [GIT PATCH] char/misc changes for 3.7-rc1)
Date: Mon, 1 Oct 2012 18:03:47 +0000
Message-ID: <201210011803.48211.arnd@arndb.de>
References: <20121001175433.GA10092@kroah.com> <20121001175711.GB10092@kroah.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 01 20:07:19 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1TIkOg-00014p-KW
	for glk-linux-kernel-3@plane.gmane.org; Mon, 01 Oct 2012 20:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab2JASEE (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 1 Oct 2012 14:04:04 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:61070 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab2JASDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Oct 2012 14:03:51 -0400
Received: from klappe2.localnet (HSI-KBW-149-172-5-253.hsi13.kabel-badenwuerttemberg.de [149.172.5.253])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MWtPb-1SulBu1AxH-00Xvow; Mon, 01 Oct 2012 20:03:49 +0200
User-Agent: KMail/1.12.2 (Linux/3.5.0; KDE/4.3.2; x86_64; ; )
In-Reply-To: <20121001175711.GB10092@kroah.com>
X-Provags-ID: V02:K0:j1psAPb6rVcEOsL5AuyAeBxt3M3iQvlwwlQV9PRDIKF
 uf9dFoGkhDgA6dATdKNqE1UbeL3XT5UV9oTukgd3lxfDodXEed
 RJaf0mai9lJKZ7cdkuMvH92FoUWsZ02PDBhqW2lcJyvF11MTS/
 aMkUEXOUH6ONS5crgAot+lw4tI8n6/hIF1fLip/MtLtEGv1Z4R
 abG8VgY5bvM7xaaQqbj3CAtq90aQp9g/ei6jZQf3vVCGbmxeKY
 mYaYKH9xyE/4U2zHtHZsLJwd+q2ISyHRzHMIP4kYBtHLIuvfh9
 9FxJZbq+DRi/jF8U3KKXIFhXxLRjw5sJstPld2fdJcNtX3tIyj
 QuX2bMC2ARrEYVA6IU4I=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206752>

On Monday 01 October 2012, Greg KH wrote:
> Wait, what happened to the diffstat?  Does the latest version of git not
> send out the diffstat for 'git request-pull'?  It used to on older
> versions, I just updated the version on my machine that generated this
> to
>         git version 1.7.12.2.421.g261b511
> 
> Do I have to give a new option to request-pull to have the diffstat show
> up?  I'm using
>         git request-pull master git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ char-misc-3.6
> 
> For this specific request pull.

It looks more like you just sent an empty pull request from v3.6-rc3 to 
v3.6-rc3 (fea7a08acb135).

	Arnd
