From: Eric Raible <raible@gmail.com>
Subject: Re: [PATCH v4 04/15] sequencer: add =?utf-8?b?InJlc2V0X2FsbW9zdF9oYXJkKCki?= and =?utf-8?b?cmVsYXRlZAlmdW5jdGlvbnM=?=
Date: Fri, 28 Aug 2009 06:08:54 +0000 (UTC)
Message-ID: <loom.20090828T080732-795@post.gmane.org>
References: <20090828043913.4307.34708.chriscool@tuxfamily.org> <20090828044746.4307.88742.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 08:09:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgueM-0002dt-AA
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 08:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbZH1GJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 02:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbZH1GJQ
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 02:09:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:36101 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbZH1GJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 02:09:16 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MgueD-0002bl-6C
	for git@vger.kernel.org; Fri, 28 Aug 2009 08:09:17 +0200
Received: from adsl-70-132-3-191.dsl.snfc21.sbcglobal.net ([70.132.3.191])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 08:09:17 +0200
Received: from raible by adsl-70-132-3-191.dsl.snfc21.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 08:09:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 70.132.3.191 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.39 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127271>

Christian Couder <chriscool <at> tuxfamily.org> writes:

> "reset_almost_hard()" can be used to do a "git reset --hard". It
> should be faster as it calls "unpack_trees()" directly, and it can
> optionnaly preserve changes in the work tree if the "allow_dirty"
> global is set. Preserving changes in the work tree can be usefull
> if for example you want to get rid of the last commit but keep
> your current not yet commited work.

s/optionnaly/optionally/
s/usefull/useful/
