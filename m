From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Tue, 17 Feb 2009 09:29:57 +0000
Message-ID: <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com>
References: <200902142056.42198.trast@student.ethz.ch>
	 <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch>
	 <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org>
	 <200902151711.45099.trast@student.ethz.ch>
	 <20090215181818.GA2291@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 10:31:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZMId-0005ri-1K
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 10:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbZBQJaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 04:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbZBQJaA
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 04:30:00 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:53757 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbZBQJ37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 04:29:59 -0500
Received: by qyk4 with SMTP id 4so3622716qyk.13
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 01:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lwMRnQD5v/t8uXUFmQkXLuP/pLUrYhpgY/IUpJ17Wxg=;
        b=E6tsMUWTZDIKxE2vETfOoJ92D+zGj31dZHdkEEezXL6GFYn0iz7EZUM472ojn2c3j/
         OnfvAAFkJTcK/ybBhpc06cP458MQ1dHJ7hTdaYlMIw4sH4m7gVLAFJo7Lq5/OYaIaw9s
         8Xzk444W6Iz0cPr+WTTVRKL9pfbFBckihsjQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wUM2U4MIkAkefrYu6En00KEQSbqwUmfDOW05OsOMu7w2QgSgJtDxbB6kx5kTp5w3ff
         f2L6mySKtZhPjzoDfDJTZtT3B/1erHcnNRyXw6hoCdhxCOZUHwqgsfVhlJ727h7A7bGS
         1lutkjz4LiWUEkWp0Xee1oPO7I2OSRmr0tl/I=
Received: by 10.224.15.15 with SMTP id i15mr9799157qaa.12.1234862997301; Tue, 
	17 Feb 2009 01:29:57 -0800 (PST)
In-Reply-To: <20090215181818.GA2291@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110346>

2009/2/15 Jeff King <peff@peff.net>:
> On Sun, Feb 15, 2009 at 05:11:40PM +0100, Thomas Rast wrote:
>> Is there a "bare minimum" POSIX shell that I can run the tests under,
>> to save myself such embarassment in the future?
>
> Using "dash" will catch bash-isms, and is pretty commonly available, I
> think.  But this behavior, IIRC, happens on FreeBSD's /bin/sh, which is
> derived from "ash" (so is "dash", but I they have long since diverged).
>
> There are even more quirks on more exotic systems, I expect, though I
> have to admit that I gave up on Solaris and just started using bash
> there. :)
>
> So I don't think there is a catch-all shell that will help you, but some
> "ash" variant is probably your best bet.

posh? http://packages.debian.org/lenny/posh

I've heard that if you unset POSIXLY_CORRECT it just sits there and
hums until you set it again. 8-)

Mike
