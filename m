From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: stgit bisect feature request
Date: Wed, 06 Sep 2006 09:36:20 +0100
Message-ID: <tnxfyf5qtmj.fsf@arm.com>
References: <e7bda7770609051649j56a92085i8d8a73ab12004c43@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 10:36:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKstY-00045z-Qq
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 10:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWIFIgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 04:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWIFIgZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 04:36:25 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:6342 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750727AbWIFIgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 04:36:25 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k868aMvs017352;
	Wed, 6 Sep 2006 09:36:22 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Wed, 6 Sep 2006 09:36:20 +0100
To: "Torgil Svensson" <torgil.svensson@gmail.com>
In-Reply-To: <e7bda7770609051649j56a92085i8d8a73ab12004c43@mail.gmail.com> (Torgil
 Svensson's message of "Wed, 6 Sep 2006 01:49:15 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 06 Sep 2006 08:36:21.0139 (UTC) FILETIME=[878DE630:01C6D18F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26509>

"Torgil Svensson" <torgil.svensson@gmail.com> wrote:
> I think i'd be nice if stgit wraps bisect and you could write
> $ stg bisect start
> $ stg bisect bad
> $ stg bisect good ORIG_HEAD
>
> and after bisect checks out the files it pushes the current stack as
> if you had used stg pull at this point

It would be nice but there could be conflicts when pushing patches,
especially if you do the bisect over a larger range of commits. It
gets difficult if some StGIT patches rely on features not present some
of the commits you are checking.

Have you tried this idea manually (or with some scripts) and found it
feasible?

-- 
Catalin
