From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Mon, 29 Sep 2008 12:53:43 +0200
Organization: lilypond-design.org
Message-ID: <1222685623.9905.171.camel@heerbeest>
References: <1221120192.8962.7.camel@heerbeest>
	 <20080912110017.GW10360@machine.or.cz> <1221222433.29747.8.camel@heerbeest>
	 <20080912131530.GZ10360@machine.or.cz>
	 <20080912181442.GA5407@lapse.rw.madduck.net>
	 <1221648520.30402.12.camel@heerbeest>
	 <20080921142445.GJ10360@machine.or.cz> <1222074825.6698.13.camel@heerbeest>
	 <20080922152712.GN10360@machine.or.cz>
	 <1222175590.10363.14.camel@heerbeest>
	 <20080923132728.GV10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Jan Holesovsky <kendy@suse.cz>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Sep 29 17:20:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkKWc-0008L1-6i
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 17:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbYI2PRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 11:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYI2PRw
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 11:17:52 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:60189 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYI2PRv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 11:17:51 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 178C711E788;
	Mon, 29 Sep 2008 17:17:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 2316EDC07F;
	Mon, 29 Sep 2008 12:53:44 +0200 (CEST)
In-Reply-To: <20080923132728.GV10360@machine.or.cz>
X-Mailer: Evolution 2.24.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97020>

On di, 2008-09-23 at 15:27 +0200, Petr Baudis wrote:

> what we can't make to work is just the
> most generic case, but e.g. if master is a *leaf* branch nothing else
> depends on and it can't get the branch through multiple paths, you can
> do the dependency removal rather easily (if it can get through multiple
> paths, you can still do it but you might have to deal with big
> conflicts).

This already would be very nice and would probably remove the last
technical hurdle to switch.  Is it also easy to detect if a branch is
a leaf node?

>   But if you scenario indeed is totally generic, I'm afraid I don't know
> how to make TopGit remove dependencies, except perhaps for the price of
> massive complexity and massive slowdown (pretty much redoing all the
> history walking etc.). Maybe someone else comes by with a genial
> solution...

Ah, so the problem is about branches depending on a branch from which
a dependency is removed.  What is it that we need to be looking for
by history walking?  Can't we possibly keep/cache that info in a
special topgit file?

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
