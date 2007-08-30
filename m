From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [StGit] How do I get colored diff output?
Date: Thu, 30 Aug 2007 14:22:46 +0100
Message-ID: <tnx3ay1w40p.fsf@arm.com>
References: <20070830123222.GG5050@xp.machine.xx>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 15:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQjz5-0007Xk-S7
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 15:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbXH3NWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 09:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbXH3NWu
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 09:22:50 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:42594 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751398AbXH3NWt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2007 09:22:49 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l7UDMmbI014956
	for <git@vger.kernel.org>; Thu, 30 Aug 2007 14:22:48 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 30 Aug 2007 14:22:48 +0100
In-Reply-To: <20070830123222.GG5050@xp.machine.xx> (Peter Baumann's message
 of "Thu, 30 Aug 2007 14:32:22 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 30 Aug 2007 13:22:48.0043 (UTC) FILETIME=[DBA1D3B0:01C7EB08]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57042>

Peter Baumann <waste.manager@gmx.de> wrote:
> Is there a way to get colored diff output, preferable from the native
> git diff without having to specify stg diff -O --color everytime?
> It seems that stg doesn't honor color.diff config entry, so I am a
> little lost.
>
> (And yes I now that I could use the pager setting given in examples/gitconfig,
>
> 	stgit.pager = filterdiff --annotate | colordiff | less -FRX
>
>  but I really prefere the native git coloring, which looks a loot nicer
>  and does also highlight traling whitespace)

There isn't any other way at the moment. There were ideas of adding
support for default command line options for various commands but I
haven't looked at this.

I now tried the example stgit.pager option and it looks bad indeed. In
the meantime, there is a diffcol.sh script in the contrib directory, I
use this instead and it looks much nicer.

-- 
Catalin
