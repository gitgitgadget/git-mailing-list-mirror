From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/4] Remove deprecated commands
Date: Mon, 11 Nov 2013 18:38:53 +0000
Message-ID: <20131111183853.GP24023@serenity.lan>
References: <cover.1384098226.git.john@keeping.me.uk>
 <xmqq4n7in6c0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 19:39:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfwO9-0007DM-NV
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab3KKSjC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:39:02 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:45214 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab3KKSjA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:39:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id A112B6064D7;
	Mon, 11 Nov 2013 18:38:59 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y6Z8tbcg-odv; Mon, 11 Nov 2013 18:38:58 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 18D476064CD;
	Mon, 11 Nov 2013 18:38:55 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqq4n7in6c0.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237630>

On Mon, Nov 11, 2013 at 10:25:51AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > "git repo-config", "git tar-tree", "git lost-found" and "git
> > peek-remote" have all been deprecated since at least Git 1.5.4.
> >
> > With Git 2.0 approaching, I think that would be a good point to remove
> > then completely, which is what this series does.
> 
> Probably good material to discuss during the next cycle.
>
> As a totally unscientific sanity check, I asked Google to show these
> since Nov 13, 2011:
> 
>     [git repo-config] vs [git config]: 136 vs 232
> 
>     [git peek-remote] vs [git ls-remote]: 62 vs 133
> 
>     [git tar-tree] vs [git archive]: 73 vs 189
> 
>     [git lost-found] vs [git fsck --lost-found]: 96 vs 83
> 
> So I think 1, 2, and 4 are OK to ship in whatever version that comes
> after the upcoming 1.8.5, but we might have to hold onto lost-found
> a bit longer.  The command does show a deprecation warning, so there
> is nothing to change at this point.

I was assuming these would be queued as a "held until 2.0" branch, but
if you think some can go earlier I can re-send this once 1.8.5 is out of
the way.
