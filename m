From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: "make quick-install-man" broke recently
Date: Sun, 16 Aug 2009 18:16:54 -0700
Message-ID: <86my5z8cjd.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 03:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McqqM-00080g-F1
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 03:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbZHQBQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 21:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbZHQBQx
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 21:16:53 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:19128 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZHQBQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 21:16:53 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id CF0081DE268; Sun, 16 Aug 2009 18:16:54 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.10.17; tzolkin = 3 Caban; haab = 15 Yaxkin
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126102>


Something broke recently in "make quick-install-man".  It works
fine if my mandir is empty, but not if a previous installation
is there.

Perhaps missing something that deletes the previous values?

Or maybe a change in the way "git checkout-index" works?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
