From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/1] Tell vim the textwidth is 75.
Date: Fri, 22 Jul 2005 11:37:05 +0100
Message-ID: <tnx1x5ryvn2.fsf@arm.com>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 12:38:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dvuuz-0003mQ-TX
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 12:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVGVKh6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 06:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVGVKh6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 06:37:58 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:56245 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261812AbVGVKhw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 06:37:52 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6MAaus4013699;
	Fri, 22 Jul 2005 11:36:56 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA11473;
	Fri, 22 Jul 2005 11:37:36 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 22 Jul 2005 11:37:35 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 21 Jul 2005 19:50:20 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Jul 2005 10:37:35.0591 (UTC) FILETIME=[5FAFEF70:01C58EA9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> I do not do Porcelain, but wouldn't it be nicer if we had a
> Porcelain neutral "commit log template file" under $GIT_DIR
> somewhere?  'vim: textwidth=75' is completely useless for
> somebody like me (I almost always work inside Emacs).

StGIT uses .git/patchdescr.tmpl as the template, where people can put
the a line like "STG: vim: textwidth=75" which will be automatically
removed. I won't include this patch since it is up to the user to
define whatever setting he/she wants for his editor (I use emacs
myself and add something like "STG: -*- mode: text; -*-" on the first
line)

> Cogito seems to use $GIT_DIR/commit-template for that purpose.
> Can't users put that "vim:" hint there, and if StGIT does not
> use a commit template, patch it to use the same file as Cogito
> does?

I would use a neutral commit template, only that it should have a
neutral prefix as well for the lines to be removed (neither STG nor CG
but GIT maybe). The $GIT_DIR/commit-template is fine as a file name.

-- 
Catalin
