From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] git-reset.txt: Use uniform HEAD~N notation in all
	examples
Date: Sat, 1 Sep 2007 10:01:53 -0500
Message-ID: <20070901150153.GD7422@mediacenter.austin.rr.com>
References: <tzqfsijk.fsf@cante.net> <7vy7frzfzg.fsf@gitster.siamese.dyndns.org> <hcmesrse.fsf@cante.net> <7vabs6u3jt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 17:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRUSi-0001ZG-Do
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 17:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbXIAPAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 11:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbXIAPAc
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 11:00:32 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:55473 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbXIAPAb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 11:00:31 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1054205wxd
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 08:00:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=VCvYymsxKZzCi/pg3s+EXmSU/FhLbiKKBnpOMXttqHTWW3/Gg7j+VyFrVuOUBDe8m93szzL7uCxZvGdZK2wWhM50QJ8YEqIJX4OEcYBE7dtx9pNW2a59ghbs4R8FXGnRfjD2NeWDn9i2t2rNfNtkGO+OdWKSumivS8+gOmQ3nDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=iX+rDepS34kIJwLrQA90kiSlakwBwDYp3GA9NYKxkF73+vlSjw48QxeOnfBv/xd0S77qMMLEp7Edydaz6PL9CyxlbIPyA/i95vCrPVbzTaLYpe9iFi6eXesToIUfRl8VfFEP2BjQxoz1WZlQS+tZb65nBIEDcMtH9/dIQXaWeX8=
Received: by 10.90.106.11 with SMTP id e11mr2985940agc.1188658830513;
        Sat, 01 Sep 2007 08:00:30 -0700 (PDT)
Received: from mediacenter.austin.rr.com ( [70.112.123.114])
        by mx.google.com with ESMTPS id 31sm810593wri.2007.09.01.08.00.28
        (version=SSLv3 cipher=OTHER);
        Sat, 01 Sep 2007 08:00:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vabs6u3jt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57276>

On Sat, Sep 01, 2007 at 02:40:22AM -0700, Junio C Hamano wrote:
> Jari Aalto <jari.aalto@cante.net> writes:
> 
> > Like:
> >
> >     HEAD, HEAD~1, HEAD~2
> >
> > If the syntax is changed in the middle (as it was in manual page),
> > that interrupts the kognitive flow of reading.
> >
> >     HEAD, HEAD^, HEAD~2
> >
> 
> I still would prefer to teach people HEAD^ earlier.  If you _REALLY_
> insist, I can live with spelling the HEAD~2 as HEAD^^ for
> consistency.
> 
> Wasn't with you that earlier I discussed that very basic things
> such as revision naming and range notation should be moved from
> rev-list documentation to more central place, and sructure the
> documentation in such a way that these should be read even
> before individual manual pages are consulted?  If we follow
> that, then by the time people read these examples, they _ought_
> to know that HEAD~1 is a longer-to-type way to say HEAD^ already.

Well I am a new user to git and I didn't find the mixed notation
confusing at all.  Perhaps this is because I read the tutorial first,
then the git user manual which both explain this clearly.

In either case I think eliminating either notation from the man pages is
a bad idea.  I'm quite confident that in the worst case a user will
think that if they want to refer to the parent they have to say HEAD^
and if they want to refer to the grandparent they have to say HEAD~2.
Most won't even find that strange since HEAD^ just seems shorter.  I
also think many users will be smart enough to infer that if they wanted
to they could say HEAD~3 or perhaps HEAD~1, though unless I saw it
somewhere I might not have guessed HEAD^^.
