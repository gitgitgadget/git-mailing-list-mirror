From: Luca Barbato <lu_zero@gentoo.org>
Subject: moving self contained subdirectories from a project to another
Date: Mon, 18 Jun 2007 14:24:25 +0200
Message-ID: <46767979.2030303@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 18 14:21:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0GEM-0001AQ-62
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 14:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761487AbXFRMVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 08:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbXFRMVM
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 08:21:12 -0400
Received: from smtp-out1.libero.it ([212.52.84.41]:58609 "EHLO
	smtp-out1.libero.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760866AbXFRMVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 08:21:11 -0400
Received: from mailrelay07.libero.it (172.31.0.114) by smtp-out1.libero.it (7.3.120)
        id 4611FD1805244F89 for git@vger.kernel.org; Mon, 18 Jun 2007 14:21:09 +0200
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAFQVdkaXK+9ATWdsb2JhbAANjwABARsSEg
Received: from unknown (HELO [192.168.0.6]) ([151.43.239.64])
  by outrelay07.libero.it with ESMTP; 18 Jun 2007 14:21:09 +0200
User-Agent: Thunderbird 2.0.0.0 (X11/20070607)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50393>

Lately I'm trying to move a subdirectory from one project to another,
both tracked in git.

This directory is currently duplicated in two different projects and my
plan was to remove it from those and make a library so it could be
shared between them.

Now, the simple way would be get a scratchpad branch, prune everything
but what I want, push to the library repo, make the projects use it.

There is already a script that automates this task? There are any
pitfalls I'm not considering?

lu

PS: keep me on CC since I'm not subscribed

-- 

Luca Barbato

Gentoo/linux Gentoo/PPC
http://dev.gentoo.org/~lu_zero
