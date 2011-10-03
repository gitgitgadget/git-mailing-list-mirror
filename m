From: Marcus Karlsson <mk@acc.umu.se>
Subject: Re: [PATCH v2] gitk: Show patch for initial commit
Date: Mon, 3 Oct 2011 08:33:59 +0200
Message-ID: <20111003063359.GA11391@kennedy.acc.umu.se>
References: <20111001190554.GA5854@kennedy.acc.umu.se>
 <4E878016.703@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Paul Mackerras <paulus@samba.org>
To: Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Oct 03 08:34:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAc6K-0000zy-ET
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 08:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874Ab1JCGeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 02:34:04 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:61314 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab1JCGeC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 02:34:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id A020A83B;
	Mon,  3 Oct 2011 08:34:00 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id DC77783A;
	Mon,  3 Oct 2011 08:33:59 +0200 (MEST)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id C314D69; Mon,  3 Oct 2011 08:33:59 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <4E878016.703@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182625>

On Sat, Oct 01, 2011 at 11:03:18PM +0200, Zbigniew J??drzejewski-Szmek wrote:
> [cc: Paul Mackerras]
> 
> Hi,
> I think that the historical explanation that Junio gave could
> be used as a basis for a commit message:
> 
>   In early days, all projects managed by git (except for git itself) had the
>   product of a fairly mature development history in their first commit, and
>   it was deemed unnecessary clutter to show additions of these thousands of
>   paths as a patch.
> 
>   "git log" learned to show the patch for the initial commit without requiring
>   --root command line option at 0f03ca9 (config option log.showroot to show
>   the diff of root commits, 2006-11-23).
> 
>   Teach gitk to respect log.showroot.

Absolutely, that would be a much better commit message. I'll wait and
see if there are more comments and then resubmit.

> Also the gitk should be mentioned in the man-page for git-config log.showroot.
> The current description of this option seems suboptimal because it explains
> how it used to be, which is not really relevant:
>   log.showroot
>     If true, the initial commit will be shown as a big creation event. This is
>     equivalent to a diff against an empty tree. Tools like git-log(1) or git-
>     whatchanged(1), which normally hide the root commit will now show it. True by
>     default.
> This could be changed to:
>     If true (the default), the root commit will be shown as a big creation
>     event --- a diff against an empty tree. This diff can be very large for
>     a project which was imported into git after some development history.
>     If log.showroot is false tools like git-log(1), git-whatchanged(1), or
>     gitk(1) will not display the added files.

I agree, but that feels like something that could be made into a
separate patch. Or should I include that too?

	Marcus
