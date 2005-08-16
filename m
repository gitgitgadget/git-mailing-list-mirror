From: Dave Jones <davej@redhat.com>
Subject: FUNKY tags.
Date: Tue, 16 Aug 2005 18:43:32 -0400
Message-ID: <20050816224332.GE26455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 17 00:44:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5A9w-0003pQ-9R
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 00:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVHPWnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 18:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVHPWnn
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 18:43:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58536 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750710AbVHPWnm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 18:43:42 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j7GMhYJY009195
	for <git@vger.kernel.org>; Tue, 16 Aug 2005 18:43:34 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j7GMhXV08857
	for <git@vger.kernel.org>; Tue, 16 Aug 2005 18:43:33 -0400
Received: from nwo.kernelslacker.org (vpn50-3.rdu.redhat.com [172.16.50.3])
	by devserv.devel.redhat.com (8.12.11/8.12.11) with ESMTP id j7GMhXbn013067
	for <git@vger.kernel.org>; Tue, 16 Aug 2005 18:43:33 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.4/8.13.4) with ESMTP id j7GMhXH8010572
	for <git@vger.kernel.org>; Tue, 16 Aug 2005 18:43:33 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.4/8.13.4/Submit) id j7GMhWOt010571
	for git@vger.kernel.org; Tue, 16 Aug 2005 18:43:32 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just tried a cvs->git conversion using the git-cvsimport-script
and cvsps flagged a bunch of tags as **FUNKY**

I've no idea what I did when I tagged those trees, but according
to a google search, cvsps does that when it find patchsets which
are chronologically (and thus by patchset id) earlier than the tag,
but are tagwise after.  Spooky.

I looked the tree over with gitk, and it seemed fine around those tags,
so I'm wondering what value there is in preserving this info, and
whether we should remove it at cvsimport time somehow. Comments?

		Dave
