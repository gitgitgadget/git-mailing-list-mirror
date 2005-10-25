From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: 0.99.9 on Saturday next week.
Date: Tue, 25 Oct 2005 11:06:46 +0100
Message-ID: <tnx64rlrjux.fsf@arm.com>
References: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 12:11:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EULke-0000KP-Gt
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 12:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVJYKJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 06:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVJYKJs
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 06:09:48 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:5551 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932124AbVJYKJs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 06:09:48 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j9PA92SV001514;
	Tue, 25 Oct 2005 11:09:02 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA23102;
	Tue, 25 Oct 2005 11:09:16 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 25 Oct 2005 11:06:46 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvezpetpv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 22 Oct 2005 03:23:08 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 25 Oct 2005 10:06:46.0445 (UTC) FILETIME=[CEC0E5D0:01C5D94B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10580>

Junio C Hamano <junkio@cox.net> wrote:
> I am sure both Pasky and Catalin want to start updating Cogito and
> StGIT to take advantage of what the new core offers, but they cannot
> just randomly use new features only available in the "master" branch
> and expect people to use 0.99.8.GIT version of unknown vintage.

The "master" branch in StGIT uses, in general, the latest features in
the "master" branch of GIT. I have a "stable" one which is restricted
to a specific GIT version (0.99.8 at the moment).

>  - Configuration files (Linus).

Since the configuration files use the .ini like syntax, is it OK for
StGIT to use the same file, with an "[stgit]" section?

-- 
Catalin
