From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 11:29:45 +0200
Message-ID: <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com>
	 <46F55E03.2040404@krose.org>
	 <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
	 <20070923020951.GF24423@planck.djpig.de>
	 <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Alex Unleashed" <alex@flawedcode.org>,
	"Kyle Rose" <krose@krose.org>, "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 11:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZNmj-0003Ws-3j
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 11:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbXIWJ3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 05:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbXIWJ3r
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 05:29:47 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:13181 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752598AbXIWJ3q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 05:29:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1158360rvb
        for <git@vger.kernel.org>; Sun, 23 Sep 2007 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=D5yBwjAytfXla3OkletTcMgOyVnY+qttLpMLX17aRCw=;
        b=B30DCzi1TGZBNalSdrZNAQu0966bLH5oHdzjCWS4iWbB6420yZhya/84KlFnOqXScSDLFijhAC6ogldreXDcmcisqAetcKCy0Hk5pqnGAvLcSxPwqRATwcjbaTGcuhKbZA1C2SsnSN+Bf+QgGlhubWdzZ5dZxGyhupNFACqblXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QTFmyQJqhGViP6bIAC90Pb0IV/SCOaDoNAIfss3zpzDiDuugIrMOuYvsWZybInyO3PcRQUnFq8AYSHmR9zGK9bG/hDUNSIr2IeGgva2s4tQaIj4tfieaseWgDf1M0luPr2H3gOQZVrUk8+Q4dQlpoGcswyArS1bu9EAaGJmqCKI=
Received: by 10.141.161.6 with SMTP id n6mr1325564rvo.1190539785651;
        Sun, 23 Sep 2007 02:29:45 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sun, 23 Sep 2007 02:29:45 -0700 (PDT)
In-Reply-To: <851wcpsv4z.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58956>

On 9/23/07, David Kastrup <dak@gnu.org> wrote:
> David Brown <git@davidb.org> writes:
>
> > On Sun, Sep 23, 2007 at 04:09:51AM +0200, Frank Lichtenheld wrote:
> >>On Sun, Sep 23, 2007 at 12:50:00AM +0200, Alex Unleashed wrote:
> >>> I'd say being forced to be explicit is a good thing here, so that the
> >>> programmer at least has some sort of good understanding of what is
> >>> going on, and chances are that if he doesn't really know, things just
> >>> won't work out (quite unlike a lot of other languages where this
> >>> programmer might actually end up with something half-assed that
> >>> "mostly" works).
> >>> For some reason it seems to me a lot harder to find bad programmers
> >>> surviving using C than a lot of the other languages.
> >>

Well, according to your reasoning assembly should be the gotha of
elite programmers, only very disciplined and meticulous programmers
survive, much more then in C.

Is this a good way to measure a language?

>
> C++ is good for creating black boxes.

Object oriented languages creates black boxes: that's the reason why
object oriented exsists and also the reason why Linus hates it ;-)

Difference between C++ and other OO languages is mostly in the size of
the applications written in that language IMHO.

C++ noramlly has the bigger code bases, so problem you mention are
enanched and perhaps seem to depend on the language itself not on the
size of application. IOW a Python (Ruby) app probably does not have
the size of Firefox or Open Office, this _could_ induce the naive idea
that the python app is cleaner or easier to understand just becasue of
Python vc C++.

I really don't think so. I think this could be true for toy problems,
but for real, for big applications is the design of the appllcation,
not the language, that at 90% state the difference between clean and
crap.

>A black box that has been
> fitted into its environment and that has good innards is fine.  A
> black box with rotten innards, or not really being well-suited for the
> job at hand, isn't.

I really agree here. The biggset downside of OO is that for it to work
you should have a much deeper knowledge of the problem you want to
handle. OO force you to analyze more and know more because a bad
design normally means throwing everything in the trash can and start
again.

Procedural programming as C is more immune to this 'good problem
analysis'  dependency.

Marco
