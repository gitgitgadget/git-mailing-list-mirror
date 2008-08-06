From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/{stable,safe,experimental} updated
Date: Wed, 6 Aug 2008 12:18:13 +0200
Message-ID: <20080806101813.GC18336@diana.vm.bytemark.co.uk>
References: <20080725013936.GA20959@diana.vm.bytemark.co.uk> <b0943d9e0807270144n359e5bd3ye3e91c52b8fa7beb@mail.gmail.com> <20080801102208.GA29413@diana.vm.bytemark.co.uk> <b0943d9e0808051433i667f6a05iff1a5220e37602e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 11:57:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQflm-00081r-64
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 11:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758375AbYHFJ4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 05:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbYHFJ4X
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 05:56:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1977 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208AbYHFJ4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 05:56:22 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQg5t-0004rb-00; Wed, 06 Aug 2008 11:18:13 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0808051433i667f6a05iff1a5220e37602e7@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91498>

On 2008-08-05 22:33:57 +0100, Catalin Marinas wrote:

> 2008/8/1 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Heh. It's _always_ your main worry. But rightly so, since mistakes
> > could be costly. Thanks for spending time on this with me.
>
> I'm usually worried about performance but will give it a try with a
> Linux kernel and real patches. Have you done any tests to compare it
> with my master branch?

Yes. I posted the benchmark results a while back -- as I recall, the
performance was about the same for large uncommit and rebase
operations.

Also, I'm currently investigating some possible optimizations. Will
post new bechmarks afterwards, if I get something working.

> Would we even need to prune the stack history? It might get pretty
> large after about 1-2 years of usage.

Yes, it's growing without bound, so eventually one would have to prune
it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
