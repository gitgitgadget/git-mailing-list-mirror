From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Android Replies to Git List getting rejected
Date: Tue, 7 Aug 2012 17:39:38 -0400
Message-ID: <20120807213938.GC3953@thunk.org>
References: <CAM9Z-nmEDTEN0Em-nY+y5g0kRMsNuy-pn8Lzr_mWSU7engj6JQ@mail.gmail.com>
 <50216D83.6080707@kernel.org>
 <20120807205524.GA3953@thunk.org>
 <CAPZPVFZJkxK50eA+saMKLHAc=wCioTFF0PVw=Xhcrf3GpzPydA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Drew Northup <n1xim.email@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 23:40:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyrVr-00072W-BU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 23:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab2HGVkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 17:40:04 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:43508 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072Ab2HGVjq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 17:39:46 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.72)
	(envelope-from <tytso@thunk.org>)
	id 1SyrV3-0004nG-Kd; Tue, 07 Aug 2012 21:39:37 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id D77022412CB; Tue,  7 Aug 2012 17:39:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAPZPVFZJkxK50eA+saMKLHAc=wCioTFF0PVw=Xhcrf3GpzPydA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203049>

On Tue, Aug 07, 2012 at 05:25:02PM -0400, Eugene Sajine wrote:
> <rant>
> Don't want to accept HTML messages - fine. But don't tell me which
> program to use for my email, especially when I'm sending totally valid
> message, so take my plain text message part and use it.
> </rant>

The problem is that HTML messages is a really good signal for SPAM and
exploits sent by spambots trying to break into Windows machines.  So
from the perspective of keeping the vger lists spam-free, it works
very well.  Also, from a practical point of view, most of the mailers
which send HTML also tend to mangle patches, and since most of the
vger lists are very developer centric, having users use MUA's that
mangle patches is highly unfortunate.

So having a hard requirement has been often useful for developers who,
say, are unfortunate enough to work at a company that mandates the use
of Lotus Notes, since it's a nice way to force the company to set up
an alternate IMAP/SMTP infrastructure for developers who need to
interact with the Linux Kernel community.  Speaking as someone who
used to work at IBM's Linux Technology Center, let me assure you there
are some unappreciated, but still very valid, side effects of the
current policies in force on vger.

There are other solutions to the spam problem, of course --- such as
diverting all of vger's mail through Postini, which is uses the same
anti-spam technology that GMail uses, and which is pretty good.  (Far
better than Symantec's anti-virus filtering service, which is what
mit.edu uses, so I've had experience with both.)

But the tin foil hat community would probably be all suspicious about
routing all of vger through Google's servers, even though pretty much
all of the vger mailing lists are archived on web sites such as
Gmane....  and truth to tell, the current solution which VGER has for
filtering spam works pretty well, all things considered.  It's rather
unfortunate that Android-only GMail users are an unintended casualty.

						- Ted
