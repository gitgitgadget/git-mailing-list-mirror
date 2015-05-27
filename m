From: John Lee <jjl@pobox.com>
Subject: Re: Staging commits with visual diff tools?
Date: Wed, 27 May 2015 08:34:43 +0100 (BST)
Message-ID: <alpine.DEB.2.10.1505270831490.4687@alice>
References: <alpine.DEB.2.10.1505262147230.3709@alice> <20150527072826.GC6898@peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 09:35:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVrt-0005yO-UU
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 09:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbbE0HfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 03:35:08 -0400
Received: from mxout-08.mxes.net ([216.86.168.183]:30787 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbbE0HfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 03:35:07 -0400
Received: from alice.home (unknown [109.156.160.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id C01C6509BB
	for <git@vger.kernel.org>; Wed, 27 May 2015 03:35:06 -0400 (EDT)
In-Reply-To: <20150527072826.GC6898@peff.net>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270035>

On Wed, 27 May 2015, Jeff King wrote:

> If you are interested in looking further, see how the %patch_mode hash
> is defined in git-add--interactive.perl. Specifically, note that "add
> -p" is just one case: diff against the index and apply with "apply
> --cached". But once you have a separate tool for picking hunks, you
> should be able to drop in the different DIFF/APPLY pairs to implement
> "checkout -p", etc.

My plan was to use symlinks, checkout-index, and update-index 
--index-info, similar to how difftool does it.  I verified on the command 
line that that seems to work.


John
