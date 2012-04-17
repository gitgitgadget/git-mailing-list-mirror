From: Mark Jason Dominus <mjd@plover.com>
Subject: git-push sent too many objects
Date: Tue, 17 Apr 2012 12:53:27 -0400
Organization: P.D.Q. Bernoulli Institute of Lower Mathematics
Message-ID: <30586.1334681607@plover.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 18:53:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKBf0-0006Hj-9L
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 18:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab2DQQxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 12:53:41 -0400
Received: from vms173021pub.verizon.net ([206.46.173.21]:29097 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab2DQQxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 12:53:41 -0400
Received: from plover.com ([unknown] [72.92.0.95]) by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M2M000G8UX3J180@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 17 Apr 2012 11:53:28 -0500 (CDT)
Received: (qmail 30588 invoked by uid 1000); Tue, 17 Apr 2012 16:53:27 +0000
Received: from localhost (HELO plover.com) (sendmail-bs@127.0.0.1)
 by localhost with SMTP; Tue, 17 Apr 2012 16:53:27 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195771>


I had a master ref, pointing to commit 231e284, which I branched to
make a "coupon" ref.  My remote, "origin" had a copy of commit 
231e284.

I modified one file and committed it on "coupon", yielding commit
03b6489. Then I pushed coupon to origin.  I expected that git-push
would send about five objects, but instead it reported sending 1,315.

Command output is pasted at http://nopaste.info/a866bb00e0.html .
You can verify that:

1. I pushed only coupon, not any other ref.
2. origin already had a copy of coupon's predecessor commit, 231e284.
3. 03b6489 was identical to 231e284 except for changes in one file.
4. I was not doing anything obviously strange.

What happened here?  Why did git-push send 1,315 objects instead of 5?

Mark Jason Dominus 	  			                 mjd@plover.com
