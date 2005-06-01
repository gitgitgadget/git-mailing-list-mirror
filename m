From: Junio C Hamano <junkio@cox.net>
Subject: Re: cogito testsuite failure
Date: Tue, 31 May 2005 21:27:49 -0700
Message-ID: <7vzmuasnui.fsf@assigned-by-dhcp.cox.net>
References: <1117597672.13776.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 06:26:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdKmw-0002Uk-Ke
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 06:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFAE1w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 00:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFAE1w
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 00:27:52 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:60642 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261248AbVFAE1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 00:27:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601042750.DKLP1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 00:27:50 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1117597672.13776.17.camel@dv> (Pavel Roskin's message of "Tue,
 31 May 2005 23:47:52 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

My intention was not to check the actual SHA1 in anything other
than t0000-basic.sh, but some test in t4000 series were buggy
and ended up comparing the SHA1.

I have since corrected them and I believe the test suite in the
current tip of Linus tree has the corrected compare_diff_raw and
friends in t/diff-lib.sh, which t4000 series use to avoid this
problem.  I just hand munged COPYING and README and ran t4008 in
the Linus tree, and do not see the problem you are reporting.

Could you verify that your test failure is coming from the
version that was before t/diff-lib.sh was introduced?  Otherwise
I have to investigate this further.


