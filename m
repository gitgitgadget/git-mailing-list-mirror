From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Sources for 3.18-rc1 not uploaded
Date: Tue, 21 Oct 2014 09:25:34 -0700
Message-ID: <CA+55aFyfO_WVy52GobRH0ggBWqvBcUPLJzXo-vme13drXJnBEg@mail.gmail.com>
References: <20141020115943.GA27144@gmail.com>
	<CA+55aFyDuHskYE66rBVL_P-T2pxg6f2m6mUicfz-mk+ysePBxg@mail.gmail.com>
	<20141020222809.GB223410@vauxhall.crustytoothpaste.net>
	<CA+55aFyZ1Mzjdx+JsD4jmFnJo+xL8xLz5+mtbh+_25bCak-7hQ@mail.gmail.com>
	<54461483.9010600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	infra-steering@kernel.org, Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 18:25:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgcFk-0006uA-Ea
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 18:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933172AbaJUQZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 12:25:38 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:49676 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932568AbaJUQZf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 12:25:35 -0400
Received: by mail-vc0-f171.google.com with SMTP id hy10so718658vcb.30
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=umXSz4Xjk9zVV5LNDgpzwL+Q7WBfr9OuEL3ya1SPOpU=;
        b=KVldOi688ZGVSBCUJT8MJoRTZssFHQmEsaWTNVikRDUCUk5u2jIYupD99+oveheggA
         1VdRLYd8037gl/4JkaUGomVXhfb5W3uVJ9A3x4RWHvPcyiEChgGLQ8eWnVzVQraWAfLw
         wBtbBaouPp19MO6jggoxs+b07Yq0C2mPt8AnRinoER7TZ92i1yQmrJNPJgLico09uPTD
         BSzxbpVfc92YREG577FgwTrXs1fCaJZ2XAMMGB5QGj5IVHEmHVv+tX8KYsdZf9W1SHap
         rca8qJDvikienAhxnwJDEgcIFlZEDGEE1T36u0qE8ASmM7C4mcBU+TkQD4MuKrBWFtUx
         gjDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=umXSz4Xjk9zVV5LNDgpzwL+Q7WBfr9OuEL3ya1SPOpU=;
        b=as9jximhWZEWr+Xh6Sw46k45TWyY7NsRZ9Nu+05yopI1jSgO4x19B3H/bA3uoftGXX
         azsmgikUPpeKJ1aBZ/9YOKtt9hZFOfxbarGG5Bmpeggi92W2Oy+kS/YUiHDcFeip37yo
         8jV8MTiw/flBjqAu+j0rNUlHMNdtDiviFm/KY=
X-Received: by 10.220.124.4 with SMTP id s4mr3184267vcr.38.1413908734613; Tue,
 21 Oct 2014 09:25:34 -0700 (PDT)
Received: by 10.220.3.148 with HTTP; Tue, 21 Oct 2014 09:25:34 -0700 (PDT)
In-Reply-To: <54461483.9010600@drmicha.warpmail.net>
X-Google-Sender-Auth: WOyQKolx3DlynjHQJmDUktcCDwo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 21, 2014 at 1:08 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>
> Unfortunately, the git archive doc clearly says that the umask is
> applied to all archive entries. And that clearly wasn't the case (for
> extended metadata headers) before Brian's fix.

Hey, it's time for another round of the world-famous "Captain Obvious
Quiz Game"! Yay!

The questions these week are:

 (1) "If reality and documentation do not match, where is the bug?"
    (a) Documentation is buggy
    (b) Reality is buggy

 (2) "Where would you put the horse in relationship to a horse-drawn carriage?"
    (a) in front
    (b) in the carriage

Now, if you answered (a) to both these questions, and had this been a
real quiz show, you might have been a winner and the happy new owner
of a remote-controlled four-slice toaster with a fancy digital timer.

Sadly, this was just a dry-run for the real thing, to give people a
quick taste of the world-famous "Captain Obvious Quiz Game". I hope
you tune in next week for our exciting all-new questions.

                           Linus
