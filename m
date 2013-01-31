From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Rename {git- => git}remote-helpers.txt
Date: Thu, 31 Jan 2013 15:04:55 -0800
Message-ID: <20130131230455.GN27340@google.com>
References: <7v1ud1gke7.fsf@alter.siamese.dyndns.org>
 <3f26b82599aa2a45897d345c851fab4751c55810.1359669205.git.john@keeping.me.uk>
 <20130131223305.GB21729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Max Horn <max@quendi.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 00:05:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U13CB-0000xf-CP
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 00:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998Ab3AaXFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 18:05:04 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59819 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756731Ab3AaXFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 18:05:02 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so1961084pac.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 15:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YesqNE0PSjhe9JrpVzGVFA+HC6Dccdjr3m1h6jQPjAs=;
        b=VaNnjzmEhzCtNuxzlySSzCbk5zWkSnwNH5Fmj6rqTHkqKwASXEyYU0mB6iolk1APCX
         Onw6ZuEQroSfB+tJ5DbRAh7nGOuojwtNGDRqBszHWO3RpHv9P02vgHUXSmGJFPn0V/bI
         Ymdt9F8X88kkdSlbGd9Wr2ZmTCFDGSbF9hiffj2t7mRbI1BjlJIrS362Tp+5SlCOHv+D
         7OGLluYglzc8DlM/pj12xAP7Ee+WLmaVWnFpDCBLc7QcBD9wJd1cdXWOCBV9eIxRND/m
         d1uYOcAQqruIvGXvL7nTeoXBLzudaRPShR/1eub/Jbd78Nk6XMneoVdmLUBCvUO4fjt0
         aJeA==
X-Received: by 10.68.232.169 with SMTP id tp9mr26677335pbc.1.1359673501783;
        Thu, 31 Jan 2013 15:05:01 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qb3sm6263131pbb.35.2013.01.31.15.04.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 15:04:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130131223305.GB21729@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215186>

Jeff King wrote:

> Maybe it is just me, but the fact that accessing the manpage is now:
>
>   man gitremote-helpers
>
> feels weird to me. I know it technically follows our syntactic rules,
> but having the lack of dash be significant between "git" and "remote",
> but then having a dash later makes it hard on the eyes.

Yes.  I have thought for years that it should be git-remote-helpers,
that "git help" should be tweaked to look for that, and that the
existing gitrepository-layout and friends should be replaced with
redirects.

I didn't say anything (except a random comment once on #git) because I
can't promise to have time soon to work on it.  Might try anyway.

Thanks,
Jonathan
