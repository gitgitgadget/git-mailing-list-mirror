From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Fri, 16 Dec 2011 21:38:08 -0600
Message-ID: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
References: <20111216110000.GA15676@sigill.intra.peff.net>
 <4EEB4F13.2010402@viscovery.net>
 <20111216192104.GA19924@sigill.intra.peff.net>
 <4EEBC0A7.3030303@kdbg.org>
 <20111217012118.GB20225@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 17 04:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbl6d-0003ir-8o
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 04:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904Ab1LQDiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 22:38:20 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38305 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab1LQDiS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 22:38:18 -0500
Received: by yhr47 with SMTP id 47so3324853yhr.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 19:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kM8ph0bilxI11WBdjVZ+vFPIgAH2X2ZKWhyOgn4FXbM=;
        b=j4sscR5NQm4xrpUhTbBJz0JzCoHrY6y7808aQLWIiUp3/pg9kQAa3iPsIBaAgId1v0
         SaH13bLLtpQfDie8522n/yFT4pnqQU0v0pvL2oiwgKN4LmrTe+wp5d+XQgQ1eg5YRfMq
         VPg72dggR4jgeAsTGnindYwOZpQWRpgvNqkyM=
Received: by 10.236.92.168 with SMTP id j28mr15602576yhf.59.1324093098114;
        Fri, 16 Dec 2011 19:38:18 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id s12sm2950329and.15.2011.12.16.19.38.15
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 19:38:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111217012118.GB20225@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187348>

Jeff King wrote:

>                          Or maybe just drop the C ones (and probably the
> objc one based on other parts of the thread) and do the rest?

Yes, that.

This way, someone wondering why the C ones are not used by default can
easily look at your patch, see that they are utterly broken, and help
us fix it.  That's how progress is made.
