From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 4/4] Add optional logging of subprocess execution
Date: Wed, 29 Aug 2007 13:11:02 +0200
Message-ID: <20070829111102.GA29980@diana.vm.bytemark.co.uk>
References: <20070826202724.16265.85821.stgit@yoghurt> <20070826203344.16265.66280.stgit@yoghurt> <b0943d9e0708290350rbadfe08g9bbab7888723980e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 13:11:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQLST-0002AX-9A
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 13:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083AbXH2LLJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 07:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755175AbXH2LLI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 07:11:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4390 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033AbXH2LLI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 07:11:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IQLRu-0007oN-00; Wed, 29 Aug 2007 12:11:02 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0708290350rbadfe08g9bbab7888723980e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56935>

On 2007-08-29 11:50:11 +0100, Catalin Marinas wrote:

> On 26/08/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Now that the subprocess calling has been refactored and is in a
> > nice shape, it's quite simple to add some logging facilities. This
> > patch adds two separate log modes, switched by the
> > STG_SUBPROCESS_LOG environment variable:
>
> Any objection to calling this variable STGIT_SUBPROCESS_LOG? We
> already have STGIT_DEBUG_LEVEL (used in stgit.main). I can do it in
> my tree before pushing as I already merged your branches.

No, no objection at all. I was simply too lazy to actually check what
the existing naming convention was, and misremembered.

> BTW, thanks for refactoring the subprocess calling.

It needed doing, and was actually fun.

Any chance we can drop Python 2.3 support any time soon, by the way?
I've confined all the ickyness to one place, but it would still be
good to get rid of it (not to mention being able to use sets and
generator expressions).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
