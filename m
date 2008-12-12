From: Lars Noschinski <lars@public.noschinski.de>
Subject: diff -b / -w and empty diffs
Date: Fri, 12 Dec 2008 18:57:36 +0100
Message-ID: <20081212175736.GA20046@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 19:04:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBCNM-000264-41
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 19:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266AbYLLSDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 13:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758182AbYLLSDN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 13:03:13 -0500
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:56523 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757133AbYLLSDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 13:03:12 -0500
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Dec 2008 13:03:12 EST
Received: from [134.61.43.48] (helo=vertikal.home.noschinski.de)
	by smtprelay08.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars@public.noschinski.de>)
	id 1LBCGf-0007mc-0r
	for git@vger.kernel.org; Fri, 12 Dec 2008 18:57:37 +0100
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars@public.noschinski.de>)
	id 1LBCGe-0005GY-AQ
	for git@vger.kernel.org; Fri, 12 Dec 2008 18:57:36 +0100
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102920>

Hello!

If the difference between two files is only whitespace, "git diff -b"
leads to diffs just consisting of the "diff" and "index" lines. I would
like an option to suppress those files in the diff output because it
breaks "git diff -b > patch; git apply patch" workflows (and often I'm
just interested in "real" changes).

Is there any reason why such behaviour is not implemented yet (besides
the fact that nobody cared to do it)?
