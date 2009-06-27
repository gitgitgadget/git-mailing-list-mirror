From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv7 3/9] gitweb: use git_print_authorship_rows in 'tag' view 
	too
Date: Sun, 28 Jun 2009 00:24:44 +0200
Message-ID: <cb7bb73a0906271524k5681ce93pf79680eb728c516e@mail.gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1246104305-15191-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906272010.30754.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 00:25:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKgKr-0005W9-1o
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 00:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbZF0WYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 18:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZF0WYn
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 18:24:43 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62744 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756817AbZF0WYm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 18:24:42 -0400
Received: by fxm18 with SMTP id 18so324794fxm.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lMl0B1Nl/XebsKgbcHBiDYiu7NbNati7pdMULR7IEVc=;
        b=I34+wE/+NH4yzB9QtNsHBMOiA72mOew7mMt41f5CBqH2C8PFu/NSugeEy1ABff25qd
         DhxPZPZclzeNHu+up34m+UBxWbCm7IhQy9oYp90+kUBPZFThpJxVwCCbzFe+EvqSGU6q
         Hy0sOHj5jMcT2AUGDl2TII37G2IP3Hb1gEnz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LOuePEMqh5q6ek4PKnaxOrQPWfq5+3rq8+rvr5pwOcMAV0cJb7EW4LDLRd4kV1OrGJ
         /TYcDQtERq329ED5TP4iGf31OnxWUoxcMVhRvDyqx6G37+mdQvwuB2D9he6RNx/tId3Y
         otduLplqMOSc7nBL4aBwc2eQLmFPrVC50vAUk=
Received: by 10.204.53.1 with SMTP id k1mr5351104bkg.50.1246141484503; Sat, 27 
	Jun 2009 15:24:44 -0700 (PDT)
In-Reply-To: <200906272010.30754.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122387>

2009/6/27 Jakub Narebski <jnareb@gmail.com>:
> On Sat, 27 June 2009, Giuseppe Bilotta wrote:
>
>> parse_tag has to be adapted to use the hash keys expected by
>> git_print_authorship_rows, which is not a problem since git_tag
>> is the only user of this sub.
>
> Nitpick: I think that with s/has/had/ (past tense) and
> s/, which/. This/ (split paragraph into two sentences)
> it would read better.

I can do that.

> Sidenote: I wonder if it would be worth doing to factor out code dealing
> with extracting data from (parsing) author/committer/tagger object headers.
> Probably not worth it...

It might be worth it, but I'd say we can leave it to some other time ;-)

> I wonder why we used and use 'author' instead of 'tagger'...

The upside of using 'author' is that the tag can then be dealt with
just like any other commit by the rest of the code, I think. I don't
know if this benefit is actually used anywhere in the code.


-- 
Giuseppe "Oblomov" Bilotta
