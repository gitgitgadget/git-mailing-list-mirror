From: Stefan Dotterweich <stefandotterweich@gmx.de>
Subject: Re: [PATCH v2] gitk: Fix missing commits when using -S or -G
Date: Mon, 9 May 2016 07:33:42 +0200
Message-ID: <fea42c3e-a028-3204-690f-88843d31c264@gmx.de>
References: <572C8665.8090707@gmx.de> <572C8B36.2000106@gmx.de>
 <20160509034519.GC12515@fergus.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@ozlabs.org>
X-From: git-owner@vger.kernel.org Mon May 09 07:22:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azdeH-0002YR-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 07:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbcEIFWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 01:22:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:49918 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbcEIFWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 01:22:16 -0400
Received: from [192.168.1.68] ([2.242.217.14]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MfF6I-1bFd2E2Uaw-00OonS; Mon, 09 May 2016 07:22:12
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <20160509034519.GC12515@fergus.ozlabs.ibm.com>
X-Provags-ID: V03:K0:PbW6BQ9K/qbv++zPIYP0odC9tHY45ONKeZzQoRo/hiWGvt+ve1H
 2Y2/siFATwCNQLSHNdYB7IMM2G7HXjcHw35gDtc2L4DSJeJyddSiaswpdUE4k2KIRwXU7nz
 YgYZLxyrkKA8eoeRSZdyx+hTld9NsB/gqj14cS5D13sOMVMhY2+f9IMjKIY7HPYOduk1Fsi
 +gLbR7XTOjD5Rc951RDTA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ie6/Qmt7UHA=:hP+c0VlA0mpEuIYhlDGTFX
 uTCVXQeVzu7rePpboG+VMYPeE+p0680QKQwwJaUOKDmgN7buacyXEKvhcSVCGdR/4N0A2xooF
 YBmNWAgxkHb6SyAkco7+/wPC3ZZd7jf6xZJx8R8BTU9C1i3kuCGXbW+X8VkRwip3w7N77xK+6
 roKnboJqcC/GyOgSEObF8VQC08OXycuRemeVD0qJBba6pIOb7JAFW6ra+N2H5/XDp6aYsxWE6
 bUK4evSheYpNrFrnz7IGp8NmNhe+kN3FEF8YWiSna9JWSHYLjiY11CBUTOpoH66V37UhV5Ep2
 sCy5srmZawzTNea8ejrsF3oyGlqjOtjWRh8MLB7ToZmIwSitZ9BCsrgjLTUZSOvLodupH3wD6
 6casDk+DRICTk0kmMpwMlsl4mjSP66A+QSqnadiAflG8wy7JnI2GLHl9MU89P/LpVnVnf8Jnq
 Id8ttYOkUvAoL0gi5HnMEAX6GseAEaawJDhtIvwhlupdoRSKGcPGEMDQNlVzDX2+oLR99+e6x
 Vo38qnsz0rYY4nF2zkL4pEIwz6Myo5NHuUj7qe3GDljXrRVJlOjj1seK0Nw2iPqDkLi+FDcBz
 6hET2ADCmLirZyp+LFWDRmvuDxrgpNs/7vwgfnNR1mo8kYjS7TV9PzB2m6J/8ByffKJaGIJGZ
 v1LWFVbBKFuBhBf9cUtIJX5Pn3Sd/5bfWAU96HuNqaEY14LBcvMjzDYGgbkJd/m7XWtSzXNtW
 74PvVh4OqtPe+vZuvlEdiK/x4exgfmFUdLGh+Odr5S2Q4+gw1lR2m871rQSzeF5+Pv53OLN9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293983>

> Nice catch; however, we should only update numcommits if the commits
> are for the current view, i.e. if $v == $curview.
>
> Do you want to update the patch?  If you prefer, I can update the
> patch and put a note in the commit message about the issue.

Sure, feel free to update the patch as you see fit.
