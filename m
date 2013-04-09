From: Kevin Bracey <kevin@bracey.fi>
Subject: Locating merge that dropped a change
Date: Tue, 09 Apr 2013 21:00:41 +0300
Message-ID: <51645749.8090402@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 21:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPedO-0006rL-FW
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 21:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936136Ab3DITzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 15:55:08 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:56975 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936043Ab3DITzG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 15:55:06 -0400
X-Greylist: delayed 5399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2013 15:55:06 EDT
Received: from mail91.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 5F356FF87C8
	for <git@vger.kernel.org>; Tue,  9 Apr 2013 20:17:54 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 9 Apr 2013 20:00:43 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 9 Apr 2013 20:00:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.3 (mo3.mail-out.ovh.net)
X-Ovh-Tracer-Id: 6289839831277605086
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrtdefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500799/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrtdefucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220624>

This morning, I was struggling (not for the first time) to produce a Git 
command that would identify a merge commit that dropped a change. I 
could see where it was added, but couldn't automate finding out why it 
wasn't any longer in HEAD.

All the permutations of "--full-history", "-m", "-S", "-G" on "git log" 
I could think of did not get me anywhere. As long as I had 
"--full-history", they could find the original commit that had added the 
change, but not the merge commit that had dropped it by taking the other 
parent.

So, how to automatically find a merge that ignored a known change?

And then for visualisation purposes, how do you persuade gitk's diff 
display to actually show that that merge commit removed the change from 
one of its parents? Again, "-m" didn't seem to work.

Help appreciated!

Kevin
