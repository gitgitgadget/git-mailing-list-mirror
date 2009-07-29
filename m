From: "Pickens, James E" <james.e.pickens@intel.com>
Subject: RE: [PATCH 2/2] Demonstrate merge failure when a directory is
 replaced with a symlink.
Date: Wed, 29 Jul 2009 09:39:52 -0700
Message-ID: <3BA20DF9B35F384F8B7395B001EC3FB3424029A4@azsmsx507.amr.corp.intel.com>
References: <1248819198-13921-1-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-2-git-send-email-james.e.pickens@intel.com>
 <1248819198-13921-3-git-send-email-james.e.pickens@intel.com>
 <4A70086C.9070408@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"barvik@broadpark.no" <barvik@broadpark.no>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:41:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWCD8-0007GM-8s
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811AbZG2QkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 12:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755784AbZG2QkF
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:40:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:6592 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575AbZG2QkD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 12:40:03 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 29 Jul 2009 09:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.43,289,1246863600"; 
   d="scan'208";a="536940495"
Received: from azsmsx602.amr.corp.intel.com ([10.2.121.201])
  by orsmga001.jf.intel.com with ESMTP; 29 Jul 2009 09:39:29 -0700
Received: from azsmsx507.amr.corp.intel.com ([10.2.121.87]) by
 azsmsx602.amr.corp.intel.com ([10.2.121.201]) with mapi; Wed, 29 Jul 2009
 09:39:53 -0700
Thread-Topic: [PATCH 2/2] Demonstrate merge failure when a directory is
 replaced with a symlink.
Thread-Index: AcoQJr/HMj+00wxHRPi6wy75u7IcNQAQzdmw
In-Reply-To: <4A70086C.9070408@drmicha.warpmail.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124368>

On Wed, Jul 29, 2009, Michael J Gruber<git@drmicha.warpmail.net> wrote:
> In fact they are identical: Exchange b for b-2 and vice versa everywhere
> and you get the same test, except for the fact that in 1/2 you "test -f"
> in the last step. But I'm sure that test fails at the merge step already
> (because of a dirty worktree), doesn't it? You should see this when
> running the test with -d/-v. (I'm guessing, I haven't run your test.)

<snip>

> As in 1/2, I think the first expect_failure leaves a dirty/unexpected
> worktree (d missing) which causes the merge failure in the last step.

That's true, but this test still fails even after applying Kjetil's patch
that fixes the first problem (so the work tree is clean before 'git merge'
is run).

James
