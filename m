From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 3/4] Convert git_id() to the new id format
Date: Mon, 14 Jul 2008 08:44:34 +0200
Message-ID: <20080714064434.GE20751@diana.vm.bytemark.co.uk>
References: <20080619214023.27794.97039.stgit@localhost.localdomain> <20080619214222.27794.74083.stgit@localhost.localdomain> <20080622154854.GC4468@diana.vm.bytemark.co.uk> <b0943d9e0807130420v37e36f30sef8b7745fa55b688@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIHoa-0004RH-Jg
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbYGNGom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 02:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752575AbYGNGom
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:44:42 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4632 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbYGNGol (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:44:41 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KIHnW-0005ki-00; Mon, 14 Jul 2008 07:44:34 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807130420v37e36f30sef8b7745fa55b688@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88384>

On 2008-07-13 12:20:25 +0100, Catalin Marinas wrote:

> 2008/6/22 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Very nice parameter rename here, now that we have Branch objects
> > (and use a crappy language with no type system).
>
> It has a type system but no compile-time checking

Yeah, that's what I meant.

> (I'm more in favour of static typing but no time to rewrite stgit
> :-)).

Me too.

> > The corresponding TODO comment now would be that pick should be
> > able to pick patches from the past, from the stack log.
>
> How would the syntax look like?

We'd want to support <committish>:patch, for any committish that's a
stack log (either simplified or full). Not sure if we'd want a more
pretty-looking format as well.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
