From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Some ideas for StGIT
Date: Thu, 23 Aug 2007 16:34:11 +0200
Message-ID: <20070823143411.GA16051@diana.vm.bytemark.co.uk>
References: <1186163410.26110.55.camel@dv> <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com> <20070806095623.GA23349@diana.vm.bytemark.co.uk> <1186404125.10627.30.camel@dv> <20070806135204.GC23349@diana.vm.bytemark.co.uk> <b0943d9e0708230709o6ae16d5dvcfeba2f344f57fa5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 16:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IODlT-0001Gt-5h
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 16:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760649AbXHWOeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 10:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759972AbXHWOeX
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 10:34:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4795 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760532AbXHWOeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 10:34:22 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IODlD-0004Bo-00; Thu, 23 Aug 2007 15:34:11 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0708230709o6ae16d5dvcfeba2f344f57fa5@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56502>

On 2007-08-23 15:09:48 +0100, Catalin Marinas wrote:

> On 06/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2007-08-06 08:42:05 -0400, Pavel Roskin wrote:
> >
> > > Purely from the code standpoint, yes, it should be a separate
> > > command. But it may be practical to have both in one command,
> > > since I commonly need to change the description after changing
> > > the code.
> >
> > Sure. I don't have any objection to making
> >
> >   stg refresh -e
> >
> > be equivalent to
> >
> >   stg refresh && stg edit-patch-message <topmost-patch>
>
> The only objection is the long command name - 'stg edit [<patch>]'
> would be just fine.

Oh, I chose a ridiculously long name on purpose, to make it
unambiguous while at the same time not implying that I had a good name
already thought out. :-)

> It would also be nice to do (with an additional option), the
> equivalent of export - edit - import in case one wants to also
> modify the diff.

Yes. This is probably one of the most asked-for (and least
implemented) features of StGIT.

> > What I'm objecting to is being forced to refresh when I just want
> > to edit the message. (And, to a lesser degree, having to manually
> > push and pop to make the patch topmost before I can edit its
> > message.)
>
> Not necessarily - 'stg refresh -e -p <patch>' does the pop/push for
> you and it even uses the fast-forwarding.

Hmm, that's better. But it shouldn't be a refresh subcommand!

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
