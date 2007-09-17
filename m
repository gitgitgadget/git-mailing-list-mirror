From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] It doesn't make sense to sink below an unapplied patch
Date: Mon, 17 Sep 2007 11:49:28 +0200
Message-ID: <20070917094928.GC8657@diana.vm.bytemark.co.uk>
References: <20070914002031.GC23330@diana.vm.bytemark.co.uk> <20070914005231.17533.17120.stgit@yoghurt> <9e4733910709131822s3c519a3bj7e42c0ecaa89fb6e@mail.gmail.com> <20070914060456.GA27014@diana.vm.bytemark.co.uk> <9e4733910709140715g3cc3e47fu2eb24eed6d4e2c08@mail.gmail.com> <20070914150609.GA319@diana.vm.bytemark.co.uk> <9e4733910709140918wbe94b5eu6ec326b25b0f3d42@mail.gmail.com> <20070915232252.GA25507@diana.vm.bytemark.co.uk> <87veaab93v.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXDEc-00008f-8R
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbXIQJtf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 05:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbXIQJtf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:49:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2192 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbXIQJte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:49:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IXDEO-0002fv-00; Mon, 17 Sep 2007 10:49:28 +0100
Content-Disposition: inline
In-Reply-To: <87veaab93v.fsf@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58421>

On 2007-09-16 23:20:36 +0200, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > Another idea that's been kicked around is to have a general
> > reorder command, that spawns an editor and lets you move around
> > (and delete) patch names until you're satisfied. (This too would
> > be implemented in terms of push and pop of single patches.)
>
> This of course sounds very much like "git rebase -i", but the
> semantics would maybe not be identical.

=46or one, the StGit version would have to update StGit's metadata. :-)

> One feature from rebase I'd like to see if this was implemented is
> the "squash" option to join two patches. But it would probably be
> called "fold" to keep with stgit terminology.

I actually started to write such a command this weekend, but I didn't
have time to finish it. I did however come to the conclusion that I'd
want to refactor the relationship between patches and commits first.
(Which was why I was so pleasantly surprised that you spent part of
the weekend doing precisely that!)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
