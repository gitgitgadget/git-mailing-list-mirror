From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problem with gitk since git-version 2.6, probably a problem with
 language/locale
Date: Tue, 17 Nov 2015 15:23:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511171520300.1686@s15462909.onlinehome-server.info>
References: <loom.20151117T140439-132@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Manuel Neubauer <neubauer@melosgmbh.de>
X-From: git-owner@vger.kernel.org Tue Nov 17 15:43:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyhU5-0001dD-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 15:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbbKQOnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 09:43:45 -0500
Received: from mout-xforward.gmx.net ([82.165.159.41]:62229 "EHLO
	mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbKQOno (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 09:43:44 -0500
X-Greylist: delayed 1203 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2015 09:43:44 EST
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LvPgd-1aORa615r1-010gDU;
 Tue, 17 Nov 2015 15:23:37 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <loom.20151117T140439-132@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:nioOARWyKdlbzdqMIBTX9gJbsd0c57imUH1PhQwjlwLC0HHZUF+
 90Snr8EZrcqPSDbRC0gzirCTOdN38O19PKqjatMLsOWBSkeR7YaYzxnoTirnFumC/1Yn4/c
 bwRpag6MtnUt4MlkzYI8nqwPfeC4OuzhVjS8/+g7O9MqnwLIrHjkW82ZKlHTqrB9Di82DBY
 ZkR382GXgUxGeGJzq17dA==
X-UI-Out-Filterresults: junk:10;V01:K0:TyF878wcYL4=:A/05BfPNnLwefj3rdKZy9Jth
 A4u77iPvcefytqs/nH1L6YRXtMJ6IZ55eHwdLH5YT7q/2B1NDO3r1nLWD0SM7gVd1wGKZ+CHN
 SvXeucARA/uqDqKbLIryx5cP2ol4S50xn8xVxWwFtLfO993SnNZiYmBf/d+tzIkD+OdeAoN33
 8i36Y16ROSNN53KY69b4E7pcEhEhKKwO+WC3YbLVF8RrkDmITOCPGaRKs6moQSZH5ERKLogPT
 0i67jau+PohAkX9488okj+jOMpoyGIDFI9icMtDi+xNGxgJcQQCLEHaOUQ5Hmkrh3w2h6872I
 ZXZzitXAeGa2Qbgc1r81oiUrmyJRRTUKN1HbvuSFkoLjUG5+i6h48pHfqqHoV2LN0DtU9MwVp
 dfHp8tzEJcYfCowcLwQCtsVZKUCLkEPfTMNCfMVkQYX/5MQnihfC0iJBK4KD7EANCnJUjxIAz
 stZ8Fi8EuIqVIXsqFDjiMnSsL0oPZHpQOwyBBZluQFGYeII3NXrRT1MEBzm4V/U59HEtjBtHg
 BHZ879c3x0vo+FgOAzr1/Hpv1BULdNV5FefNAh49IAqW9AXPSo2QeZfjvpHcLKD9HwEyaYgwg
 wKfdUQ1Q+FF28kOFxFBMnoMbKspPmuNTghPS5Y4gxG+AII3AkS8tUrdH8uYssm0B1+MaswZy9
 dSrwu9mbovnC14rb0VHsOyfWjzt5mhtTFYF8LrbmJyJpEiwKLOWIuMrqLlVsPpFJBxU8/CIAh
 BdNmWqtWZBraS2Nh7Q4ovNN69RwJGsIcG6QHiWBsVsPMMGaI+eUU6MYe6ZDEkfHkMt2yWgdV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281409>

Hi Manuel,

On Tue, 17 Nov 2015, Manuel Neubauer wrote:

> since git-version 2.6, I get the following error on all of the machines here
> at work:
> 
> Error in startup script: bad menu entry index "Ansicht bearbeiten ..."
>     while executing
> ".bar.view entryconf [mca "Edit view..."] -state normal"
>     invoked from within
> "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
>     # create a view for the files/dirs specified on the command line
>     se..."
>     (file "/usr/bin/gitk" line 12442)
> 
> I'm using
> - openSuSE 13.2
> - $LANG=de_DE@euro
> - $LC_ALL=de_DE@euro
> - $LC_COLLATE=POSIX
> 
> The problem occurs when I', trying to use "gitk <FILENAME>" oder something
> like "gitk ..origin/<BRANCHNAME>".
> A normal call of "gitk" without any extra arguments works without any problems.
> 
> In git-version 2.5.3 this problem isn't present, it came along with version
> 2.6.x.

Is this not the same issue that was reported here:

http://article.gmane.org/gmane.comp.version-control.git/280095/match=gitk+locale

and here:

http://article.gmane.org/gmane.comp.version-control.git/281105/match=gitk+locale

and fixed here:

http://article.gmane.org/gmane.comp.version-control.git/279910/match=gitk+locale

?

Ciao,
Johannes
