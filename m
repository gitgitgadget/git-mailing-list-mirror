From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Disable USE_SYMLINK_HEAD by default
Date: Tue, 15 Nov 2005 10:31:46 +0000
Message-ID: <tnxek5i42y5.fsf@arm.com>
References: <1132034390.22207.18.camel@dv>
	<7vveyuqto5.fsf@assigned-by-dhcp.cox.net>
	<1132042427.3512.50.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 11:34:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eby6p-0001Xs-Ly
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 11:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVKOKcM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 05:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVKOKcL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 05:32:11 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:41151 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932332AbVKOKcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 05:32:11 -0500
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id jAFAVQU3025754;
	Tue, 15 Nov 2005 10:31:26 GMT
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id KAA22802;
	Tue, 15 Nov 2005 10:31:48 GMT
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 15 Nov 2005 10:31:47 +0000
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1132042427.3512.50.camel@dv> (Pavel Roskin's message of "Tue,
 15 Nov 2005 03:13:47 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 15 Nov 2005 10:31:47.0862 (UTC) FILETIME=[C857B360:01C5E9CF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11894>

Pavel Roskin <proski@gnu.org> wrote:
> On Mon, 2005-11-14 at 23:03 -0800, Junio C Hamano wrote:
>> The one format is that .git/HEAD can either be a symlink or
>> regular file text symref; both variants are tested -- wouldn't
>> that be good enough?
>
> No.  Even if git itself is tested, other tools are not.  What's worse,
> the developers of those tools don't even know they are supposed to test
> for two HEAD formats unless they track git changes and mailing lists
> very carefully.
>
> In particular, StGIT still needs fixing.

StGIT has been fixed for this in the latest snapshot (but not in the
latest release). It now uses "git-symbolic-ref HEAD" to get the name
of the current branch.

-- 
Catalin
