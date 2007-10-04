From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: editing description of patch
Date: Thu, 4 Oct 2007 19:39:29 +0200
Message-ID: <20071004173929.GD21717@diana.vm.bytemark.co.uk>
References: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com> <9e4733910710031914r766efa88pad9f55f9495d127e@mail.gmail.com> <20071004082624.GA17778@diana.vm.bytemark.co.uk> <9e4733910710040616l5358099dj1b65b47cf94cf031@mail.gmail.com> <20071004154836.GB21717@diana.vm.bytemark.co.uk> <9e4733910710040945l2335f3d7le6f45510640d3a6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 19:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdUfn-0004sK-AV
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 19:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbXJDRjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755577AbXJDRjf
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 13:39:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2850 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbXJDRje (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 13:39:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IdUfZ-0006Ia-00; Thu, 04 Oct 2007 18:39:29 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910710040945l2335f3d7le6f45510640d3a6e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59989>

On 2007-10-04 12:45:17 -0400, Jon Smirl wrote:

> On 10/4/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > I've never thought of the patch names as anything that would make
> > sense to export from a repository (like reflogs), so using the
> > first line of the commit message for mail subject (like git does)
> > always seemed like a no-brainer. But then I don't have any
> > experience using quilt or any related tool.
>
> Why are the patch name and the short description independent
> variables? Wouldn't it make more sense to treat these as a single
> unified item? If I rename the patch it would automatically edit the
> first line of the description, etc...

I guess Catalin would have to answer that -- it's "always" been like
that. But one obvious problem are patches with identical messages --
just today I created a series of seven patches that all had "debug"
for a message. Another is that you usually want descriptive commit
messages, but may want short and easy-to-type patch names.

> When importing a patch from a saved email, stg should strip all the
> email headers out of the description. I have to manually fix that
> up.

Do you do "stg import -M"? That's for importing one or more patches
contained in an mbox. Without the -M, I think the default is to expect
plain diff input.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
