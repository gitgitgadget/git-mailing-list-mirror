From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Tue, 31 Mar 2009 09:27:01 +0200
Message-ID: <20090331072701.GA7730@diana.vm.bytemark.co.uk>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com> <20090323084507.GA6447@diana.vm.bytemark.co.uk> <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com> <20090324131640.GB4040@diana.vm.bytemark.co.uk> <b0943d9e0903240840m3f22b702qd48293caad4187e3@mail.gmail.com> <20090325090541.GA24889@diana.vm.bytemark.co.uk> <b0943d9e0903250324j9ed0ed9k2d97cbacba6a7801@mail.gmail.com> <20090326111554.GA19337@diana.vm.bytemark.co.uk> <b0943d9e0903300901i469bd899v3518b43c331bd9df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 09:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoYOq-0006Hg-H8
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 09:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbZCaH1M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 03:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbZCaH1L
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 03:27:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:44005 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbZCaH1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 03:27:10 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LoYNB-0002HR-00; Tue, 31 Mar 2009 08:27:01 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0903300901i469bd899v3518b43c331bd9df@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115231>

On 2009-03-30 17:01:12 +0100, Catalin Marinas wrote:

> 2009/3/26 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-03-25 10:24:13 +0000, Catalin Marinas wrote:
> >
> > > BTW, why don't we keep the tree information directly in the
> > > Index object? Since this object is modified only via its own
> > > interface, it can do all the checks and avoid the managing of
> > > temp_index_tree in the Transaction object.
> >
> > I guess that might be a good idea -- it should be doable without
> > any extra overhead for users that don't want it.
>
> I tried but gave up quickly. The IndexAndWorktree class also dirties
> the Index with the merge operations, so it is not worth the hassle.

OK. (Though you should be able to set the tree to None for those
cases, since the meaning of None is simply that we don't promise
anything about what tree is currently in the index.)

And since I've run out of even remotely plausible things to complain
about,

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
