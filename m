From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 09/13] Clear up the semantics of Series.new_patch
Date: Wed, 10 Oct 2007 09:45:17 +0200
Message-ID: <20071010074517.GC12970@diana.vm.bytemark.co.uk>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070914223154.7001.12254.stgit@morpheus.local> <b0943d9e0710080616r36142946m3e24d2f6893287c9@mail.gmail.com> <20071008132524.GA11253@diana.vm.bytemark.co.uk> <b0943d9e0710091401s280b3a12md9e700fb3ae007bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 09:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfWHO-0002B2-UE
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 09:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbXJJHqp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 03:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbXJJHqp
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 03:46:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1282 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbXJJHqo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 03:46:44 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IfWFp-0003SI-00; Wed, 10 Oct 2007 08:45:17 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0710091401s280b3a12md9e700fb3ae007bf@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60476>

On 2007-10-09 22:01:44 +0100, Catalin Marinas wrote:

> On 08/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2007-10-08 14:16:10 +0100, Catalin Marinas wrote:
> >
> > > It seems to work OK if I comment it out but I wonder whether it
> > > will break in the future with the planned removal of the top and
> > > bottom files.
> >
> > I think the assert represents a real constraint, namely that there
> > has to be a 1:1 correspondance between patches and commits.
> >
> > Couldn't "stg pick --reverse" create a new commit and use that?
> > That is, given that we want to revert commit C, create a new
> > commit C* with
>
> Series.new_patch already creates a commit, why should we move the
> functionality to 'pick'?

I didn't say that. :-) You could accomplish the commit creation by
calling Series.new_patch if you like.

> The only call to new_patch with commit=3DFalse seems to be from
> 'uncommit' (and it makes sense indeed).

Yes. For uncommit anything else would be insane.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
