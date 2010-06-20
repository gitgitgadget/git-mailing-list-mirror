From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 23:07:23 +0200
Message-ID: <20100620210722.GA27492@localhost>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
 <1277051592-4552-3-git-send-email-rctay89@gmail.com>
 <1277051592-4552-4-git-send-email-rctay89@gmail.com>
 <7vvd9dtt54.fsf@alter.siamese.dyndns.org>
 <20100620201137.GA8502@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 20 23:09:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQRlE-0005wW-1H
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 23:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab0FTVIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 17:08:55 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58111 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534Ab0FTVIy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 17:08:54 -0400
Received: by wwb13 with SMTP id 13so6536wwb.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 14:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=fy1UTW8wIKwzmt6GW0kNu+wNQgD21Gi8p7kcrDQdZQY=;
        b=IPvvbIGdQBNGS705jGQb95FOee1MNCYJDjUYbdb5rU2atReC4NdbEfseT6RWQzuNfI
         c0n4edwPynbsSktK+b9YGeU/WNR+GBZ88UpeXU+MTtk7p4iI5XxC3Lhfg12E9dCEntA/
         mlZhiuV5in4gJPfcFoRxRjryMLuaYzlNA6ol4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=ZT6eRNicRtyQo9HORde2ir8kcHH62lGuggefc2JaEWTAZqkSGkczzBHdbHKN20M1jW
         W99vrl9tlKCyrI1zOYa7GpTsbnUq4ZR9v63NSk1brs2/jyF0Kq1Bm7mlcn7yvyyAG8cD
         6NC7/NUaxfhTS7FWzSqk7WzxQMrd7RdyoHcVs=
Received: by 10.216.185.78 with SMTP id t56mr2771180wem.40.1277068132377;
        Sun, 20 Jun 2010 14:08:52 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id w27sm3718145weq.22.2010.06.20.14.08.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jun 2010 14:08:50 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OQRjf-0007DP-87; Sun, 20 Jun 2010 23:07:23 +0200
Content-Disposition: inline
In-Reply-To: <20100620201137.GA8502@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149404>

On Sun, Jun 20, 2010 at 04:11:38PM -0400, Jeff King wrote:
> On Sun, Jun 20, 2010 at 12:12:55PM -0700, Junio C Hamano wrote:
> 
> > I think this is not "DWIM" but is "-f does not work with -b; fix it".

Actually, it currently behaves exactly as the manpage suggests.

> I am not sure it is fixing a bug. There are really two possible things
> to be forced during checkout:
> 
>   1. throw away local changes
> 
>   2. overwrite an existing branch
> 
> Right now, "checkout -f" means just (1). This patch makes it _also_ mean
> (2). Do we want to conflate those two cases?
> 
[...]
> I dunno. I don't have a strong feeling on how it should be, but I think
> it is more than a simple bug fix.

I don't have anything to add to that, except that in my opinion
checkout does more than enough conflating already, and I am
therefore strongly against this change.

Clemens
