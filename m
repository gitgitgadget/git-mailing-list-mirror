From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Git and cogito uses different exclude files
Date: Fri, 16 Sep 2005 09:34:19 +0100
Message-ID: <tnxbr2t9zsk.fsf@arm.com>
References: <432A7902.20603@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 10:37:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGBgp-0001qD-F9
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 10:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbVIPIfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 04:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161131AbVIPIfR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 04:35:17 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:12775 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1161130AbVIPIfP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 04:35:15 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j8G8YKSV021273;
	Fri, 16 Sep 2005 09:34:20 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA04520;
	Fri, 16 Sep 2005 09:34:27 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.140]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 16 Sep 2005 09:34:26 +0100
To: Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <432A7902.20603@drzeus.cx> (Pierre Ossman's message of "Fri, 16
 Sep 2005 09:49:22 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 16 Sep 2005 08:34:26.0513 (UTC) FILETIME=[72961C10:01C5BA99]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8672>

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> 'git status' and 'cg-status'/'stg status' uses different locations for
> the exclude files. git expects .git/info/exclude and cogito and stgit
> expects .git/exclude. This is easily solved by a symlink but it could be
> nice if common files have a single correct location. :)

The latest StGIT snapshot uses .git/info/exclude. Probably next week I
will make a new StGIT release.

-- 
Catalin
