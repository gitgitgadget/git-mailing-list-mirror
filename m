From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git guidance
Date: Sat, 8 Dec 2007 19:33:00 +1300
Message-ID: <46a038f90712072233v4ee1143cx68a82d15cfaa4402@mail.gmail.com>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com>
	 <alpine.LFD.0.9999.0711290810170.8458@woody.linux-foundation.org>
	 <200712010950.15628.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jing Xue" <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: "Al Boldi" <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 07:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0tFr-00060y-5S
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 07:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbXLHGdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 01:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbXLHGdF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 01:33:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:41979 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbXLHGdB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 01:33:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1120599ugc
        for <git@vger.kernel.org>; Fri, 07 Dec 2007 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Lb378plfUPAxx6Z0rk+Chg4piAlZF6YnTyrE7iEehQc=;
        b=heiUC/gqDk/O0W6/sVwQgywvspVg+EciHqSW3JLa1iQJTBMdhH7m0ZdbDaQLzN8gzx0UJWPktf2SOYQBk0uoiFnSCmO2/i6FQQ3Va6nxiClGvN62o84qZEU3htSCuabF4czGbMM0X1Qwz4nO299mF8fZe5ZEZx80f5KmXWBgkhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QeM6Zrd89amZ7E3GQFwzlrhIKUjbu9LzacKT9/w7gdxs1WmnK9D2LsRfN55qQkSlbzoKVspefLL84wdfW5NkL3UhpZIKt4cyC/Jtmln6le4YQtWrtnwflEbbH13Tl0MMbQvSgDAlvdCJQjEvrlcdpRQtgcpUhgOvbSnFHAFIxuE=
Received: by 10.66.243.2 with SMTP id q2mr3420298ugh.1197095580110;
        Fri, 07 Dec 2007 22:33:00 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Fri, 7 Dec 2007 22:33:00 -0800 (PST)
In-Reply-To: <200712010950.15628.a1426z@gawab.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67519>

On Dec 1, 2007 7:50 PM, Al Boldi <a1426z@gawab.com> wrote:
> Not sure what you mean by operationally transparent?  It would be transparent
> for the updating client,  and the rest of the git-users would need to wait
> for the commit from the updating client; which is ok, as this transparency
> is not meant to change the server-side git-update semantic.

I guess what he means is that when your write to the file -- from your
editor -- it can't be considered a commit. During an editing session
you might write a dozen times, only to commit it once you are happy
(that it compiles, passes tests, etc).

> Sure, you wouldn't want to change the git-engine update semantics, as that
> sits on the server and handles all users.  But what the git model is
> currently missing is a client manager.  Right now, this is being worked
> around by replicating the git tree on the client, which still doesn't
> provide the required transparency.

If you want a dumb-ish client CVS-style, you can try git-cvsserver.
But the git model is definitely superior -- "replicating the tree on
the client" is not a workaround but a central strategy.

Have you used git and other DSCMs much? From your writing, it sounds
like you may have misunderstood how some of the principles of git work
out in practice.

cheers,


m
