From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Submodules as first class citizens (was Re: Moving to subtrees
 for plugins?)
Date: Mon, 15 Jun 2015 11:03:54 +0200
Message-ID: <20150615090354.GA8048@book.hvoigt.net>
References: <CABURp0og9i9S3_ZWf5Ce9LT785QJo4H-TVtFaKUTXr2N7FB+ew@mail.gmail.com>
 <D2BB8369-E552-4AC3-967E-8F963206E03C@gmail.com>
 <5573E40A.3020502@gmail.com>
 <5577330E.3060803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Repo Discussion <repo-discuss@googlegroups.com>,
	Git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 15 11:04:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4QJc-00026k-GU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 11:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710AbbFOJEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 05:04:14 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:51857 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755698AbbFOJEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 05:04:04 -0400
Received: from [178.11.201.3] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Z4QIc-0006Df-0X; Mon, 15 Jun 2015 11:03:22 +0200
Content-Disposition: inline
In-Reply-To: <5577330E.3060803@web.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271667>

On Tue, Jun 09, 2015 at 08:40:14PM +0200, Jens Lehmann wrote:
> Am 07.06.2015 um 08:26 schrieb Stefan Beller:
> >On 06.06.2015 12:53, Luca Milanesio wrote:
> >>>On 6 Jun 2015, at 18:49, Phil Hord <phil.hord@gmail.com> wrote:
> >>>On Fri, Jun 5, 2015, 2:58 AM lucamilanesio <luca.milanesio@gmail.com> wrote:
> >>>>Ideally, as a "git clone --recursive" already exists, I would like to
> >>>>see a "git diff --recursive" that goes through the submodules as well :-)
> >>>>
> >>>>Something possibly to propose to the Git mailing list?
> 
> Such an option makes lots of sense to me (though "--recurse-submodules"
> should be its name for consistency reasons). This could be an alias for
> "--submodule=full", as the "--submodule" option controls the format of
> submodule diffs.

BTW, for long running topics (or low hanging fruits) we collect/link
everything in the wiki of Jens git fork on github. This is the central
page:

https://github.com/jlehmann/git-submod-enhancements/wiki

Maybe everyone that has work in the queue can add his work there (the work that
takes more time) so we can avoid doubling any effort. Not everything there is
up to date at the moment but I will look into it to remove outdated things.

> >>>I've worked on git diff --recursive a bit myself, along with some
> >>>simpler use cases (git ls-tree --recursive) as POCs. I think some of
> >>>the needs there begin to have ui implications which could be
> >>>high-friction. I really want to finish it someday, but I've been too
> >>>busy lately at $job, and now my experiments are all rather stale.
> >>>
> >>>It would be a good discussion to have over at the git list (copied).
> >>>Heiko and Jens have laid some new groundwork in this area and it may
> >>>be a good time to revisit it.  Or maybe they've even moved deeper than
> >>>that; I have been distracted for well over a year now.
> >>>
> >
> >Glad you're working (or planning to) working on submodulues. This is
> >also on my todo list for the next months as well.
> 
> More hands are always welcome!
> 
> >I'd review stuff in that area if you're looking for reviewers.
> 
> I'll be happy help too.

Me too.

Cheers Heiko
