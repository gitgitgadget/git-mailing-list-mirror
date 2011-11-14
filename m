From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: delete deprecated refs to release disk space
Date: Mon, 14 Nov 2011 18:25:25 +0400
Organization: '
Message-ID: <20111114142525.GB8641@external.screwed.box>
References: <20111113151033.GD16065@external.screwed.box>
 <CACBZZX5kBqM1eye40_Vw0W=8qnNsUQBVCE0q9JrixYomGPuZbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Peter Vereshagin <peter@vereshagin.org>, git@vger.kernel.org
To: ??var Arnfj??r?? Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 15:26:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPxUN-0002z5-6y
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 15:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754484Ab1KNO0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 09:26:13 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:60471 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab1KNO0M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 09:26:12 -0500
Received: from localhost (exit2.ipredator.se [93.182.132.103])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 84D1C5A83;
	Mon, 14 Nov 2011 17:51:26 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <CACBZZX5kBqM1eye40_Vw0W=8qnNsUQBVCE0q9JrixYomGPuZbg@mail.gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185386>

Hello.

2011/11/13 18:01:18 +0100 ??var Arnfj??r?? Bjarmason <avarab@gmail.com> => To Peter Vereshagin :
vArB> What you're looking for is git-filter-branch + the graft facility. I
vArB> can't remember the exact invocation, but you echo the sha1 of the
vArB> commit you want to be the oldest commit to .git/info/grafts, then run
vArB> git-filter-branch.

Seem to work for me ( with 'gc' and 'prune' thereafter ) but with these quirks:
*) the git-filter-branch(1) tells that there must be two ids:

    echo "$commit-id $graft-id" >> .git/info/grafts

This works for me if only one is put there.
*) I'd like to have a command for this. Is this a '--parent-filter' to make
the same thing?

N commits ago is a fine setting for me as it's a cron job backup. Thanks?

--
Peter Vereshagin <peter@vereshagin.org> (http://vereshagin.org) pgp: A0E26627 
