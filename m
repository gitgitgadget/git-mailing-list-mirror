From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Recover from a bad push in StGit
Date: Mon, 21 Aug 2006 17:03:59 +0200
Organization: Dewire
Message-ID: <200608211703.59873.robin.rosenberg.lists@dewire.com>
References: <200608190030.47257.robin.rosenberg.lists@dewire.com> <tnxk652torl.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 17:15:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFBLP-000763-LU
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 17:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422674AbWHUPFV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 Aug 2006 11:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422678AbWHUPFV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 11:05:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:37664 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1422674AbWHUPFS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 11:05:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 29B9A802851;
	Mon, 21 Aug 2006 17:03:03 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18698-04; Mon, 21 Aug 2006 17:03:02 +0200 (CEST)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by torino.dewire.com (Postfix) with ESMTP id CDECD80264C;
	Mon, 21 Aug 2006 17:03:00 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: KMail/1.9.4
In-Reply-To: <tnxk652torl.fsf@arm.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25796>

m=E5ndag 21 augusti 2006 11:35 skrev Catalin Marinas:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > I recently did some reordering of patches and goofed up (not totall=
y, but
> > anyway). I pushed a number of patches and forgot one in the middle
> > resulting in a merge  conflict. Pop won't work since I have local c=
hanges
> > from the conflict and I don't want to resolve the conflict either s=
ince I
> > didn't mean to push the patch at that point.
> >
> > Is there a simple way of undoing a bad push?
> >
> > In this case I had a fresh export do help me out so I could just de=
lete
> > the patches and re-import them again, but what if I didn't?
>
> "stg push --undo" (the same option for "refresh"; maybe I should add =
a
> separate "undo" command) resets the local changes and it restores the
Not necessarily, but a hint about --undo when push/pop fail would have
helped me.

> original boundaries of the patch (no information is lost). You could
> use the latest snapshot as it has some bug-fixes from release 0.10.

Does refresh --undo make me see the state of the patch like it was befo=
re last=20
refresh, ie. stgit remembers the history of my patces? I thought it dro=
pped=20
the references as obsolete.

-- robin
