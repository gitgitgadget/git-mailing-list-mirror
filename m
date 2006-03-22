From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Don't use merge labels in the ed scripts
Date: Tue, 21 Mar 2006 23:07:29 -0500
Message-ID: <1143000449.23183.8.camel@dv>
References: <20060321205414.8301.97041.stgit@dv.roinet.com>
	 <20060321205956.GX19263@pasky.or.cz> <1142977465.8712.4.camel@dv>
	 <20060321214818.GY19263@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 05:07:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLudL-0004ZC-KO
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 05:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWCVEHj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 23:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWCVEHj
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 23:07:39 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:62181 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750739AbWCVEHj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 23:07:39 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FLudS-00077y-Oq
	for git@vger.kernel.org; Tue, 21 Mar 2006 23:07:50 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1FLud7-0007aj-M4; Tue, 21 Mar 2006 23:07:29 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060321214818.GY19263@pasky.or.cz>
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17800>

Hi, Petr!

On Tue, 2006-03-21 at 22:48 +0100, Petr Baudis wrote:
> > > Well, I sincerely hope that they won't change again. ;-)
> > 
> > Actually, it would be nice to never expose labels starting with
> > ".merge_file_" - cogito should provide more meaningful labels instead.
> 
>   we shouldn't ever expose them, though. If we do, that's a bug.

It turns out those labels were produced by "git merge".  Either "git
merge" should be removed from the test, or "cg-reset" should be used
after the failure.  I prefer the later since it's another test for
Cogito.

Once the mess from "git merge" is cleaned up, it turns out that the last
merge in the testsuite doesn't fail, and several final fixups are no
longer needed.  I think it should be OK to remove corresponding code.
It has no Cogito commands other than cg-commit, which is already tested
elsewhere.

I'm sending you the new patch.

-- 
Regards,
Pavel Roskin
