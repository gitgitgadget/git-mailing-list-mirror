From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-status too verbose?
Date: Tue, 7 Mar 2006 10:17:17 +0100
Message-ID: <20060307091717.GA16645@diana.vm.bytemark.co.uk>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com> <7vacc36r4v.fsf@assigned-by-dhcp.cox.net> <20060307053547.GK6346@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Mar 07 10:17:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGYJp-0005wC-6A
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 10:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbWCGJRW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 7 Mar 2006 04:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbWCGJRW
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 04:17:22 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:45316 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1752026AbWCGJRW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 04:17:22 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FGYJh-0004QP-00
	for <git@vger.kernel.org>; Tue, 07 Mar 2006 09:17:17 +0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060307053547.GK6346@always.joy.eth.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17325>

On 2006-03-07 11:05:47 +0530, Joshua N Pritikin wrote:

> On Mon, Mar 06, 2006 at 04:21:52PM -0800, Junio C Hamano wrote:
>
> >                     HEAD->index     index->files
> >     ------------------------------------------------
> >     hello.c         unmodified      modified
> >     world.c         modified        unmodified
> >     frotz.c         new             unmodified
> >         ...
> >     garbage.c~      ???             n/a
>
> For what it's worth, this chart immediately made sense to me and I
> would prefer it to the current git-status output.

I agree. This kind of status information makes the whole index concept
an order of magnitude less confusing. In a way, it lets you learn what
the index is by example, rather than first having to learn what it is
in order to be able to grok the status information.

=46itting this in 80 columns should be a funny excercise, though. :-)
I'd suggest printing the filename last:

     HEAD->index  index->files
     ------------------------------------------------
     unmodified   modified      hello.c
     modified     unmodified    world.c
     new          unmodified    frotz.c
         ...
     ???          n/a           garbage.c~

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
