From: Eric Raible <raible@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git =?utf-8?b?cmVzZXQJLS1oYXJkIg==?=
Date: Thu, 11 Sep 2008 20:26:30 +0000 (UTC)
Message-ID: <loom.20080911T202202-144@post.gmane.org>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com> <20080911061454.GA8167@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 22:27:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdslW-0002O7-AF
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbYIKU0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbYIKU0j
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:26:39 -0400
Received: from main.gmane.org ([80.91.229.2]:35288 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbYIKU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:26:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KdskP-0006tE-Bv
	for git@vger.kernel.org; Thu, 11 Sep 2008 20:26:37 +0000
Received: from adsl-75-24-208-45.dsl.pltn13.sbcglobal.net ([75.24.208.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 20:26:37 +0000
Received: from raible by adsl-75-24-208-45.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 20:26:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.208.45 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.29 Safari/525.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95642>

Mike Hommey <mh <at> glandium.org> writes:

> Note that reflog only contains references to commit sha1s, so it can't
> track index status.

Yes I realize that.

My point was that the file is entirely gone (except via "git fsck").
I wouldn't expect the reflog to reference it, but I was just mentioning
it for completeness (since it's often help in recovering from types of
lossage).
