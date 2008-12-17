From: jidanni@jidanni.org
Subject: git-format-patch patch
Date: Thu, 18 Dec 2008 04:53:42 +0800
Message-ID: <877i5yy149.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 22:26:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD3uZ-0003hl-9x
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 22:26:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYLQVZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 16:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbYLQVZK
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 16:25:10 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:50406 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751670AbYLQVZJ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Dec 2008 16:25:09 -0500
Received: from jidanni2.jidanni.org (122-127-36-47.dynamic.hinet.net [122.127.36.47])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id BB7C8D2731
	for <git@vger.kernel.org>; Wed, 17 Dec 2008 13:25:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103392>

I'm still reading the manpage about submitting proper patches, so for now:

*** /tmp/git-format-patch.txt	2008-12-18 04:41:34.050800884 +0800
--- /tmp/git-format-patchNEW.txt	2008-12-18 04:46:25.738801367 +0800
***************
*** 127,133 ****
  --in-reply-to=Message-Id::
  	Make the first mail (or all the mails with --no-thread) appear as a
  	reply to the given Message-Id, which avoids breaking threads to
! 	provide a new patch series.
  
  --ignore-if-in-upstream::
  	Do not include a patch that matches a commit in
--- 127,134 ----
  --in-reply-to=Message-Id::
  	Make the first mail (or all the mails with --no-thread) appear as a
  	reply to the given Message-Id, which avoids breaking threads to
! 	provide a new patch series. Generates coresponding References and
! 	In-Reply-To headers. Angle brackets around <Message-Id> are optional.
  
  --ignore-if-in-upstream::
  	Do not include a patch that matches a commit in
