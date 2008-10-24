From: Samuel Abels <newsgroups@debain.org>
Subject: Performance impact of a large number of commits
Date: Fri, 24 Oct 2008 21:02:26 +0200
Message-ID: <1224874946.7566.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 21:35:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSRJ-000217-Lk
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbYJXTdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYJXTdl
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:33:41 -0400
Received: from mail.speedpartner.de ([91.184.32.3]:42241 "EHLO
	mail.speedpartner.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbYJXTdk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:33:40 -0400
X-Greylist: delayed 1873 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Oct 2008 15:33:40 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.speedpartner.de (Postfix) with ESMTP id 9FC30B3CA2
	for <git@vger.kernel.org>; Fri, 24 Oct 2008 21:02:26 +0200 (CEST)
Received: from mail.speedpartner.de ([127.0.0.1])
	by localhost (mail.speedpartner.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fj4QIPdSlSbR for <git@vger.kernel.org>;
	Fri, 24 Oct 2008 21:02:26 +0200 (CEST)
Received: from [192.168.0.3] (stgt-4d02e380.pool.mediaWays.net [77.2.227.128])
	by mail.speedpartner.de (Postfix) with ESMTP id 6AE96B3AE2
	for <git@vger.kernel.org>; Fri, 24 Oct 2008 21:02:26 +0200 (CEST)
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99052>

Hi,

I am considering Git to maintain a repository of approximately 300.000
files totaling 1 GB, with a number of ~100.000 commits per day, all in
one single branch. The only operations performed are "git commit", "git
show", and "git checkout", and all on one local machine. Does this sound
like a reasonable thing to do with Git?

-Samuel
