From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Tutorial: Importing patches
Date: Wed, 29 Oct 2008 11:28:14 +0100
Message-ID: <20081029102814.GA30762@diana.vm.bytemark.co.uk>
References: <20081028204223.9539.89315.stgit@yoghurt> <b0943d9e0810281509r109ee2dby51ee13a250700012@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 11:29:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv8Iu-0004pN-Vo
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 11:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbYJ2K2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Oct 2008 06:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbYJ2K2T
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 06:28:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3687 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbYJ2K2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 06:28:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kv8He-00080Z-00; Wed, 29 Oct 2008 10:28:14 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0810281509r109ee2dby51ee13a250700012@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99358>

On 2008-10-28 22:09:52 +0000, Catalin Marinas wrote:

> 2008/10/28 Karl Hasselstr=F6m <kha@treskal.com>:

> > +The e-mail should be in standard Git mail format (which is what e.=
g.
> > +stglink:mail[] produces) -- that is, with the patch in-line in the
> > +mail, not attached. The authorship info is taken from the mail
> > +headers, and the commit message is read from the 'Subject:' line a=
nd
> > +the mail body.
>
> It actually supports importing diffs from attachments as well as
> long as they are text/plain (the description is expected in the mail
> body).

Yeah, I had a vague recollection that that might be the case, but the
test suite doesn't cover it, and I've actually tried it a few times
and it's never worked for me.

> Anyway, I think we don't have to mention this in the tutorial as
> most people would use the Git mail format anyway.

Yes.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
