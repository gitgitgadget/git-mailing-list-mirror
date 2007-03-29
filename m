From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Help: git-quiltimport error
Date: Thu, 29 Mar 2007 17:48:17 +0100
Message-ID: <tnxlkhgdmi6.fsf@arm.com>
References: <1175014867.15767.13.camel@roc-laptop>
	<euc6ra$qqu$1@sea.gmane.org> <1175053761.15391.7.camel@roc-desktop>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Eric Biederman <ebiederm@lnxi.com>, git@vger.kernel.org
To: bryan.wu@analog.com
X-From: git-owner@vger.kernel.org Thu Mar 29 19:01:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWy02-0005te-SN
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 19:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbXC2RAw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 13:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbXC2RAv
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 13:00:51 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:56261 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030473AbXC2RAv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2007 13:00:51 -0400
X-Greylist: delayed 731 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Mar 2007 13:00:50 EDT
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l2TGmJYo005424;
	Thu, 29 Mar 2007 17:48:19 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 29 Mar 2007 17:48:18 +0100
In-Reply-To: <1175053761.15391.7.camel@roc-desktop> (Bryan Wu's message of
 "Wed, 28 Mar 2007 11:49:21 +0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 29 Mar 2007 16:48:18.0805 (UTC) FILETIME=[0DB94A50:01C77222]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43457>

"Wu, Bryan" <bryan.wu@analog.com> wrote:
> oh, can this fix the bug?
> I am trying to import -mm series patch set to a git tree. Is there any
> git command similar with quilt push/pop? I am trying StGit, but it can't
> recognize the commits from git-quiltimport. Could you give me some
> hints?

You could either import with 'stg import --series' directly or, if you
had already done git-quiltimport, just run 'stg uncommit -n ...'
passing it the number of commits you want transformed in patches.

Note that with a huge series like the -mm one, the git tools like
StGIT (or guilt, but haven't tried it) are much slower compared to
plain quilt.

-- 
Catalin
