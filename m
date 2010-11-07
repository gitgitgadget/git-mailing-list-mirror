From: Thomas Rinderknecht <thomasr@sailguy.org>
Subject: Re: [PATCH] dir.c: fix =?utf-8?b?RVhDX0ZMQUdfTVVTVEJFRElS?= match in sparse checkout
Date: Sun, 7 Nov 2010 21:44:11 +0000 (UTC)
Message-ID: <loom.20101107T224233-408@post.gmane.org>
References: <loom.20101107T172926-284@post.gmane.org> <1289153098-15684-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 07 22:44:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFD2P-00053f-19
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 22:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab0KGVoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 16:44:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:42473 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711Ab0KGVoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 16:44:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PFD2E-00051F-T8
	for git@vger.kernel.org; Sun, 07 Nov 2010 22:44:22 +0100
Received: from pool-96-225-233-249.ptldor.fios.verizon.net ([96.225.233.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 22:44:22 +0100
Received: from thomasr by pool-96-225-233-249.ptldor.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 22:44:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 96.225.233.249 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.10 (maverick) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160902>


Thanks for the quick fix! I was initially worried about using sparse-checkout
since it is a fairly new feature, but it has been working well for us. I am
truly impressed with the quality of the git code, and the dedication of the
developers who are enhancing and maintaining it.
