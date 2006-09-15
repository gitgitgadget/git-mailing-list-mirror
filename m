From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: stgit: cannot push a patch - Python trace dump
Date: Fri, 15 Sep 2006 09:58:48 +0100
Message-ID: <tnxwt855wvr.fsf@arm.com>
References: <450A3524.5040403@intel.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 10:59:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO9XH-0004XS-Ei
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 10:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWIOI64 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 04:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWIOI64
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 04:58:56 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:37864 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750705AbWIOI6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 04:58:55 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k8F8wovs027103;
	Fri, 15 Sep 2006 09:58:50 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 15 Sep 2006 09:58:49 +0100
To: Auke Kok <auke-jan.h.kok@intel.com>
In-Reply-To: <450A3524.5040403@intel.com> (Auke Kok's message of "Thu, 14
 Sep 2006 22:07:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 15 Sep 2006 08:58:49.0973 (UTC) FILETIME=[293D6250:01C6D8A5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27069>

Auke Kok <auke-jan.h.kok@intel.com> wrote:
> I'm preparing patches for upstream and am haunted by an apparent
> patch breaking stg. The problem appears to be one or more of my
> patches breaking a push:
[...]
> I've been abusing stg by leaving the commit messages empty so I
> assume that that's the cause here, or related to the problem.

Thanks, I fixed StGIT to cope with this and I'll update the repository
and snapshot tonight (which, BTW, will contain the initial support for
patch history tracking).

-- 
Catalin
