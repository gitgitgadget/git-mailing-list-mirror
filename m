From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: do not set setgid bit on directories on
 GNU/kFreeBSD
Date: Mon, 3 Oct 2011 02:19:49 -0500
Message-ID: <20111003071949.GC17289@elie>
References: <20111003064120.GA24396@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Salinger <Petr.Salinger@seznam.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:20:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAcoj-0004Us-Ah
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315Ab1JCHT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:19:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45412 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab1JCHT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:19:56 -0400
Received: by iaqq3 with SMTP id q3so4709812iaq.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/2+CvW0Ie49O9D0jMJ1ypkA14waQJzvdHYqCKmSX3Nc=;
        b=U90sROfWTd6/y9wcEup/R/J9C7ZgM9nAj7mwQARhV6od4twZuBfHkHLmAcpz9EPC7b
         htKU3j0R1itsvkzjZUg8IFSCl/+v5supT+Lkmk2h/DuZry5aeh3lqwmGDSE8gz/OkLeS
         mRj9Lu1zSjNlRAAr9C8o7ry2zoAAyId57v5r8=
Received: by 10.42.146.138 with SMTP id j10mr7157282icv.105.1317626395764;
        Mon, 03 Oct 2011 00:19:55 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id g16sm27575894ibs.8.2011.10.03.00.19.54
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 00:19:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20111003064120.GA24396@elie>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182629>

Jonathan Nieder wrote:

> Since the setgid bit would only mean "do what you were going to do
> already", it's better to avoid setting it.  Accordingly, ever since
> v1.5.5-rc0~59^2 (Do not use GUID on dir in git init --share=all on
> FreeBSD, 2008-03-05), git on true FreeBSD has done exactly that.  Set
> DIR_HAS_BSD_GROUP_SEMANTICS in the makefile for GNU/kFreeBSD, too, so
> machines that use glibc with the kernel of FreeBSD get the same fix.
[...]
> Sorry to have taken so long to send this one out.  Anyway, it seems
> to me like the right thing to do.  Petr, what do you think?

fwiw:

Acked-by: Petr Salinger <Petr.Salinger@seznam.cz>

Thanks for looking it over.
