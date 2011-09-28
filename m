From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: RE: Lack of detached signatures
Date: Wed, 28 Sep 2011 13:03:58 -0400
Message-ID: <1317228946-sup-8992@pinkfloyd.chass.utoronto.ca>
References: <alpine.LNX.2.00.1109271742460.24832@bruno> <7vty7xttxh.fsf@alter.siamese.dyndns.org> <CAMOZ1Bs2HW6e3V6sayVSm0NhC=0e5129ZR8YSGuZPnJw9H9TEA@mail.gmail.com> <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 19:04:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8xYD-0003m3-BM
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 19:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432Ab1I1REA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 13:04:00 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:60268 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab1I1RD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 13:03:59 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:41957 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1R8xY6-0006Gz-QK
	for git@vger.kernel.org; Wed, 28 Sep 2011 13:03:58 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1R8xY6-0003eb-PN
	for git@vger.kernel.org; Wed, 28 Sep 2011 13:03:58 -0400
In-reply-to: <4B2793BF110AAB47AB0EE7B90897038516F63A7C@ORSMSX101.amr.corp.intel.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182346>

Excerpts from Olsen, Alan R's message of Wed Sep 28 00:17:54 -0400 2011:

Hi Alan,

> What I would like to see in git would be signed commits. I have
> looked at what it would take to make it work, but I don't have all
> the details worked out. (Certain merges and cherry-picks would not
> work very well.)

I'm presuming that your intent is an optional signature, not a forced
one, but for discussion, consider the monotone[1] dvcs that forces a
signature on every commit.

While interesting, it was quite heavy weight.  Their design was
complicated by the fact that they used their own pki solution instead
of relying on gpg (although they did integrate with gpg-agent).
Granting access to a new user meant sharing monotone-specific keys,
etc.  It's been my experience that ssh keys are challenging enough for
many people, and asking them to use gpg keys is just not going to fly
unless mandated from the higher-ups.

We used monotone here for about a year and the key requirements were
the biggest turn off to adoption.  Maybe using standard (gpg) tools
would have been less so, but for the most part, I don't think so.

In my (very humble) opinion, signed tags (or possibly the new signed
push certificates) are a much better solution to this.  They offer the
same guarantees as having every commit signed (trust of all commits
can be determined based on a signle signature) but leave daily
interactions much more light weight and flexible.

Thanks
-Ben

[1] http://monotone.ca
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
