From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Transitively read alternatives
Date: Sun, 07 May 2006 20:28:25 +0200
Organization: At home
Message-ID: <e3le7q$eli$1@sea.gmane.org>
References: <20060507181920.GC23738@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun May 07 20:28:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcnzj-000568-FG
	for gcvg-git@gmane.org; Sun, 07 May 2006 20:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWEGS2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 14:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWEGS2c
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 14:28:32 -0400
Received: from main.gmane.org ([80.91.229.2]:51174 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751226AbWEGS2c (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 14:28:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FcnzQ-000549-Qx
	for git@vger.kernel.org; Sun, 07 May 2006 20:28:20 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 May 2006 20:28:20 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 May 2006 20:28:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19714>

Martin Waitz wrote:

> When adding an alternate object store then add entries from its
> info/alternates files, too.
> Relative entries are only allowed in the current repository.
> Loops and duplicate alternates through multiple repositories are ignored.
> Just to be sure that nothing breaks it is not allow to build deep
> nesting levels using info/alternates.

> +     if (depth > 5) {
> +             error("%s: ignoring alternate object stores, nesting too deep.",
> +                             relative_base);
> +             return;
> +     }

Please, no magic numbers. Use preprocesor "constants" for that.

-- 
Jakub Narebski
Warsaw, Poland
