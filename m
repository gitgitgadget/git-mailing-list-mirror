From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Wed, 22 May 2013 10:45:31 -0400
Message-ID: <20130522144531.GB2777@thunk.org>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
 <x2ip2b6udr.fsf@bacon.lysator.liu.se>
 <20130522134212.GB13731@poseidon.cudanet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed May 22 16:46:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfAIT-0002P5-Qn
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 16:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266Ab3EVOpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 10:45:40 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:50757 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756257Ab3EVOpj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 10:45:39 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1UfAKv-0005DV-Pv; Wed, 22 May 2013 14:48:17 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id C1BB25814B7; Wed, 22 May 2013 10:45:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130522134212.GB13731@poseidon.cudanet.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225165>

I just had another idea (although I haven't had a chance to code up
anything yet).  Perhaps instead of, or in addition to, a global
setting (i.e., guilt.reusebranch), perhaps we should have a per-branch
setting, such as branch.<branch>.guiltReuseBranch?

I was actually thinking that it might be interesting to have a
branch.<branch>.rewindable, which would change the guilt defaults, and
could also key changes in key git behavior which makes it less likely
that a user shoots him or herself in the foot --- i.e., give warnings
if he or she has modified the branch in such a way that
remotes.origin.<branch> is no longer contained within the branch head.

			      	     	       	      	  - Ted
