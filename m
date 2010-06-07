From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: branch --set-upstream considered harmful
Date: Mon, 7 Jun 2010 03:37:52 -0400
Message-ID: <AANLkTim6JrB1JmwQYThSiVqubhb7Uy6HrZcQXbHNZEsl@mail.gmail.com>
References: <AANLkTiln_xxnF-e33YA7kkfbBBcBMd40xag8JTW0eqws@mail.gmail.com>
	<AANLkTikUkkWQl7cYuPiKGaJFYL_JlIGFCXXf7En8t0FN@mail.gmail.com>
	<AANLkTildT6TRd0sPlv1QbCLO7oOPHM-L1yWNIdhdp0ex@mail.gmail.com>
	<201006070837.16713.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tay Ray Chuan <rctay89@gmail.com>, git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 07 09:38:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLWuP-0005to-Nm
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 09:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434Ab0FGHhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 03:37:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53165 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932211Ab0FGHhx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 03:37:53 -0400
Received: by iwn37 with SMTP id 37so3096727iwn.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 00:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bwqkcRddWGD3O8OE1BzkK4aQYfl8WCqMm+5QZ5tbqPc=;
        b=LBnvnFPFh1GRoQoAaTPdri3Gp80zamW90nLrMyT97fr25xy0IooP3fZux9cJQvA3Fe
         azXKGIvnoYOv1ClYWD4P02vtNYLYYGD1X1aAqX9rNlPjtJroGuQov48/A82GFTowVAdv
         0hPoL14+8vl5vZZfD64dio+Xzvmj8eRTx8C4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=I9IDoCQzR5nCCXFA3y/fRBSQE0tp+G9ch2vXSYcQpdRb0G9q8GPhiA3oK2w8c99PqX
         jbVkS866xjYxm27EjutKG/v2dMqaFQ1c3Lcp/HG0EbT2i+v8z98zsMaYv+pi7vK3sci9
         4evfS+fiK/KOtHacFLK/t7RYTvxnFmP9AXNcs=
Received: by 10.231.124.73 with SMTP id t9mr3978526ibr.170.1275896272495; Mon, 
	07 Jun 2010 00:37:52 -0700 (PDT)
Received: by 10.231.16.134 with HTTP; Mon, 7 Jun 2010 00:37:52 -0700 (PDT)
In-Reply-To: <201006070837.16713.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148581>

On Mon, Jun 7, 2010 at 2:37 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> Jay Soffian wrote:
>>
>> Git is inconsistent.
> [...]
>> $ git branch --set-upstream=origin/master
>> $ git branch --set-upstream origin/master
>
> Doesn't this just make it *more* confusing?
>
> Either we document this, and the user will be left wondering why we
> have two almost identical (and by the conventions of many other
> programs, including git-send-email, *equivalent*) syntaxes doing,
> well, something not quite entirely unlike the same.
>
> Or we don't, and the user will eventually typo it and wonder WTF he
> just did wrong.

Please take a step back and see my original message. The thing that
motivated this is that the existing invocation is, I claim,
bass-ackwards. I was merely looking for a backwards compatible
solution that doesn't introduce yet another argument. But, maybe
set-upstream hasn't been around so long that breaking it (i.e., making
it an option that requires an argument) wouldn't be a bad idea.

Enough talk, I'll send up a patch when I get some more time.

j.
