From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/4] git-p4 test cleanup, commit time change
Date: Sat, 30 Jul 2011 20:35:57 -0400
Message-ID: <20110731003557.GA4867@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 02:36:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnK0r-0008G7-3Y
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 02:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab1GaAgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jul 2011 20:36:01 -0400
Received: from honk.padd.com ([74.3.171.149]:45927 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275Ab1GaAgA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2011 20:36:00 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id C88A4223A;
	Sat, 30 Jul 2011 17:35:59 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 233FE31731; Sat, 30 Jul 2011 20:35:57 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178221>

Here's a small patch series to clean up the git-p4 tests a bit,
make them work on a 2-user eval p4d, and to fix a problem with
the timestamp on the import commit.

Luke, if you can take a look and ack these, I'd appreciate
the review since I had to adjust your --preserveUser tests.
And if you're looking at that one, might as well look at them
all.  :)

I'd welcome review from anyone with interest, and will plan
to submit these to Junio in a week or so.

		-- Pete
