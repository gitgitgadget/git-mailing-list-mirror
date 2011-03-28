From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git @ be919d50 broken on OSX build
Date: Mon, 28 Mar 2011 10:05:19 -0700
Message-ID: <868vvzi3ao.fsf@red.stonehenge.com>
References: <86lizzi4zv.fsf@red.stonehenge.com>
	<20110328163355.GB18774@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:05:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Fse-0005di-V4
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab1C1RFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 13:05:23 -0400
Received: from lax-gw09.mailroute.net ([199.89.0.109]:42925 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751267Ab1C1RFX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 13:05:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw09.mroute.net (Postfix) with ESMTP id C077313855B;
	Mon, 28 Mar 2011 17:05:20 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw09.mroute.net (Postfix) with ESMTP id D6B2613856A;
	Mon, 28 Mar 2011 17:05:19 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id AEF361B4F; Mon, 28 Mar 2011 10:05:19 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.4.6; tzolkin = 7 Cimi; haab = 19 Cumku
In-Reply-To: <20110328163355.GB18774@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Mar 2011 12:33:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170159>

>>>>> "Jeff" == Jeff King <peff@peff.net> writes:

Jeff> Hmm. That looks like our parallel-build recursive-make heisenbug. If you
Jeff> redo the "make", does it work?

Yes, it did.

Jeff> If not, do you mind bisecting? be919d50 updates the release notes, so it
Jeff> is probably not the cause. :)

I tried that, got stuck, but when I retried the HEAD, it built ok.  Ugh.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
