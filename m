From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: [PATCH] Add an "-i" option to git-reset, to confirm a reset.
Date: Sat, 15 Dec 2007 19:46:10 -0800
Message-ID: <94ccbe710712151946u22f02a8fkbc3c4cbc96ee22f5@mail.gmail.com>
References: <1197775596-14329-1-git-send-email-kelvie@ieee.org>
	 <Pine.LNX.4.64.0712160332140.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kSZ-0002tj-59
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758545AbXLPDqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757738AbXLPDqM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:46:12 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:24111 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018AbXLPDqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:46:11 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2410000wah.23
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 19:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=7kPf3nxIGFCGMKd2z9Vims6VjYSnmnivypn2MHQck6Y=;
        b=flO99a0ED8kzGl2G3CvTORHvcaWwD6r80LBn1ZZpKzPQc94wO2a5GuvPYDC62Dye8PNdtAJ2JNxqtlQWSsr6vHgIT5GABf18d2PaEmae2pPOzhDuTSo+7rtCTJGhw8LkdftI9CL67O84dnkZSKY8h0QTXfeVKAakJ1JtyMkyay8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tIa2CEKwdue0PRW4QGuYnVy9VQKeFukoqOF7XGsNSyyf7WuAzOTsz3CUMawVeYsQJSMEXOloSPRItTCwL0Yn1X6aCGghRhnqKre2KunGqrYYQXECpo6RhFiE8FAdx+mfhKvfb0mjLgnJMgqQq88oBFn6C4xQ1qBtajQTVx/6a8Y=
Received: by 10.115.79.1 with SMTP id g1mr1605324wal.43.1197776771010;
        Sat, 15 Dec 2007 19:46:11 -0800 (PST)
Received: by 10.114.149.15 with HTTP; Sat, 15 Dec 2007 19:46:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712160332140.27959@racer.site>
Content-Disposition: inline
X-Google-Sender-Auth: 2f0bbc305bd36927
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68430>

On Dec 15, 2007 7:35 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 15 Dec 2007, Kelvie Wong wrote:
>
> > It shows a diffstat, and asks the user if they would like to continue,
> > or show a full diff of the things getting reset.
> >
> > I know that many times, I do a reset --hard thinking I had commited a
> > file already, but it turns out that I hadn't; and so this makes sure I
> > don't lose any work when the caffeine wears off.
> >
> > Maybe it should also be made that only hard resets take this option, as
> > I cannot see this being useful in other places.
>
> I am slightly negative on this patch.  Not only do I think that it is both
> easier and more natural to run diff/status/an-alias to see what a reset
> would do, but the patch only handles the index_file part (missing the --
> <file> part AFAICT).
>
> Besides, the code style is incompatible with the surrounding code.
>
> Ciao,
> Dscho
>
>
[forgot to hit Reply To All again, sorry!]

Ah, you're completely right about the index_file part (this is
actually the first time I've looked at the git-code :P)

Hrm.. I should have just used a shell script wrapper instead it seems.

I do think something like this would be nice though.

w.r.t. the style, you were referring to just the array initializers
right?  Or was there something else I did that doesn't look right?
-- 
Kelvie Wong
