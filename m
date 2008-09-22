From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 0/1] git-svn: testcase for partial rebuild
Date: Sun, 21 Sep 2008 21:12:34 -0700
Message-ID: <20080922041128.GA23848@untitled>
References: <20080917031304.GA2505@riemann.deskinm.fdns.net> <20080918063754.GA13328@untitled> <20080921024538.GB2505@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 22 06:16:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khcq4-0004re-P3
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 06:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbYIVEMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 00:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbYIVEMg
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 00:12:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40548 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbYIVEMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 00:12:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 8E1892DC01A;
	Sun, 21 Sep 2008 21:12:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080921024538.GB2505@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96447>

Deskin Miller <deskinm@umich.edu> wrote:
> ---
> On Wed, Sep 17, 2008 at 11:38:04PM -0700, Eric Wong wrote:
> > This seems to break the following test case for me:
> > 
> > *** t9107-git-svn-migrate.sh ***
> > *   ok 1: setup old-looking metadata
> > *   ok 2: git-svn-HEAD is a real HEAD
> > *   ok 3: initialize old-style (v0) git svn layout
> > *   ok 4: initialize a multi-repository repo
> > *   ok 5: multi-fetch works on partial urls + paths
> > *   ok 6: migrate --minimize on old inited layout
> > * FAIL 7: .rev_db auto-converted to .rev_map.UUID
> > 
> > I haven't had time to diagnose it.  Also, can you add a test that
> > demonstrates this functionality (and ensures things keeps working when
> > future work is done on git-svn?)
> 
> Thanks for the response; I had a bug in my Perl that my testing hadn't caught.
> Gave me an opportunity to learn how the git testsuites work!
> 
> This testcase fails for me when applied to master, and passes with patch 1/1 in
> the series.

Thanks Deskin, this series is
  Acked-by: Eric Wong <normalperson@yhbt.net>

Junio: I would apply the patch series in reverse order to not break
tests on potential bisections, however.

-- 
Eric Wong
