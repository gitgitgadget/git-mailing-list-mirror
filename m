From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Mon, 22 Sep 2008 11:13:45 +0200
Organization: lilypond-design.org
Message-ID: <1222074825.6698.13.camel@heerbeest>
References: <20080909231009.GD10544@machine.or.cz>
	 <1221120192.8962.7.camel@heerbeest> <20080912110017.GW10360@machine.or.cz>
	 <1221222433.29747.8.camel@heerbeest> <20080912131530.GZ10360@machine.or.cz>
	 <20080912181442.GA5407@lapse.rw.madduck.net>
	 <1221648520.30402.12.camel@heerbeest>
	 <20080921142445.GJ10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Sep 22 11:20:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhhbB-0002JJ-24
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 11:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbYIVJTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 05:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbYIVJTp
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 05:19:45 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:49690 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbYIVJTo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 05:19:44 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id 16FB367873;
	Mon, 22 Sep 2008 11:19:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 927CCDC24E;
	Mon, 22 Sep 2008 11:19:42 +0200 (CEST)
In-Reply-To: <20080921142445.GJ10360@machine.or.cz>
X-Mailer: Evolution 2.23.91 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96468>

On zo, 2008-09-21 at 16:24 +0200, Petr Baudis wrote:

> The problem is that you can undo the merge content, but not the history
> information. So this revert can e.g. propagate even into branches which
> still *should* depend on the other branch, you get into trouble when you
> want to make your branch depend on the other one anyway, etc.

Ah, yes.  I see.  Does this mean that functionality for easy adding and
removing dependencies/patches from a branch can only be provided through
some sort of [unpublishable] patch based mechanism like stgit?

Possibly we'd need a kind of setup where stgit-like patch branches
can be "finalized" into topgit branches.  Hmm.

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
