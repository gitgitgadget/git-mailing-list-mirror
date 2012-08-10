From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 15:29:24 -0700
Message-ID: <CAJo=hJsaQyBEjH8uWHqnR9Sk9HwFqCwe81HRN3HxUi2j76YNAg@mail.gmail.com>
References: <20120810075342.GA30072@sigill.intra.peff.net> <7vfw7ulq0a.fsf@alter.siamese.dyndns.org>
 <20120810174605.GA29113@sigill.intra.peff.net> <7vlihmk2ab.fsf@alter.siamese.dyndns.org>
 <20120810215020.GA1841@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 11 00:29:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzxiK-0008DN-0S
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 00:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760203Ab2HJW3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 18:29:46 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64910 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758879Ab2HJW3p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 18:29:45 -0400
Received: by yhmm54 with SMTP id m54so2172626yhm.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nmJGIYzCWUU0PCOKIHevT16WhJ6dFl6wRXj9O5EcmqQ=;
        b=MtqeMgwE94FJk96neaIi3/dwAJ/0ZakybwsaLf0H8zPYMudcZQXatMa2sY5f89+vBE
         yO++H6Fnv+u6Q3efabFWpNgYCwv0ZOENlB4ojvHbopIvvV3tsVRXlTco9XcgRgkwTaXZ
         9Ele62wkPj/ddCYafyYZJ2Iy21HD1tIG+khuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=nmJGIYzCWUU0PCOKIHevT16WhJ6dFl6wRXj9O5EcmqQ=;
        b=Qo8m5gSlSgSLE6BOEU7iOUwlx2hFlvGPtSol8TDDfZFA2HJQ6j/rT4tKK12ZI7Rhlu
         /16UhX4CNJ2dgC2rk2m0RD8S/2Gtt7ixU0s/alevOa3EJwf5/ONfdLyO5AJjjz+mCRXj
         FJRvN+iodjSOBTnJT1nNhyTndSS/UHTfRN2SFYkUqByz0LxGMMcc7qkUr+skAIYyKl5O
         p14x61SIxYHBAZnLK6r2qW6cgkSpTwHouWjxfi0RjjvY4y3GOo3qJL8rxlcUWhw+ApTb
         DTFVkBVRlWXmOig464c0I+vFX4KA+B97y7EouU1sKtrzu3EeU2g2+1BkBX680K9xDQ5/
         4krQ==
Received: by 10.50.236.4 with SMTP id uq4mr3233666igc.18.1344637784634; Fri,
 10 Aug 2012 15:29:44 -0700 (PDT)
Received: by 10.64.22.231 with HTTP; Fri, 10 Aug 2012 15:29:24 -0700 (PDT)
In-Reply-To: <20120810215020.GA1841@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQnK3ScSSqJm21ST+IbuL8fl2LlSjpr5stWIOWVzt4DufIZ7VfdPNVCyjVMnVdX169y1AMfk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203273>

On Fri, Aug 10, 2012 at 2:50 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 10, 2012 at 11:52:28AM -0700, Junio C Hamano wrote:
>
>> When evaluating a change in the interoperability area, it does not
>> add much more confidence to the correctness that the change has been
>> in use for months with the same partner than that it has been used
>> to talk to many different partners even for a short period of time,
>> I guess.
>
> Traditionally our interoperability testing has been to cook things in
> "next" and "master" and see if anybody complains. It would be nice to
> have an interoperability test suite that could hit some common hosting
> sites, as well as older versions of git-core itself. I suspect
> automating that would be a big pain, though.

I don't know that you need to hit the hosting sites themselves, just
the implementations they are using. Dulwich and JGit are both open
source. It should be possible to build a smallish compatibility test
suite that grabs everyone into one tree, compiles a small test server
from each, and runs the matrix locally. Then its up to the hosting
sites to worry about making sure their implementations are included in
this suite, and up-to-date.  :-)
