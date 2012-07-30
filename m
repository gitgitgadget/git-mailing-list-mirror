From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [RFC v2 11/16] Add explanatory comment for transport-helpers refs mapping.
Date: Mon, 30 Jul 2012 22:15:26 +0200
Message-ID: <2235865.Y0jAeP1uog@flomedio>
References: <1343658683-10713-5-git-send-email-florian.achleitner.2.6.31@gmail.com> <7vwr1lqhd7.fsf@alter.siamese.dyndns.org> <20120730191553.GC9564@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:15:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvwNM-0007z2-V6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 22:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab2G3UPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 16:15:31 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41716 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab2G3UPb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 16:15:31 -0400
Received: by bkwj10 with SMTP id j10so2995922bkw.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=G2jB/ac/gkYmsHA/Tq+dJ46LDyWQmFs3BagiDldaz0c=;
        b=A7LiWejyjXA6RNoItih6vNpWcVcYSQMvZFck89O0NizYVzxej4Pgen0iUZeoSUyXPa
         FbtGqp1IOBk6nP+CL14UZOTqQLBc3ZIJSSBqY1oqRX9vu47jm7aVUpAoh6msxpaKCcFD
         yPnSoSLyR07hlsgawGRNpiCnUObIlx+iQXhtHw8+7ARB6VBtBCRPSrRxn2h5XRYeAEkX
         sysGAQu5tSpGe0Yb5I4EPD/ovPymifU4tXH0k3ZEVHtCXhdjOh3Vzx65BYdvwz7ONuME
         PaI/T3fnw203uuo58ab/vhRuJyNtPU9+mxaGxCuTnKlIi8c3+F39kePbR9EYQ+F4CpCh
         vSoA==
Received: by 10.205.123.133 with SMTP id gk5mr4313834bkc.140.1343679329841;
        Mon, 30 Jul 2012 13:15:29 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id fu8sm4351886bkc.5.2012.07.30.13.15.28
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jul 2012 13:15:29 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20120730191553.GC9564@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202609>

On Monday 30 July 2012 14:15:53 Jonathan Nieder wrote:
> Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
> >>> +	/*
> >>> +	 * If the remote helper advertised the "refspec" capability,
> >>> +	 * it will have the written result of the import to the refs
> > 
> > perhaps s/will have the written result of/would have written result of/?
> 
> That would sound like 'If the remote helper advertised the "refspec"
> capability, it would have written the result of the import to the
> refs, but it didn't, so...', so I think "will" is the right tense.
> But 'will have the written' is awkward.  How about:

Yes, thats clearly a typing error of mine, 'the' is to be deleted.

> 
> 	 * The fast-import stream of a remote helper advertising the
> 	 * "refspec" capability writes to the refs named after the right
> 	 * hand side of the first refspec matching each ref we were
> 	 * fetching.
> 	 *
> 	 * (If no "refspec" capability is specified, for historical
> 	 * reasons the default is *:*.)
> 	 *
> 	 * Store the result in to_fetch[i].old_sha1. [...]
