From: David Greene <dag@cray.com>
Subject: git-subtree
Date: Wed, 04 Jan 2012 09:53:36 -0600
Message-ID: <nngaa638nwf.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 04 17:02:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiTID-00012P-4W
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 17:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151Ab2ADQCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 11:02:16 -0500
Received: from exprod6og110.obsmtp.com ([64.18.1.25]:44984 "EHLO
	exprod6og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127Ab2ADQCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 11:02:15 -0500
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jan 2012 11:02:15 EST
Received: from stplmr01.us.cray.com ([136.162.34.13]) (using TLSv1) by exprod6ob110.postini.com ([64.18.5.12]) with SMTP
	ID DSNKTwR4BiGbGPZ96XN6UYHRtzFqrvtv6/RK@postini.com; Wed, 04 Jan 2012 08:02:15 PST
Received: from transit.us.cray.com (transit.us.cray.com [172.31.17.53])
	by stplmr01.us.cray.com (8.14.3/8.13.8/hubv2-LastChangedRevision: 12441) with ESMTP id q04Frbcp023996
	for <git@vger.kernel.org>; Wed, 4 Jan 2012 09:53:37 -0600
Received: from transit.us.cray.com (localhost [127.0.0.1])
	by transit.us.cray.com (8.14.3/8.13.6/client-5260) with ESMTP id q04Frbxu028464
	for <git@vger.kernel.org>; Wed, 4 Jan 2012 09:53:37 -0600
Received: (from dag@localhost)
	by transit.us.cray.com (8.14.3/8.12.8/Submit) id q04FraBl028463;
	Wed, 4 Jan 2012 09:53:36 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187924>

Hey all,

Avery Pennarun has suckered me into^W^W^Wasked me to submit his
git-subtree tool for inclusion into mainline.  Apparently there was some
discussion about this at GitTogether.

I have a patch ready.  It takes git-subtree from the current GitHub
master, fixes the tests to use the standard git test harness and updates
the build to recognize git-subtree.

How does the git community want the patch presented?  Right now it's one
monolithic thing.  I understand that isn't ideal but I don't think
incorporating the entire GitHub master history is necessarily the best
idea either.

So I'm looking for some guidance.

Thanks!

                            -Dave
