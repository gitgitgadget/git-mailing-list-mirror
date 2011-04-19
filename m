From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4 issue
Date: Tue, 19 Apr 2011 09:59:09 +0000 (UTC)
Message-ID: <loom.20110419T115354-846@post.gmane.org>
References: <BANLkTikeQSqAhm2CwCYBkE74OxPUnA0cOg@mail.gmail.com> <BANLkTimmVQAcx7hiQFUBcoAGdvPhktPuMg@mail.gmail.com> <BANLkTikDDDtyJB992DFNtvgMrGvbWf=rMw@mail.gmail.com> <BANLkTinJecAsXt+5JzscFYEx_ez2q9DioQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 11:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC7iW-0000H4-DY
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 11:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab1DSJ71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 05:59:27 -0400
Received: from lo.gmane.org ([80.91.229.12]:41990 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab1DSJ71 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 05:59:27 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QC7iJ-0000BO-U9
	for git@vger.kernel.org; Tue, 19 Apr 2011 11:59:22 +0200
Received: from 57.79.130.188 ([57.79.130.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 11:59:19 +0200
Received: from vitor.hda by 57.79.130.188 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 11:59:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 57.79.130.188 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:2.0) Gecko/20100101 Firefox/4.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171789>

Hi Mike,

Could you please search for the following set of patches in this mailing list?

[PATCH v2 0/3] git-p4: Improve branch support

I think I sent v2 twice somehow, so please make sure you pick the latest ;)
In these patches I add the possibility to use a "git-p4.branchList"
configuration to define the branches. The patch is still to be approved because
most people in the mailing list do not use branch detection, but I use it daily
and it is working in my side. Could you please test it?

Thanks,
Vitor

P.S. - It's better that you do not apply "[PATCH v2 1/3] git-p4: Correct branch
base depot path detection", as it may require you to clone the all depot again.
