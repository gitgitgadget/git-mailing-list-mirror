From: Toby Allsopp <Toby.Allsopp@navman.co.nz>
Subject: Re: [PATCH 1/2] git-svn: add (failing) test for SVN 1.5+ merge with intervening commit
Date: Mon, 16 Nov 2009 14:15:22 +1300
Message-ID: <87k4xrb785.fsf@navakl084.mitacad.com>
References: <874ooz5o8s.fsf@navakl084.mitacad.com>
	<20091114214031.GA3732@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 02:15:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9qBv-0004rN-JC
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 02:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbZKPBPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 20:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbZKPBPZ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 20:15:25 -0500
Received: from ip-58-28-171-25.wxnz.net ([58.28.171.25]:35428 "EHLO
	AKLEXFE01.mitacad.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751094AbZKPBPY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 20:15:24 -0500
Received: from AKLEXVS01.mitacad.com ([10.112.5.36]) by AKLEXFE01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Nov 2009 14:15:24 +1300
Received: from navakl084.mitacad.com.navman.co.nz ([10.112.8.86]) by AKLEXVS01.mitacad.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Nov 2009 14:15:24 +1300
In-Reply-To: <20091114214031.GA3732@dcvr.yhbt.net> (Eric Wong's message of
	"Sat, 14 Nov 2009 13:40:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-OriginalArrivalTime: 16 Nov 2009 01:15:24.0478 (UTC) FILETIME=[463A0DE0:01CA665A]
X-TM-AS-Product-Ver: SMEX-8.0.0.1181-6.000.1038-17012.003
X-TM-AS-Result: No--17.546700-8.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132978>

[Dropped Junio from CC]

On Sun, Nov 15 2009, Eric Wong wrote:

> Hi Toby,
>
> Thanks for this series, acked and squashed into a single commit to avoid
> unnecessary bisection failures at git://git.bogomips.org/git-svn

Great, thanks.  I have no objection to being squashed, but I'm not sure
what you mean by bisection failures.  Does a test_expect_failure cause
problems for bisection?  It appears to be fairly common to introduce a
failing test case and later fix it, e.g. ce06461 then 751c597.  I'd just
like to understand any potential problems with what I did.

Cheers,
Toby.
