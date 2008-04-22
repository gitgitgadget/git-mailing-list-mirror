From: "Roman V. Shaposhnik" <rvs@sun.com>
Subject: Questions on patch lifecycle
Date: Mon, 21 Apr 2008 21:11:21 -0700
Message-ID: <1208837481.26863.374.camel@goose.sun.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 06:02:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo9hh-0005Fh-P3
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 06:02:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbYDVEBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 00:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbYDVEBA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 00:01:00 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:46472 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbYDVEA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 00:00:59 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id m3M40xII005599
	for <git@vger.kernel.org>; Mon, 21 Apr 2008 21:00:59 -0700 (PDT)
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZP00901KDZIL00@fe-sfbay-09.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Mon, 21 Apr 2008 21:00:59 -0700 (PDT)
Received: from [192.168.0.103] ([76.21.110.21])
 by fe-sfbay-09.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb
 28 2007)) with ESMTPSA id <0JZP00HW2KHM26D0@fe-sfbay-09.sun.com> for
 git@vger.kernel.org; Mon, 21 Apr 2008 21:00:58 -0700 (PDT)
X-Mailer: Evolution 2.12.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80056>

I'm a bit confused by the etiquette around submitting
proposals for patches in Git and I would like to
understand this process better. Especially since the
only way to get closure on .gitconfig issue seems to
be to show the code ;-)

Anyway, here are the questions:

   0. Junio, are you the only Git maintainer or are there
      others responsible for particular subsystems of Git?
  
   1. What's the official way of submitting a patch?
      Is git-send-email(1) to this mailing list
      good enough? Does a submitter have to have
      a public tree that maintainer(s) can pull from?

   2. Once the patch is submitted how does the author
      get notified whether it is accepted, rejected
      or needs additional work.

Now, #2 is especially important for me, simply because
the project I come from (FFmpeg) has a bit of different 
policy around the status of each submitted patch. 
Pretty much within a 48 hour window a submitter gets 
notified whether the patch was accepted, rejected, needs 
more work or the maintainer of a particular subsystem needs 
more time in order to review the changes. What's confusing to 
me with Git, are the examples like some patches from Ping Yin 
not receiving any public acknowledgment at all and some of the 
patches from other submitters (Dmitry Potapov) getting sort of 
lost.

Thanks,
Roman.
