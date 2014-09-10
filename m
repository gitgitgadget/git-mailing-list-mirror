From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] Improve tag checking in fsck and with
 transfer.fsckobjects
Date: Wed, 10 Sep 2014 15:58:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409101556070.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 10 15:58:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRiPs-00046z-KD
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 15:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbaIJN6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 09:58:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:61856 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbaIJN6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 09:58:31 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0Lp3Lw-1Xxjqj0AUe-00eqQW;
 Wed, 10 Sep 2014 15:58:29 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:52bhO3khoEOUBV2O0YtWPI12zOlbJgRB0PzQAjqyiCAfIOuXYYa
 587/4ma8uyOT2msT2mfifbUtD31BSCIjetAMghlHiBLsJh9zJ6pA8UFRYLkAbmFRx3UDZ1u
 C9QcVd3he6oZmy0ucwkpLVJFhXNYHi4mmqQhZv9gTfgOG9kKfDpl6vZkKPzT8fy/DSATLmX
 utLpIWD7XSXiNMvbp/VtQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256746>

Hi Junio,

On Wed, 10 Sep 2014, Johannes Schindelin wrote:

> Still unaddressed:
> 
> - getting rid of struct object altogether in fsck (I felt this was quite a big
>   task, getting much more familiar with the non-tag code paths, and I did not
>   want to delay this patch series up any further)
> 
> - ensuring that index-pack passes only NUL-terminated buffers to fsck (again,
>   I am not familiar enough with the code, and IIRC the problematic unit test
>   that revealed that these buffers are not always NUL-terminated exercised the
>   unpack-objects code path, not index-pack, again nothing I wanted to let
>   delay this patch series any further).

To clarify: I am planning to address these issues later this year, but
consider them not critical enough to finish the fsck-tag patch series.

Please let me know if you disagree.

Ciao,
Dscho
