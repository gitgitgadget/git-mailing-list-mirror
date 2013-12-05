From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Thu, 05 Dec 2013 20:18:49 +0100
Message-ID: <52A0D199.1010403@web.de>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 20:18:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoeRu-00088U-3H
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 20:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab3LETSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 14:18:54 -0500
Received: from mout.web.de ([212.227.15.4]:53721 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab3LETSx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 14:18:53 -0500
Received: from [192.168.178.41] ([84.132.154.249]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0Ljrq1-1VHnXB1T0T-00bu7p for <git@vger.kernel.org>;
 Thu, 05 Dec 2013 20:18:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:2nRGNA4ldhHhbvPX2Lsl12bQB/QpLsYpfK3IpYdQpCckiXgj0Om
 1H9oslZxss8a2DA/YMPuZtZopoHNsq9N0wWOFF3ctgKtItql6RneXnh6KLMyuT2gY8jmpRS
 FrepvHgi+sR6QLAzm1rsiV4r65nquarGUf3rJ4nqIuOtlytT/YxbVQ/36Bgr3lOpLzQtzAn
 YAifRnPP4zc8wMBQe/vtQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238899>

Am 05.12.2013 00:01, schrieb Martin Langhoff:
> Hi folks.
> 
> currently working on a project based on Moodle (the LMS that got me
> into git in the first place). This is a highly modular software, and I
> would like to maintain a bunch of "out of tree" modules in a single
> repository, and be able to publish them in "per-module" repositories.
> 
> So I would like to maintain a tree with looking like
> 
>   auth/foomatic/{code}
>   mod/foomatic/{code}
> 
> where I can develop, branch and tag all the foomatic code together.
> Yet, at release time I want to _also_ publish two repos
> 
>   auth-foomatic.git
>   mod-foomatic.git
> 
> each of them with matching tags and code at the "root" of the git
> tree, and ideally with a truthful history (i.e.: similar to having run
> git filter-branch --subdirectory-filter, but able to update that
> filtered history incrementally).
> 
> Is there a reasonable approach to scripting this?
> 
> Alternatively, has git submodule been improved so that it's usable by
> mere mortals (i.e.: my team), or are there strong alternatives to git
> submodule?

Without knowing more I can't think of a reason why submodules should
not suit your use case (but you'd have to script branching and tagging
yourself until these commands learn to recurse into submodules too).

But maybe you'll be happier with git subtree, dunno.
