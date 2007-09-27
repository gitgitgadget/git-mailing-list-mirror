From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 14:22:41 -0700
Message-ID: <94ccbe710709271422x5d1739c2g5da961c88a4336fe@mail.gmail.com>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	 <20070927185707.GC12427@artemis.corp>
	 <94ccbe710709271224rc65b6f4k8b68419629ed5b45@mail.gmail.com>
	 <7vhclfubh5.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	 <7vd4w3ua2j.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com>
	 <7v8x6ru97z.fsf@gitster.siamese.dyndns.org>
	 <7vwsubsuh1.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib0or-0001y0-Jk
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 23:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbXI0VWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 17:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbXI0VWn
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 17:22:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:32332 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbXI0VWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 17:22:42 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3312030wah
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=WSUdXLuHAgg7Hz7aWePFnukfu5bPg8m8tJwSzpuoiG4=;
        b=fSpLRUqABaBA+9vIeOLRw4enrGcosZ/XXacN2N4ciyg0tpuOKud/BXL0vbyP3iUa7qv+fqfGYbTGTX0qf4vrsaUDCS5C7fFEcvKUwLjfUMfa78l4fMllTX75pAFPhSSSZeLcBGEr192ZD63ruA0iVp3+iV8Aw8NiL2+JUMgOUSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=UJHBnKaaBG3irgZtaHvPIpkvBdvy9KfEU3csTvd/GK4RYL/AXD7gWqQZ22dRnmzBaT4gBYtF+mfLYSEDiJQpzlngSxpss+3Wtn8BK/8RUc45h3C7MOkJiQFJqr7wtpiDhjaUFPS5hVdHxdMtKUDKUk4FIe4xxo2y45KhE+xtI0c=
Received: by 10.114.131.9 with SMTP id e9mr830921wad.1190928161371;
        Thu, 27 Sep 2007 14:22:41 -0700 (PDT)
Received: by 10.114.144.17 with HTTP; Thu, 27 Sep 2007 14:22:41 -0700 (PDT)
In-Reply-To: <94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 130b30fe7db668a8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59336>

On 9/27/07, Kelvie Wong <kelvie@ieee.org> wrote:
> On 9/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > "Kelvie Wong" <kelvie@ieee.org> writes:
> > >
> > >> Egads, it's alive!
> > >>
> > >> I was in a subdirectory (most of my work is in that one subdirectory
> > >> anyways :p), but running it on the top level did indeed work as
> > >> expected.
> > >>
> > >> Thanks,
> > >
> > > Thanks for spotting a bug.  It claims to be subdirectory safe at
> > > the top of the script but apparently it isn't.
> > >
> > > And I do not see a reason why it cannot be made subdirectory
> > > safe.
> >
> > It _could_ be just the matter of doing this, although I cannot
> > test it right now (at work and have no access to any of the
> > backends).  Care to try it from a subdirectory and report
> > failure or success?
> >
> > ---
> >
> >  git-mergetool.sh |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/git-mergetool.sh b/git-mergetool.sh
> > index a0e44f7..018db58 100755
> > --- a/git-mergetool.sh
> > +++ b/git-mergetool.sh
> > @@ -12,6 +12,7 @@ USAGE='[--tool=tool] [file to merge] ...'
> >  SUBDIRECTORY_OK=Yes
> >  . git-sh-setup
> >  require_work_tree
> > +cd_to_toplevel
> >
> >  # Returns true if the mode reflects a symlink
> >  is_symlink () {
> >
>
> At least with emerge, this isn't so simple -- emacs tries to save it
> as ${absolute_PWD}/${PWD_relative_to_toplevel}/$filename
> (which of course doesn't exist yet).
>
> In meld it works fine, however; haven't tried the other ones.
> --
> Kelvie
>

Hrm, on closer inspection, the old version of the mergetool script did this too.

It looks like the bug I mentioned does get fixed by that, and this is
a bug in emacs (or the way it's called).
-- 
Kelvie
