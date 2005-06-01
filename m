From: Pavel Roskin <proski@gnu.org>
Subject: Re: cogito testsuite failure
Date: Wed, 01 Jun 2005 01:34:09 -0400
Message-ID: <1117604049.5755.3.camel@dv>
References: <1117597672.13776.17.camel@dv>
	 <7vzmuasnui.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 07:32:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdLpN-00085v-6n
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 07:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFAFeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 01:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFAFeX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 01:34:23 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:7641 "EHLO
	dv.roinet.com") by vger.kernel.org with ESMTP id S261248AbVFAFeQ
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 01:34:16 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j515YA3Z006049;
	Wed, 1 Jun 2005 01:34:10 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j515YAbM006046;
	Wed, 1 Jun 2005 01:34:10 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmuasnui.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Junio!

On Tue, 2005-05-31 at 21:27 -0700, Junio C Hamano wrote:
> My intention was not to check the actual SHA1 in anything other
> than t0000-basic.sh, but some test in t4000 series were buggy
> and ended up comparing the SHA1.
> 
> I have since corrected them and I believe the test suite in the
> current tip of Linus tree has the corrected compare_diff_raw and
> friends in t/diff-lib.sh, which t4000 series use to avoid this
> problem.  I just hand munged COPYING and README and ran t4008 in
> the Linus tree, and do not see the problem you are reporting.
> 
> Could you verify that your test failure is coming from the
> version that was before t/diff-lib.sh was introduced?  Otherwise
> I have to investigate this further.

The failure in on the "cogito" branch
(rsync://rsync.kernel.org/pub/scm/cogito/cogito.git), which doesn't have
t/diff-lib.sh.

The "git" branch (rsync://www.kernel.org/pub/scm/git/git.git) is fine.
Sorry for the noise.  I should have checked that branch too.

-- 
Regards,
Pavel Roskin

