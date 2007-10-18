From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Howto request: going home in the middle of something?
Date: Thu, 18 Oct 2007 13:07:26 +0200
Message-ID: <20071018110726.GA3936@diana.vm.bytemark.co.uk>
References: <200710181144.22655.wielemak@science.uva.nl> <4717377E.1010604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 13:08:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiTET-00074a-BS
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 13:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbXJRLHv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 07:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761271AbXJRLHv
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 07:07:51 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4755 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755347AbXJRLHu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 07:07:50 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IiTDq-0001CW-00; Thu, 18 Oct 2007 12:07:26 +0100
Content-Disposition: inline
In-Reply-To: <4717377E.1010604@viscovery.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61515>

On 2007-10-18 12:37:50 +0200, Johannes Sixt wrote:

> Jan Wielemaker schrieb:
>
> > I've somewhere seen it in a mail, but I can't find it anymore. I
> > have a bare central (public) repository and clones on various
> > machines I work on. We all know it, you're right in the middle of
> > something and it is really time to go home. You want to pick up
> > your work at home, but without pushing to the shared repository.
> >
> > I'm sure GIT can do this elegantly, but I'm not yet sure how. I
> > guess Ideally I want "git stash" at work, transfer the stashed
> > changes to my other machine and apply them. How do I do that?
>
> One way is to use a bundle:

Another way is to push the unfinished changes to a temp branch, either
at the same central repository if it's acceptable for people to have
temp branches there, or at another repository where temp branches
_are_ permitted. All you need to set up a private repository for
yourself is an ssh account somewhere. Or you could store the
repository on an usb stick.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
