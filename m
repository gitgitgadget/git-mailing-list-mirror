From: Pieter de Bie <pieter@frim.nl>
Subject: Re: What is the current best bi-directional git<->bzr method?
Date: Tue, 19 May 2009 16:51:36 +0100
Message-ID: <03D68F82-503F-47D1-BF65-9D255E16EE00@frim.nl>
References: <b2cdc9f30905190708t1e170106oce3c577933c99247@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Tue May 19 18:32:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6SEX-0006jx-Mq
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbZESQbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbZESQbv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:31:51 -0400
Received: from frim.nl ([87.230.85.232]:34398 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754183AbZESQbv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 12:31:51 -0400
X-Greylist: delayed 2406 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2009 12:31:51 EDT
Received: from cpat002.wlan.net.ed.ac.uk ([129.215.5.254] helo=[172.20.100.146])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1M6RbS-0004gf-SS; Tue, 19 May 2009 16:51:43 +0100
In-Reply-To: <b2cdc9f30905190708t1e170106oce3c577933c99247@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119547>

Hi,

On May 19, 2009, at 3:08 PM, Alex Bennee wrote:
> I found a script[1] which I have hacked a bit[2] to import repo's
> fine. However going the other way doesn't seem to work. Before I mess
> around too much further I though I'd check if there are any known
> working gateways at the moment?

Bidirectional syncing should work, though I've heard there
may be some problems with multiple branches. I had a discussion
with someone about the used mapping, and they hacked up something
in bash, though I've never looked at it. I've lost interest in
git<->bzr syncing (and bzr in general) some time ago, so I never
looked at it further. What specific problem do you have?

It might be that Bazaar changed something in the last year.
They change their repository format and commands quite frequently,
so you might be able to get it to work with an older version.

> [1] http://github.com/pieter/git-bzr/tree/master
> [2] http://github.com/stsquad/git-bzr/tree/master

- Pieter
