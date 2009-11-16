From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Tue, 17 Nov 2009 00:48:49 +0100
Message-ID: <20091116234849.GA3608@plop>
References: <1257850011-7544-1-git-send-email-book@cpan.org>
 <20091110122315.GA15906@coredump.intra.peff.net>
 <7v639cqhh6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 00:49:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NABJl-0000hm-So
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 00:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbZKPXs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 18:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbZKPXs5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 18:48:57 -0500
Received: from mail-out3.booking.com ([91.195.237.20]:50951 "EHLO
	mail-out3.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbZKPXs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 18:48:57 -0500
Received: from corpds-102.ams4.corp.booking.com ([10.196.68.83])
	by mtx-101.ams4.prod.booking.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABJR-0006Uv-RR; Tue, 17 Nov 2009 00:48:49 +0100
Received: from ams4-mail-03.ams4.corp.booking.com ([10.196.68.31])
	by corpds-102.ams4.corp.booking.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABJR-0006Vi-PM; Tue, 17 Nov 2009 00:48:49 +0100
Received: from plop (bkbastion-01.corp.lhr1.booking.com [10.146.90.100])
	by ams4-mail-03.ams4.corp.booking.com (Postfix) with ESMTP id 82BEBEF8005;
	Tue, 17 Nov 2009 00:48:49 +0100 (CET)
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1NABJR-0001Aa-6D; Tue, 17 Nov 2009 00:48:49 +0100
Content-Disposition: inline
In-Reply-To: <7v639cqhh6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133039>

On Sun, Nov 15, 2009 at 01:12:37AM -0800, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Nov 10, 2009 at 11:46:51AM +0100, Philippe Bruhat (BooK) wrote:
> > (snip)
> > Will this work if I just have PERL_PATH in my config.mak in the root
> > directory? Should we be adding PERL_PATH to the generated
> > GIT-BUILD-OPTIONS file in the root, which gets sourced by test-lib?
> >
> > Something like the following (completely untested) patch?
> 
> Philippe, could you please help getting this topic unstuck with a "it
> works" or "it doesn't and here is a better solution"?
> 

I took Jeff's patch the main Makefile, removed my patch to test-lib.sh,
and it worked. That is to say, the test suite failed on the perl tests
when the first perl in the PATH was my local perl without Error.pm
installed. With the changes, the test suite passed, even with my local
perl first in the PATH.

Patch with a reworked commit message follows.

-- 
 Philippe Bruhat (BooK)

 The truly stupid always find a way to create disaster.
                                                (Moral from Groo #10 (Image))
