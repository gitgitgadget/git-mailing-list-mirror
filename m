From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Wed, 11 Nov 2009 09:40:14 +0100
Message-ID: <20091111084014.GE8896@plop>
References: <1257850011-7544-1-git-send-email-book@cpan.org> <4AF95C0D.90605@viscovery.net> <20091110133427.GC8896@plop> <7v7hty6so9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:40:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N88ki-0006PA-DA
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 09:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbZKKIkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 03:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZKKIkR
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 03:40:17 -0500
Received: from mail-out4.booking.com ([91.195.237.21]:50716 "EHLO
	mail-out4.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbZKKIkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 03:40:16 -0500
Received: from corpds-101.ams4.corp.booking.com ([10.196.68.22])
	by mtx-102.ams4.prod.booking.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N88kR-0002y5-4x; Wed, 11 Nov 2009 09:40:15 +0100
Received: from ams4-mail-03.ams4.corp.booking.com ([10.196.68.31])
	by corpds-101.ams4.corp.booking.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N88kR-0006Mt-21; Wed, 11 Nov 2009 09:40:15 +0100
Received: from plop (bkbastion-01.corp.lhr1.booking.com [10.146.90.100])
	by ams4-mail-03.ams4.corp.booking.com (Postfix) with ESMTP id C337EEF80FA;
	Wed, 11 Nov 2009 09:40:14 +0100 (CET)
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N88kQ-0001sO-CK; Wed, 11 Nov 2009 09:40:14 +0100
Content-Disposition: inline
In-Reply-To: <7v7hty6so9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132621>

On Tue, Nov 10, 2009 at 12:17:26PM -0800, Junio C Hamano wrote:
> "Philippe Bruhat (BooK)" <book@cpan.org> writes:
> 
> > On Tue, Nov 10, 2009 at 01:26:53PM +0100, Johannes Sixt wrote:
> >> >  
> >> > +test -z "$NO_PERL" && test -z "$PERL_PATH" && export PERL_PATH=/usr/bin/perl
> >> 
> >> Wouldn't
> >> 
> >>    ... && export PERL_PATH=perl
> >> 
> >> be a safer fall-back?
> >
> > /usr/bin/perl is the value used in the top-level Makefile.
> > I used this for consistency.
> 
> Hmm, but that means two separate definitions in ./Makefile and
> t/test-lib.sh must be kept in sync forever, and there is not even a
> comment next to the line that requires such care in your patch to help
> people who might want to change these lines in the future.

Is there a way to obtain whatever value was computed in the Makefile,
or should I just add a comment in all-caps saying "keep this in sync
with the default value in the top level Makefile"? (and a more detailed
commit message)

-- 
 Philippe Bruhat (BooK)

 Freedom is not an individual effort. Yours comes only when you grant others
 theirs.                             (Moral from Groo The Wanderer #5 (Epic))
