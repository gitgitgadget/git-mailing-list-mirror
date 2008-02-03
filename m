From: walt <wa1ter@myrealbox.com>
Subject: Re: New behavior for git-branch?
Date: Sun, 03 Feb 2008 06:42:27 -0800
Organization: none
Message-ID: <fo4jr4$7c0$1@ger.gmane.org>
References: <fo27d0$gs7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 15:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLg3D-00024y-QH
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 15:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761117AbYBCOl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 09:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761489AbYBCOl7
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 09:41:59 -0500
Received: from main.gmane.org ([80.91.229.2]:49281 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752939AbYBCOl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 09:41:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLg2Y-0002fd-7j
	for git@vger.kernel.org; Sun, 03 Feb 2008 14:41:50 +0000
Received: from adsl-69-234-187-100.dsl.irvnca.pacbell.net ([69.234.187.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 14:41:50 +0000
Received: from wa1ter by adsl-69-234-187-100.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 14:41:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-187-100.dsl.irvnca.pacbell.net
User-Agent: Thunderbird 3.0a1pre (X11/2008020304)
In-Reply-To: <fo27d0$gs7$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72358>

walt wrote:
> ...
> $git-branch -av
> * master ae9458d Merge git://git.infradead.org/battery-2.6
> origin 8af03e7 Merge branch 'for-2.6.25' of
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> origin/master aa62999 x86: fix bootup crash in native_read_tsc()
>
> In my confusion yesterday, I think I created a new 'origin' which
> has nothing to do with Linus' repository -- but I'm not sure...

I fixed it by copying these new settings from Junio's config:

remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master
