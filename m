From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.4
Date: Tue, 12 Jul 2005 14:14:44 +0100
Message-ID: <tnxfyukjhdn.fsf@arm.com>
References: <1120899939.7125.4.camel@localhost.localdomain>
	<42D3A415.5000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 15:16:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsKcG-0005DN-Fe
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 15:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVGLNPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 09:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVGLNPi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 09:15:38 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:51654 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261412AbVGLNPP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 09:15:15 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6CDEbs4000740;
	Tue, 12 Jul 2005 14:14:37 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id OAA12582;
	Tue, 12 Jul 2005 14:15:11 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 12 Jul 2005 14:15:10 +0100
To: Bryan Larsen <bryan.larsen@gmail.com>
In-Reply-To: <42D3A415.5000709@gmail.com> (Bryan Larsen's message of "Tue,
 12 Jul 2005 07:05:57 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 12 Jul 2005 13:15:10.0028 (UTC) FILETIME=[BAD708C0:01C586E3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Bryan Larsen <bryan.larsen@gmail.com> wrote:
> import: the complement to export

It is written in the TODO file but didn't have time to do it. I'm
working on moving all the commands from main.py into separate files
under stgit/commands/ for a clearer view. This should be ready in the
next day or two and, after that, I will work on other commands.

> template files for the "series" output of export, to put it into a
> format that "sendpatchset" understands.

I thought about integrating sendpatchset into stgit but it is much
simpler to just generate a control file (especially if you want to
review what you're going to send). Is the subject line always the
first line of the patch description?

-- 
Catalin
