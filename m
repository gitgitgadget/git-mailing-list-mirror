From: Bogolisk <bogolisk@gmail.com>
Subject: confused by git diff --exit-code
Date: Wed, 24 Oct 2012 10:33:21 +0000 (UTC)
Message-ID: <loom.20121024T122128-688@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 12:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQyIo-00049b-Qj
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 12:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962Ab2JXKe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 06:34:58 -0400
Received: from plane.gmane.org ([80.91.229.3]:38419 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754417Ab2JXKe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 06:34:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TQyIh-00045e-25
	for git@vger.kernel.org; Wed, 24 Oct 2012 12:35:03 +0200
Received: from owa.belairnetworks.com ([173.195.49.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 12:35:03 +0200
Received: from bogolisk by owa.belairnetworks.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 12:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 173.195.49.66 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.94 Safari/537.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208303>

With merge conflicts in the work-tree, diff's exit-code seems inconsistent. I 
thought --quiet implied --exit-code


/others/foo$ git diff --quiet
/others/foo$ echo $?
1

/others/foo$ git diff --exit-code
diff --cc foo.txt
index f3dc283,bea67fd..0000000
--- a/foo.txt
+++ b/foo.txt
/others/foo$ echo $?
0

/others/foo$ git diff --cc --quiet
/others/foo$ echo $?
0

/others/foo$ git diff --cc --exit-code
diff --cc foo.txt
index f3dc283,bea67fd..0000000
--- a/foo.txt
+++ b/foo.txt
/others/foo$ echo $?
0
