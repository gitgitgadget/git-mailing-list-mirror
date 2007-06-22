From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Make list of features auto-managed.
Date: Fri, 22 Jun 2007 15:03:24 +0100
Message-ID: <tnxabusqe6r.fsf@arm.com>
References: <20070621045903.GA14047@spearce.org>
	<7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
	<20070621061045.GG8477@spearce.org>
	<7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
	<7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com>
	<7vwsxxwtrh.fsf@assigned-by-dhcp.pobox.com>
	<alpine.LFD.0.99.0706211137020.20596@xanadu.home>
	<7v7ipxw1bq.fsf@assigned-by-dhcp.pobox.com>
	<20070622032502.GA17393@spearce.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 16:04:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1jkS-0006cT-1P
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 16:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494AbXFVOE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 10:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754602AbXFVOE0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 10:04:26 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:33416 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754331AbXFVOE0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2007 10:04:26 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l5ME3Qrc020012;
	Fri, 22 Jun 2007 15:03:26 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 22 Jun 2007 15:03:25 +0100
In-Reply-To: <20070622032502.GA17393@spearce.org> (Shawn O. Pearce's message
 of "Thu, 21 Jun 2007 23:25:02 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Jun 2007 14:03:25.0967 (UTC) FILETIME=[1A3EC1F0:01C7B4D6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50698>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Here's the problem though: `git-blame -w` will be supported
> in Git 1.5.3 and later, we all know this.  But Git doesn't.
> Ask git-describe what version `master` and `next` are; its
> v1.5.2.2-249 and v1.5.2.2-1050.
[...]
> Maybe I should ask the StGIT folks how they deal with this, or if
> they just don't worry about it.  I'm suspecting its the latter...

We don't worry much about it. We actually try to be compatible with
some older versions and not use much of the new features in GIT (StGIT
uses a small subset anyway - see stgit/git.py).

-- 
Catalin
