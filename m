From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: [darcs-devel] Darcs and git: plan of action
Date: Mon, 18 Apr 2005 17:07:28 -0700
Organization: http://madrabbit.org/
Message-ID: <1113869248.23938.94.camel@orca.madrabbit.org>
References: <20050418210436.23935.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, darcs-devel@darcs.net, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Apr 19 02:04:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgDZ-0001l0-7K
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 02:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVDSAHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 20:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVDSAHr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 20:07:47 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:8933 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S261190AbVDSAHb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 20:07:31 -0400
Received: from orca.madrabbit.org (orca.madrabbit.org [192.168.1.51])
	by madrabbit.org (Postfix) with ESMTP
	id 3E2C04C083E; Mon, 18 Apr 2005 17:07:29 -0700 (PDT)
To: linux@horizon.com
In-Reply-To: <20050418210436.23935.qmail@science.horizon.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2005-04-18 at 21:04 +0000, linux@horizon.com wrote:
> The other is "replace very instace of identifier `foo` with identifier`bar`".

That could be derived, however, by a particularly smart parser [1].
Alternately, that itself could be embedded in the comment for patches
sourced from darcs. Of course, that means patches from others are less
commutable than from other darcs users, but that's the price you'd pay
for relying on the user to explicitly note a token rename.

  [1] An example: http://minnie.tuhs.org/Programs/Ctcompare/index.html

As for "darcs mv", that can be derived from the before/after pictures of
the trees.

> And darcs is specifically intended to support additional kinds of patches.

Anything missing out of what I listed above? (darcs has adddir and
addfile, IIRC, but those are trivially discovered via inspection of the
trees as well, I think.)

> Anyway, the point is that, in the darcs world, it is NOT possible to
> reconstruct a patch from the before and after trees.

Not yet, and maybe not ever, but I think we can certainly get closer to
discovering what the coder was thinking during a changeset.

Ray

