From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Mon, 17 Oct 2011 22:05:28 +0200
Message-ID: <20111017200528.GA19054@ecki>
References: <20111014211921.GB16429@sigill.intra.peff.net>
 <1318803076-4229-1-git-send-email-drizzd@aon.at>
 <20111017020103.GA18536@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 22:05:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFtQk-0001UF-Mn
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 22:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691Ab1JQUE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 16:04:57 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:58239 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752461Ab1JQUE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 16:04:57 -0400
Received: from localhost (p5B22F233.dip.t-dialin.net [91.34.242.51])
	by bsmtp.bon.at (Postfix) with ESMTP id 5B7CF1001A;
	Mon, 17 Oct 2011 22:04:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20111017020103.GA18536@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183817>

On Sun, Oct 16, 2011 at 10:01:03PM -0400, Jeff King wrote:
> 
> Thanks, it's nice to have some tests. Overall, some of the tests feel a
> little silly, because the results should be exactly the same as fetching
> or pushing a local repository (so the "set-head" thing, for example,
> really has little to do with git-daemon).

Hmm, yes. Actually, I thought I had found a bug with the failure of
"set-head -a". But now I see that in t5505 this treated like a
feature.

Would it be difficult to support this over the git protocol? Maybe
I will have a look.

Clemens
