From: "John S. Urban" <urbanjost@comcast.net>
Subject: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sat, 3 Sep 2011 21:32:03 -0400
Message-ID: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 04 03:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R01nq-0008Vk-16
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 03:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab1IDBi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 21:38:59 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:39676
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752474Ab1IDBi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Sep 2011 21:38:58 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Sep 2011 21:38:58 EDT
Received: from omta15.westchester.pa.mail.comcast.net ([76.96.62.87])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id URUF1h0041swQuc5ERYvl4; Sun, 04 Sep 2011 01:32:55 +0000
Received: from urbanjsPC ([71.236.72.62])
	by omta15.westchester.pa.mail.comcast.net with comcast
	id URYu1h0151LdoTr3bRYvT9; Sun, 04 Sep 2011 01:32:55 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6001.18416
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6001.18645
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180668>

With my first use of git(1) I  created a small project with about 200 
"commits".  When this was complete, I needed to label each commit with
information pointing it to a section of a document. I used tags for this. So 
far, everything was fine. I was then asked to merge two commits
into one. I then did a "rebase" (for the first time). I then appear to have 
lost all association between the tags and the effected commits; as all 
commits after
the ones I modified no longer see "their" tags. Was there a way to have kept 
the tags associated with the original commits as they were "rebased"?

Also, I have some commits with multiple tags pointing to them. It has come 
to my attention that might not be an intentional feature. I could find
nothing in the documentation explicitly stating multiple tags were allowed 
to point to a commit; but the tags seem to be unique "objects" so I
see no reason this should not be an expected feature?

Thanks for any insights. Other than loosing association between the tags and 
the commits with rebase (which I was hesitant to use; and am now
doubly so) I found git(1) to be the first version control system better than 
"be careful and make tar-balls of major releases"; although I am just
starting to get an idea of how the pieces work.

 
