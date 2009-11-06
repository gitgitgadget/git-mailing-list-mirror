From: Petr Baudis <pasky@suse.cz>
Subject: Re: Automatically remote prune
Date: Fri, 6 Nov 2009 11:31:00 +0100
Message-ID: <20091106103100.GG17748@machine.or.cz>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
 <7v639qi2un.fsf@alter.siamese.dyndns.org>
 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
 <7viqdpemki.fsf@alter.siamese.dyndns.org>
 <43d8ce650911050005l6d120cb0h374f3c04b3948b25@mail.gmail.com>
 <7v3a4sagau.fsf@alter.siamese.dyndns.org>
 <76718490911051509r65af2dd2k2574e2e521fed6f2@mail.gmail.com>
 <20091106001751.GF17748@machine.or.cz>
 <76718490911051638w7cd5306bx65ed8d9ac525d2c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 11:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6M60-0006Po-O8
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 11:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351AbZKFKa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 05:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755996AbZKFKa5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 05:30:57 -0500
Received: from w241.dkm.cz ([62.24.88.241]:45642 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755542AbZKFKa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 05:30:57 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id B6C7C8620A6; Fri,  6 Nov 2009 11:31:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <76718490911051638w7cd5306bx65ed8d9ac525d2c3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132297>

On Thu, Nov 05, 2009 at 07:38:39PM -0500, Jay Soffian wrote:
> On Thu, Nov 5, 2009 at 7:17 PM, Petr Baudis <pasky@suse.cz> wrote:
> > On Thu, Nov 05, 2009 at 06:09:03PM -0500, Jay Soffian wrote:
> >> Actually, mirror mode applies to push only. Unless I'm missing
> >> something obvious.
> >
> > Perhaps you are, mirror mode applies to fetch as well; that's how e.g.
> > repo.or.cz mirror mode is done currently.
> 
> Can you please be more specific? There is no mention of mirror in
> builtin-fetch.c, only builtin-push.c. Further, the docs for
> "remote.<name>.mirror" indicate it's a push option only.
> 
> So please explain what you mean by "that's how repo.or.cz mirror mode is done".

Ok, I got a bit confused there. :-) For fetches, it just sets up the
refspec to point to main namespace instead of refs/remote/, of course it
doesn't use the remote.*.mirror config. I'm not sure what Junio meant by
the change being easy, seeing that push uses a technical trick in
send-pack that doesn't seem to be straightforwardly applicable to
fetch... but I don't know this part of code too well.

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
