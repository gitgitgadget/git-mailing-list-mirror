From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3 1/6] worktree: new repo extension to manage worktree
 behaviors
Date: Sat, 30 Jan 2016 16:20:39 +0200
Message-ID: <20160130142039.GB4978@wheezy.local>
References: <1451186079-6119-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-1-git-send-email-pclouds@gmail.com>
 <1453808685-21235-2-git-send-email-pclouds@gmail.com>
 <xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, max@max630.net, git@drmicha.warpmail.net,
	Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 15:20:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPWOW-0006BI-Oq
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 15:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756832AbcA3OUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 09:20:43 -0500
Received: from p3plsmtpa09-05.prod.phx3.secureserver.net ([173.201.193.234]:54186
	"EHLO p3plsmtpa09-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754382AbcA3OUm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2016 09:20:42 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-05.prod.phx3.secureserver.net with 
	id CELd1s0085B68XE01ELgRS; Sat, 30 Jan 2016 07:20:42 -0700
Content-Disposition: inline
In-Reply-To: <xmqqfuxi7jtn.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285114>

On Wed, Jan 27, 2016 at 02:12:52PM -0800, Junio C Hamano wrote:
> More seriously, are we confident that the overall worktree support
> is mature enough by now that once we add an experimental feature X
> at version 1, we can promise to keep maintaining it forever at
> version N for any positive integer N?  I hate to sound overly
> negative, but I am getting an impression that we are not quite
> there, and it is still not ready for production use.

The worktree feature has been used by several people
already (me included), and do far the only issue which
requires change in repository layout is the config
separation. Isn't it enough to be confident?

As I noted in another email, I would not expect to be N>2
soon. At least not more likely than incompatible change
because of some other reason. And the support for an older
version can be as little as one-time upgrade to the current
N (preferably with confirmation from user).

> It would be beneficial both for us and our users if we can keep our
> hand untied for at least several more releases to allow us try
> various random experimental features, fully intending to drop any of
> them if the ideas do not pan out.

Users definitely would not benefit if there is release
feature with note "anything you do can be lost after you
install next version of git"
