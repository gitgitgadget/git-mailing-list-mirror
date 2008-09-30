From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] tests: grep portability fixes
Date: Tue, 30 Sep 2008 12:25:19 +0200
Message-ID: <48E1FE8F.8030700@viscovery.net>
References: <20080930080355.GA19605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:26:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkcRN-0005SU-EJ
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 12:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbYI3KZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 06:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYI3KZZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 06:25:25 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12051 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbYI3KZY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 06:25:24 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KkcPw-0007g3-2B; Tue, 30 Sep 2008 12:25:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C74604FB; Tue, 30 Sep 2008 12:25:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080930080355.GA19605@sigill.intra.peff.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97090>

Jeff King schrieb:
> We try to avoid using the "-q" or "-e" options, as they are
> largely useless, as explained in aadbe44f.
> 
> There is one exception for "-e" here, which is in t7701 used
> to produce an "or" of patterns. This can be rewritten as an
> egrep pattern.
> 
> This patch also removes use of "grep -F" in favor of the
> more widely available "fgrep".
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> These are fallouts from getting (most of) the tests to pass
> on Solaris.
> 
>  t/t0002-gitfile.sh                     |    4 ++--
>  t/t1501-worktree.sh                    |    2 +-
>  t/t3700-add.sh                         |    2 +-
>  t/t4150-am.sh                          |    2 +-
>  t/t6040-tracking-info.sh               |    4 ++--
>  t/t7002-grep.sh                        |    2 +-
>  t/t7701-repack-unpack-unreachable.sh   |    4 ++--
>  t/t9500-gitweb-standalone-no-errors.sh |    2 +-
>  8 files changed, 11 insertions(+), 11 deletions(-)

Works here:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at> (MinGW)

-- Hannes
