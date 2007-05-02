From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT RFC PATCH] Don't use refs/bases/<branchname>
Date: Wed, 2 May 2007 15:10:11 +0200
Message-ID: <20070502131011.GA13426@diana.vm.bytemark.co.uk>
References: <20070429220832.5832.251.stgit@yoghurt> <b0943d9e0705010137q4a35f818m7dbbc9d2e77e2fcf@mail.gmail.com> <e5bfff550705010210i352ac9eej6ff7a78aae6535c9@mail.gmail.com> <20070501185615.GA32727@diana.vm.bytemark.co.uk> <e5bfff550705011259w567a98dj6d0a68b0fbe90994@mail.gmail.com> <20070502065054.GA9919@diana.vm.bytemark.co.uk> <e5bfff550705020417h14f6297fu957eb64e58119770@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 15:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjEb7-0001WV-Q2
	for gcvg-git@gmane.org; Wed, 02 May 2007 15:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993142AbXEBNKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 2 May 2007 09:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993143AbXEBNKS
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 09:10:18 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4962 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993142AbXEBNKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 09:10:16 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HjEax-0003hS-00; Wed, 02 May 2007 14:10:11 +0100
Content-Disposition: inline
In-Reply-To: <e5bfff550705020417h14f6297fu957eb64e58119770@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46019>

On 2007-05-02 13:17:01 +0200, Marco Costalba wrote:

> On 5/2/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > It's not near the top of my kill list by any stretch of the
> > imagination, so no need to worry. And even if it were, Catalin
> > would certainly stand as a wall of sanity between qgit and my
> > chain saw. :-)
>
> Currently I check for the existence of <git dir>/patches directory
> as a quick exit in case a repository does NOT have a StGIT repo on
> it (the common case).
>
> This avoids a costly and 99% of cases not needed 'stg <something>'
> call.
>
> I ask if it will be still a safe check in the long period or it is
> better to change the check to something else (as existence of
> <git dir>/refs/patches) instead ?

I personally have no plan to attempt to remove all of .git/patches --
a lot of data in there is redundant, but certainly not all of it, and
there's no compelling reason to move it. But Catalin has the final
word, of course.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
