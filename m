From: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 08:15:56 -0700
Message-ID: <E1Na9ca-0004x2-Gf@xyzzy.farnsworth.org>
References: <201001270819.39819.elendil@planet.nl> <201001270936.14935.elendil@planet.nl> <20100127101943.GA4470@progeny.tock>
To: elendil@planet.nl, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 17:10:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaATV-0004Ia-49
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 17:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787Ab0A0QKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 11:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437Ab0A0QKa
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 11:10:30 -0500
Received: from xyzzy.farnsworth.org ([65.39.95.219]:51938 "EHLO
	xyzzy.farnsworth.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab0A0QK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 11:10:29 -0500
X-Greylist: delayed 3265 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2010 11:10:29 EST
Received: from dale by xyzzy.farnsworth.org with local (Exim 4.69)
	(envelope-from <dale@farnsworth.org>)
	id 1Na9ca-0004x2-Gf; Wed, 27 Jan 2010 08:16:02 -0700
In-Reply-To: <201001271426.06844.elendil@planet.nl>
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on xyzzy.farnsworth.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NO_RELAYS
	autolearn=ham version=3.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138163>

> >  git rev-list ^HEAD --no-walk commit1 commit2 ...
> 
> Does not seem to work. But I'd be interested if you find a variant that 
> does as it's very fast.

I've been using the following.  It produces output only if the commit
is NOT in HEAD.

git rev-list -1 ^HEAD commitID

-Dale
