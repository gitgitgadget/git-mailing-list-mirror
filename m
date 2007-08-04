From: Yann Dirson <ydirson@altern.org>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 10:16:16 +0200
Message-ID: <20070804081616.GE30277@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1186163410.26110.55.camel@dv> <20070804063858.GA13758@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 04 10:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHEpE-00022b-Ae
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 10:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbXHDIRY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 04:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbXHDIRX
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 04:17:23 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58926 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790AbXHDIRW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 04:17:22 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CCEF481C5;
	Sat,  4 Aug 2007 10:17:21 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 992BC38C9;
	Sat,  4 Aug 2007 10:17:21 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 409D41F070; Sat,  4 Aug 2007 10:16:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070804063858.GA13758@thunk.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54814>

On Sat, Aug 04, 2007 at 02:38:58AM -0400, Theodore Tso wrote:
> My main reason for avoiding StGIT is the fact that at least in the
> past, I've found it very fragile when I forget and use "git checkout"
> instead of "stg branch" to switch between branches.

FWIW, I exclusively use git-checkout to switch between git branches
and stgit stacks, and it works like a charm.  I don't remember ever
seeing a problem with this, so I guess it has been fixed for a long
time.

But yes, there are still robustness issues with stgit.  It looks like
the user base is small, since there are not so many bugreports.  We
tend to take care about the workfows we use, and people with other
workflows obviously should tell us what gets wrong :)

Best regards,
-- 
Yann
