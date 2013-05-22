From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] Added guilt.reusebranch configuration option.
Date: Wed, 22 May 2013 12:31:39 -0400
Message-ID: <20130522163139.GF13731@poseidon.cudanet.local>
References: <1369224677-16404-1-git-send-email-tytso@mit.edu>
 <x2ip2b6udr.fsf@bacon.lysator.liu.se>
 <20130522134212.GB13731@poseidon.cudanet.local>
 <20130522144531.GB2777@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed May 22 18:31:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfBx4-0005GW-Cr
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 18:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244Ab3EVQbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 12:31:42 -0400
Received: from josefsipek.net ([64.9.206.49]:1630 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3EVQbl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 12:31:41 -0400
Received: from poseidon.cudanet.local (unknown [64.235.151.250])
	by josefsipek.net (Postfix) with ESMTPSA id B18AD173B;
	Wed, 22 May 2013 12:31:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130522144531.GB2777@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225172>

On Wed, May 22, 2013 at 10:45:31AM -0400, Theodore Ts'o wrote:
> I just had another idea (although I haven't had a chance to code up
> anything yet).  Perhaps instead of, or in addition to, a global
> setting (i.e., guilt.reusebranch), perhaps we should have a per-branch
> setting, such as branch.<branch>.guiltReuseBranch?
> 
> I was actually thinking that it might be interesting to have a
> branch.<branch>.rewindable, which would change the guilt defaults, and
> could also key changes in key git behavior which makes it less likely
> that a user shoots him or herself in the foot --- i.e., give warnings
> if he or she has modified the branch in such a way that
> remotes.origin.<branch> is no longer contained within the branch head.

Interesting!  I wonder what git people have to say about this.

Jeff.

-- 
We have joy, we have fun, we have Linux on a Sun...
