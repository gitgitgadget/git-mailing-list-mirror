From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Patch (apply) vs. Pull
Date: Thu, 23 Jun 2005 13:10:40 +0100
Message-ID: <tnxr7et9su7.fsf@arm.com>
References: <Pine.LNX.4.58.0506222059150.11175@ppc970.osdl.org>
	<Pine.LNX.4.21.0506230025420.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 14:06:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlQTe-0003q0-DV
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 14:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVFWMMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 08:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVFWMMp
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 08:12:45 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:63120 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262280AbVFWMMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 08:12:43 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5NCBD6i011535;
	Thu, 23 Jun 2005 13:11:13 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id NAA03366;
	Thu, 23 Jun 2005 13:11:40 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 23 Jun 2005 13:10:55 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506230025420.30848-100000@iabervon.org> (Daniel
 Barkalow's message of "Thu, 23 Jun 2005 01:15:52 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 23 Jun 2005 12:10:55.0885 (UTC) FILETIME=[9BBE3BD0:01C577EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel Barkalow <barkalow@iabervon.org> wrote:
> I think that you'll get better results out of "merge with top" + "commit
> with old commit info, but not listing old commit as a parent". At least,
> that's what StGIT is doing, IIRC, and using merge instead of patch seems
> like it'll make the remaining 1% a lot more pleasant.

Actually StGIT still lists the old commit as the 2nd parent since I
want to implement a log command which can also show only the commits
against a single patch. If this 2nd parent would not be stored,
pushing a patch onto the stack when its base was changed would reset
all the history for that patch.

Of course, there are other ways of doing this like storing all the
commit ids in a file but I found this to be the simplest.

-- 
Catalin

