From: Sven Helmberger <sven.helmberger@gmx.de>
Subject: Alternative to manual editing with git add --patch
Date: Wed, 14 Oct 2015 17:07:39 +0200
Message-ID: <561E6FBB.7060302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 17:08:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmNef-00068w-Dn
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 17:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718AbbJNPHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 11:07:43 -0400
Received: from mout.gmx.net ([212.227.17.21]:56296 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbbJNPHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 11:07:42 -0400
Received: from [192.168.2.61] ([79.245.214.86]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M4TgW-1aVYB63NIy-00yiKP for <git@vger.kernel.org>;
 Wed, 14 Oct 2015 17:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-Provags-ID: V03:K0:3DNmB/mEDqwgl9SY/xZqdkBQ46pG7XApLMFJ/IWd2PmD0pbfaun
 gHbHIbfpx6NhSmIJQCLpUrQ6IDyoxzd9GjAGrXHcXGXBThXZr4uMuQCde4uID+6cVtd5jND
 lWVhR2BDINKK8U94s+6Q5x2olQKxz+w3M1G8Awes/teQuFuoch6P4NsnUZb7KSr3JIAGfZ1
 9/ojGwvDwdcmMOpfSdWJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UtlCe/ZDNHw=:zn31udPUdsD0bKhgqe+ktn
 PFSjp7Zto/XZC9XrBB6QYXQXDHODkPN4JsKwRhKKDV2eYzKcSEO11jYgTdWNHeWG1S0fJnSgD
 e9MzkfLVAEjMIVk/HfpzgQIQvP5i1iijlmPZ9zS8Eqsa/md0bz/YS5F3SmFnWoDm3o0+3IJDz
 /vXqDEn5pQmSFH22OFA0YPc9G+IQcHoovUyXde+F8P8kIU3swN7wQzpiXu2etxIS/Xg9llQhx
 NTKMxi4S27PvJbAVN4cB+Yi5GBX0KJ5fWFVLOUsQIjfn7JvNDdOa2TaRLQBo5+rCVXcMAjkzh
 JzIbe+FHvKMXF/L6C9xwgBnzZNzkD1XVoX+LkldZCKK7h8REQUZ9ONa+FSYofqZtSX9+bI8aI
 DYvBw9OdYhXEVPyDJ4BHsFEJF6NVFIP/yuFba6qMCGuKWoJkmTbauKtqiwrfLZk2LkxQwvhE2
 t60z/ysX1gZrE+kf8rOBJWqeNEJmZXTQ6Coi/SmkZ48xdBZ/KO8Z7Z99pxuw1B0ZAJOW2O3o6
 +mOkRFqIsjTftzEr726X1ejMzUsx+izDsnqkEziz9yvve6Mw2NX670wppjuuHSqXFaiwxNs9O
 IzJO4w0LXLW7I19r7cEl9MShUGGZB+QO6pBjOHtPptDg/xUSp8rUINEpIybweCz/6udIpqMvc
 7qb5ccrNIHa+xnkngeW7dqln7SxmPwfrUnu3QtfdkDyfmxz7GwEYmT1Fh01lMfOlCg8gBgHQw
 Yq+RgUoWFcvoI29bPAimnUoa9uTy2Cqw7bT1fU8LW4x7BZh4Klbvct8d89/uEQsg+bkBTaRW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279577>

Hello,

I hope this hasn't been discussed before.

I'm a big fan of cleanliness in commits and therefore often use git add
--patch to sort code changes I made into the right commits etc.

What I then often encountered was the situation where I happened to have
inserted consecutive lines of code that conceptually belong to different
commits. Normally I can nicely split patches, but not in this case,
making manually editing the patch the only alternative.

Shouldn't there be at least a way to quickly say line-by-line if you
want to have it added or not?

Personally, I find manually editing just annoying, it seems overly
arcane, but it also prevents me from really recommending "add --patch"
as best practice. I think it's a really good idea for many reasons to do
so, but I can't really tell people already struggling with using git
that I expect them to edit patches manually.

Regards,
Sven Helmberger
