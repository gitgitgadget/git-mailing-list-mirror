From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-svn with big subversion repository
Date: Sat, 05 Mar 2011 11:53:12 +0100
Message-ID: <87lj0t7s9z.fsf@mid.deneb.enyo.de>
References: <C992EE5B.CBFB%jkristian@linkedin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 11:53:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvp6s-0002U1-K7
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 11:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab1CEKxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 05:53:14 -0500
Received: from ka.mail.enyo.de ([87.106.162.201]:51322 "EHLO ka.mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab1CEKxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 05:53:13 -0500
Received: from [172.17.135.4] (helo=deneb.enyo.de)
	by ka.mail.enyo.de with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	id 1Pvp6m-0006mO-A3
	for git@vger.kernel.org; Sat, 05 Mar 2011 11:53:12 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.72)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Pvp6m-0002Qj-2y
	for git@vger.kernel.org; Sat, 05 Mar 2011 11:53:12 +0100
In-Reply-To: <C992EE5B.CBFB%jkristian@linkedin.com> (John Kristian's message
	of "Wed, 2 Mar 2011 02:43:23 +0000")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168486>

* John Kristian:

> How do you recommend using git to work with branches of a large, busy
> subversion repository? In general, how can small teams use git for their
> tasks, and use subversion to coordinate with a larger organization?

I've used svnsync to a local repository and git-svn against that.
This meant that my experiments do not cause excessive load on the
server.

You should definitely coordinate this because this could be considered
leaching IP if the repository is not public.
