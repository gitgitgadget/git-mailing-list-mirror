From: Jon Loeliger <jdl@freescale.com>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories ?
Date: Tue, 03 Jan 2006 13:11:58 -0600
Message-ID: <1136315518.11946.28.camel@cashmere.sps.mot.com>
References: <Pine.LNX.4.63.0601012228470.32311@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 03 20:12:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtrZm-00013t-53
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 20:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWACTMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 14:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWACTMB
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 14:12:01 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:10662 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1751406AbWACTMA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2006 14:12:00 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k03JQHPM024594
	for <git@vger.kernel.org>; Tue, 3 Jan 2006 12:26:17 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k03JKP8o012030
	for <git@vger.kernel.org>; Tue, 3 Jan 2006 13:20:25 -0600 (CST)
To: Git List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0601012228470.32311@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14155>

On Sun, 2006-01-01 at 15:32, Johannes Schindelin wrote:
> Preferrable is the following:
> 
> cd /existing/clone/of/ppc-linux # OP said he had this already
> git fetch \
>   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> \
>   master:refs/heads/linus
> git-whatchanged linus..HEAD

Could someone remind me where the <ref>..<ref> syntax
is documented, please?  I went digging, but I am lame
and couldn't find it.

Thanks,
jdl
