From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/8] git-p4 fixes and enhancements
Date: Sat, 5 Feb 2011 17:48:48 -0500
Message-ID: <20110205224848.GA30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 23:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlqwC-0004tV-I6
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 23:49:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab1BEWs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 17:48:58 -0500
Received: from honk.padd.com ([74.3.171.149]:45054 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab1BEWs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 17:48:58 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 13A95EF;
	Sat,  5 Feb 2011 14:48:56 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 25AF431ADE; Sat,  5 Feb 2011 17:48:48 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166120>

I've collected a fair number of fixes and enhancements
to git-p4, and finally cleaned them up to send upstream.

      git-p4: test script
      git-p4: fix key error for p4 problem
      git-p4: add missing newline in initial import message
      git-p4: accommodate new move/delete type in p4
      git-p4: reinterpret confusing p4 message
      git-p4: better message for "git-p4 sync" when not cloned
      git-p4: decode p4 wildcard characters
      git-p4: support clone --bare

The first one is interesting in that it adds a test for
git-p4.  I'd appreciate a careful review of this in
particular.

The other seven fix problems and add small features, with
test cases where it makes sense.

		-- Pete
