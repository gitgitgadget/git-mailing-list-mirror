From: sandy2010 <sandeeptt@yahoo.com>
Subject: "fatal: index-pack failed" error is seen during git clone
Date: Mon, 30 Aug 2010 06:07:49 -0700 (PDT)
Message-ID: <1283173669454-5478121.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 15:07:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq45b-0004tj-FT
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 15:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab0H3NHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 09:07:50 -0400
Received: from kuber.nabble.com ([216.139.236.158]:54750 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab0H3NHt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 09:07:49 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <sandeeptt@yahoo.com>)
	id 1Oq45V-0007RQ-Ep
	for git@vger.kernel.org; Mon, 30 Aug 2010 06:07:49 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154796>


We have a mirror of git repository on Linux. On the build machine
(Linux/Solaris), sometimes the following error is seen during git clone:

fatal: pack is corrupted (SHA1 mismatch)
fatal: index-pack failed

When I manually execute the command, it works fine. But in the nightly
build, I see this error roughly once in 5-6 days. Is this issue related to
openssl package? Before building git-1.7.1, I had set the lib path of
openssl-0.9.8n  in LD_LIBRARY_PATH.

Please help in fixing this issue. Thanks.
-- 
View this message in context: http://git.661346.n2.nabble.com/fatal-index-pack-failed-error-is-seen-during-git-clone-tp5478121p5478121.html
Sent from the git mailing list archive at Nabble.com.
