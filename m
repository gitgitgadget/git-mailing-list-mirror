From: "Philippe Bruhat (BooK)" <book@cpan.org>
Subject: Re: [PATCH] Define $PERL_PATH in test-lib.sh
Date: Tue, 10 Nov 2009 14:34:27 +0100
Message-ID: <20091110133427.GC8896@plop>
References: <1257850011-7544-1-git-send-email-book@cpan.org> <4AF95C0D.90605@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 10 14:34:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7qri-0006n9-DM
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 14:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZKJNeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 08:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbZKJNeX
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 08:34:23 -0500
Received: from mail-out4.booking.com ([91.195.237.21]:47636 "EHLO
	mail-out4.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbZKJNeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 08:34:22 -0500
Received: from corpds-102.ams4.corp.booking.com ([10.196.68.83])
	by mtx-102.ams4.prod.booking.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7qrc-0005br-1H; Tue, 10 Nov 2009 14:34:28 +0100
Received: from ams4-mail-03.ams4.corp.booking.com ([10.196.68.31])
	by corpds-102.ams4.corp.booking.com with esmtp (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7qrc-00016r-0R; Tue, 10 Nov 2009 14:34:28 +0100
Received: from plop (bkbastion-01.corp.lhr1.booking.com [10.146.90.100])
	by ams4-mail-03.ams4.corp.booking.com (Postfix) with ESMTP id DAA8DEF80B9;
	Tue, 10 Nov 2009 14:34:27 +0100 (CET)
Received: from book by plop with local (Exim 4.69)
	(envelope-from <philippe.bruhat@free.fr>)
	id 1N7qrb-0003du-UA; Tue, 10 Nov 2009 14:34:27 +0100
Content-Disposition: inline
In-Reply-To: <4AF95C0D.90605@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132566>

On Tue, Nov 10, 2009 at 01:26:53PM +0100, Johannes Sixt wrote:
> >  
> > +test -z "$NO_PERL" && test -z "$PERL_PATH" && export PERL_PATH=/usr/bin/perl
> 
> Wouldn't
> 
>    ... && export PERL_PATH=perl
> 
> be a safer fall-back?

/usr/bin/perl is the value used in the top-level Makefile.
I used this for consistency.

-- 
 Philippe Bruhat (BooK)

 The greatest monster of them all is ignorance.
                             (Moral to Pal'n Drumm Story in Groo #89 (Epic))
