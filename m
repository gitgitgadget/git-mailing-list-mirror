From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: Cutting history
Date: Sat, 10 Jul 2010 02:43:04 -0400
Message-ID: <20100710064304.GA15600@foursquare.net>
References: <20100710032553.GB554@nibiru.local> <4C37F24E.30407@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: weigelt@metux.de, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 08:54:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXTxP-0003BK-UN
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 08:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502Ab0GJGyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 02:54:35 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:40390 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab0GJGye (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 02:54:34 -0400
X-Greylist: delayed 677 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Jul 2010 02:54:34 EDT
X-Originating-Ip: 216.16.235.2
Received: from localhost (nic.NetDirect.CA [216.16.235.2])
	by rubicon.netdirect.ca (8.13.8/8.13.8) with ESMTP id o6A6h456016119;
	Sat, 10 Jul 2010 02:43:04 -0400
Content-Disposition: inline
In-Reply-To: <4C37F24E.30407@workspacewhiz.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150711>

On Fri, Jul 09, 2010 at 10:08:46PM -0600, Joshua Jensen wrote:
> Your post reminded me of this: http://progit.org/2010/03/17/replace.html

Wow.  This is what I get for not following git development more closely. :-)

Doesn't this open a potential security problem?  Suppose you want to pull
from another developer's repo, and he's replaced some of the history
in your own tree.  According to the above article, it is possible to
share replacements, presumably like any other ref.

Is it possible to have your own branch history "replaced" by fetching
someone else's repo into a remote branch?

- Chris
