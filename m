From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Git issues with submodules
Date: Fri, 29 Nov 2013 23:50:40 +0100
Message-ID: <20131129225040.GB31636@sandbox-ub>
References: <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net>
 <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
 <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
 <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
 <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
 <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <xmqq61rgxkx2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 29 23:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmWtb-0001pi-PV
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 23:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320Ab3K2Wuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 17:50:44 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:40630 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab3K2Wun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 17:50:43 -0500
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VmWtW-0006hy-0i; Fri, 29 Nov 2013 23:50:42 +0100
Content-Disposition: inline
In-Reply-To: <xmqq61rgxkx2.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238541>

On Mon, Nov 25, 2013 at 12:53:45PM -0800, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > What I think needs fixing here first is that the ignore setting should not
> > apply to any diffs between HEAD and index. IMO, it should only apply
> > to the diff between worktree and index.
> 
> Hmph.  How about "git diff $commit", the diff between the worktree and
> a named commit (which may or may not be HEAD)?

Thats an interesting question. My first thought was that I would expect
it to not show submodules since it involves the worktree, but then I could
also argue that it should only show differences between whats in the
index and the given commit. That would make matters more complicated but
I image the use case (floating submodules) involves not caring
about submodules except for some integration points when submodule sha1's
are explicitly recorded. I would expect to only see diffs between these
integration points. But then I am not a big user (none at all at the
moment) of the floating model.

Cheers Heiko
