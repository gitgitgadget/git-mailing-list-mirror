From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Cogito is deprecated, so don't point to it
Date: Mon, 5 Nov 2007 13:16:56 +0100
Message-ID: <20071105121656.GA17700@diana.vm.bytemark.co.uk>
References: <20071105030608.6033.35208.stgit@yoghurt> <vpqejf510ci.fsf@bauges.imag.fr> <20071105120014.GA17406@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip0tQ-0005uT-6A
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbXKEMRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 07:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbXKEMRF
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:17:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2827 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbXKEMRE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:17:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ip0sy-0004dX-00; Mon, 05 Nov 2007 12:16:56 +0000
Content-Disposition: inline
In-Reply-To: <20071105120014.GA17406@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63503>

On 2007-11-05 13:00:14 +0100, Karl Hasselstr=F6m wrote:

> On 2007-11-05 10:57:17 +0100, Matthieu Moy wrote:
>
> > Doesn't the "but it is not recommended to mix them with the StGIT
> > commands." part still hold?
>
> I'm not sure it ever held. Except possibly during merge resolution,
> but that mismatch is going away with the patch series by David
> K=E5gedal that's sitting in kha/experimental (which changes StGit to
> use exactly the same conflict representation as git).

Mmm. Then there's of course the fact that if you use git commands to
change the branch ref (e.g. committing, resetting, and so on) you need
to run assimilate to deconfuse StGit. But it'll tell you so.

So I guess the (or at least my) conclusion is that we ought to have an
StGit User Manual where the user can learn these things, preferably
with examples and pretty DAG graphs. Half a sentence doesn't buy us
that much.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
