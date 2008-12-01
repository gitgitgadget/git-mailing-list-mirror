From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: Is rebase always destructive?
Date: Mon, 1 Dec 2008 23:11:40 +1100
Message-ID: <20081201121140.GB32415@mail.local.tull.net>
References: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Csaba Henk <csaba-ml@creo.hu>
X-From: git-owner@vger.kernel.org Mon Dec 01 13:20:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L77lA-0003nm-8z
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 13:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbYLAMSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 07:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbYLAMSZ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 07:18:25 -0500
Received: from vps1.tull.net ([66.180.172.116]:40731 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752457AbYLAMSY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 07:18:24 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Dec 2008 07:18:24 EST
Received: (qmail 12749 invoked by uid 1015); 1 Dec 2008 23:11:42 +1100
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Mon, 01 Dec 2008 23:11:42 +1100
Received: (qmail 2534 invoked by uid 1000); 1 Dec 2008 23:11:40 +1100
Content-Disposition: inline
In-Reply-To: <slrngj7jch.2srb.csaba-ml@beastie.creo.hu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102028>

On Mon, Dec 01, 2008 at 11:41:39AM +0000, Csaba Henk wrote:
> When doing a rebase, I can find a number of reasons for which one might
> feel like to preserve the rebased branch (that is, perform an operation
> which copies the branch over a new base, not moves).

[...]

> I can't see any option for rebase which would yield this cp-like
> behaviour. Am I missing something?

How about this:

git checkout topic
git branch keepme
git rebase master

Your 'topic' branch will now be rebased against master, and due
to the 'keepme' branch pointer at the original topic HEAD, you can
see the original commits before rebasing.

Nick.
