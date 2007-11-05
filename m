From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Cogito is deprecated, so don't point to it
Date: Mon, 5 Nov 2007 13:00:14 +0100
Message-ID: <20071105120014.GA17406@diana.vm.bytemark.co.uk>
References: <20071105030608.6033.35208.stgit@yoghurt> <vpqejf510ci.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 05 13:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip0dV-0001OJ-7M
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656AbXKEMAj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 07:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbXKEMAj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:00:39 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2493 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656AbXKEMAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:00:38 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ip0co-0004Z4-00; Mon, 05 Nov 2007 12:00:14 +0000
Content-Disposition: inline
In-Reply-To: <vpqejf510ci.fsf@bauges.imag.fr>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63499>

On 2007-11-05 10:57:17 +0100, Matthieu Moy wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > -directly). For standard SCM operations, either use plain GIT comma=
nds
> > -or the Cogito tool but it is not recommended to mix them with the
> > -StGIT commands.
> > +directly). For standard SCM operations, use plain GIT commands.
>
> Doesn't the "but it is not recommended to mix them with the StGIT
> commands." part still hold?

I'm not sure it ever held. Except possibly during merge resolution,
but that mismatch is going away with the patch series by David K=E5geda=
l
that's sitting in kha/experimental (which changes StGit to use exactly
the same conflict representation as git).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
