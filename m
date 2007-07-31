From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git.el: Support for incremental status updates.
Date: Tue, 31 Jul 2007 13:14:38 +0200
Message-ID: <20070731111438.GA17903@diana.vm.bytemark.co.uk>
References: <87sl7ekt40.fsf@wine.dyndns.org> <20070730232226.GA2413@diana.vm.bytemark.co.uk> <87k5shudz7.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Jul 31 13:15:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFpgy-0000X3-Qh
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 13:15:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbXGaLOw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 07:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbXGaLOw
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 07:14:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2765 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbXGaLOv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 07:14:51 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IFpgU-0004gR-00; Tue, 31 Jul 2007 12:14:38 +0100
Content-Disposition: inline
In-Reply-To: <87k5shudz7.fsf@morpheus.local>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54333>

On 2007-07-31 11:19:56 +0200, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > On 2007-07-24 12:12:47 +0200, Alexandre Julliard wrote:
> >
> > > +    (if node (ewoc-set-data node info) (ewoc-enter-last status i=
nfo))))
> >
> > My emacs doesn't like this. When i do "a" or "U" (and quite
> > possibly others that I haven't tried yet) I get
> >
> >   git-insert-fileinfo: Symbol's function definition is void: ewoc-s=
et-data
>
> You probably need to add a (require 'ewoc). Try loading ewoc and run
> the command again.

git.el already requires ewoc. And it uses a number of ewoc functions
(and has done so since its creation); this newly introduced call is
the only one that fails.

Also, I've just discovered that with Emacs 22.1, I don't see this
problem. So my guess is that ewoc-set-data is newer than Emacs 21.4.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
