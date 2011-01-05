From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 00/31] Refactor rebase
Date: Tue, 4 Jan 2011 22:39:17 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101042234450.11516@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <201101042057.29809.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 05 04:39:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaKDk-0006Dd-Tz
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 04:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab1AEDjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 22:39:24 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62733 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab1AEDjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 22:39:21 -0500
Received: by qwa26 with SMTP id 26so15249138qwa.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 19:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=MbYSk2h7q0wWr0iuu7bgCFVxrcl6L77WC1SYBfd5h34=;
        b=HSYurvvGRP3AOws9eTLXQUOiFO4K5/fJSEaH5QHZLahwwph84Vah6dOwP0P2WZVD6X
         +okvVJ/dCwj3VXr8RqeaJSjv0Eej+3nWj/5ZlJ2tVWM6hOH/X3NCYJ+t57eCZU3hzy5R
         pNAwIS7KYREqFG3a0Xf42PhbDnLiTCVnl2fAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=sErdJRbCqMDlJE4bxxJ7y2PBCTVTS1UUP9kl/s8/Kw+fnc1amH5yJaAC9PNLxZXsps
         qZpba/I1SWQ2MOjYLRl0lRB3qYC5EY9JBmJdH0pU+qh27p2Vup8dPEgUvAUpYUQYM9hb
         GFDSA6b9gm+uTBtyTT0ierMmaEAfsKhJSAAOg=
Received: by 10.224.2.70 with SMTP id 6mr21614712qai.83.1294198760992;
        Tue, 04 Jan 2011 19:39:20 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g32sm13299835qck.46.2011.01.04.19.39.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 19:39:19 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201101042057.29809.trast@student.ethz.ch>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164544>

On Tue, 4 Jan 2011, Thomas Rast wrote:

> Martin von Zweigbergk wrote:
> > For the past two months, I have been working on refactoring the rebase
> > code. See [1] for background information. I have been trying to polish
> > the patch set for some time, but now I don't think I will get much
> > further without your help.
> 
> Thanks a lot for undertaking this effort!  I just finished looking
> through the entire series, and it all seems sane to me.  Apart from
> j6t's reply I think we're mostly nit-picking or agreeing with you, and
> this is the first iteration!

Thanks. And thanks a lot for taking the time to review it!


/Martin
