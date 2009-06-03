From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Re: [PATCH] Add USER environment variable to executed git
	commands when serving
Date: Wed, 3 Jun 2009 14:02:01 -0700
Message-ID: <20090603210201.GP3355@spearce.org>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com> <20090602135659.GA4320@macbook.lan> <2e24e5b90906021804tf3db263qc41a6f8b171111e1@mail.gmail.com> <2e24e5b90906022324pe6769d5vfa5e3eec44daeaf3@mail.gmail.com> <20090603202701.GA8739@macbook.lan> <robbat2-20090603T204719-922480112Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Git Mailing List <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>, tv@eagain.net
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:02:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBxbB-0004DH-6A
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbZFCVCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbZFCVCA
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:02:00 -0400
Received: from george.spearce.org ([209.20.77.23]:57515 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbZFCVB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 17:01:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7B612381D1; Wed,  3 Jun 2009 21:02:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <robbat2-20090603T204719-922480112Z@orbis-terrarum.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> wrote:
> On Wed, Jun 03, 2009 at 10:27:02PM +0200, Heiko Voigt wrote:
> > You are welcome. An interesting addition would be to propagate allowed
> > branchnames from gitosis.conf. That way you can implement write-
> > protected branches using an update hook.
> ...
> > A nice solution to steer this directly from gitosis.conf? I never got
> > around implementing it.
> Has anybody implemented something like cvs_acls.pl (used by FreeBSD) for
> Git?

contrib/hooks/update-paranoid ?

Perhaps the most flexible, and most paranoid, update hook available.
But it does require that the frontend set some sort of user identity.
I think it relies on UNIX uid, but its easy to hack to use an env
var instead from gitosis.

-- 
Shawn.
