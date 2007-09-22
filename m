From: "Alex Unleashed" <alex@flawedcode.org>
Subject: Re: [OT] Re: C++ *for Git*
Date: Sun, 23 Sep 2007 00:50:00 +0200
Message-ID: <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <46F5318A.4030103@krose.org> <877imishdp.fsf@catnip.gol.com>
	 <46F55E03.2040404@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miles Bader" <miles@gnu.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "Kyle Rose" <krose@krose.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 00:50:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZDnn-0005xh-KD
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 00:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbXIVWuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 18:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752806AbXIVWuI
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 18:50:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:13961 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbXIVWuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 18:50:06 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1084857nfb
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=Q9l91+oZUZwJ7cto+Rpyydu8d+q90+zA0d7z/ePuFBs=;
        b=PlqDd3kApgUmaTLbkPeTaBjVzKt7Vuv51suHESH08mI19zJTUejeno+Vl84YkOAr04XOIHiAjJwmxMawrElT4SLCHVUjrIzU5q0zYKlWtE3LlH7T4YnXvoznKDoS+6vy7Ja0hWHrCpjfHMLYomeZlX7FPCj0fc1kzhEP++0IaaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=H+vJNclVPn/w5bY/Ee2Z8p+wI21xd8Y02/554YzhcBM2GsUocnIzeXB6wLiHNUX0awZLTXHwPZQ7NOY7hEpsjqATnbIgAaP6jWJNzBzPxwJ7c/InW6jJ8KcJCf3BHdwSkDFIofcmtPnerC4g3VcIvaxg1z3V8ZPriC8jdCQ9QL8=
Received: by 10.86.80.5 with SMTP id d5mr3424465fgb.1190501400527;
        Sat, 22 Sep 2007 15:50:00 -0700 (PDT)
Received: by 10.86.71.16 with HTTP; Sat, 22 Sep 2007 15:50:00 -0700 (PDT)
In-Reply-To: <46F55E03.2040404@krose.org>
Content-Disposition: inline
X-Google-Sender-Auth: 20a6de2827aea1e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58945>

On 9/22/07, Kyle Rose <krose@krose.org> wrote:
> C++ is in the same category as Perl IMO: too easy to produce unreadable
> code.  I contend that C is pretty much just as bad, though in a
> different way: while C lacks C++'s ability to bury code in multiple
> layers of opaque abstractions, C makes up for it by providing absolutely
> no GC-type structures (i.e., I do this now, you clean it up later when
> I'm no longer interested in it).  C is all explicit, which is nice when
> you have a good handle on everything that is going on *or* an explicit
> system for remembering to do those types of cleanup tasks that is
> well-understood by all developers involved.

I'd say being forced to be explicit is a good thing here, so that the
programmer at least has some sort of good understanding of what is
going on, and chances are that if he doesn't really know, things just
won't work out (quite unlike a lot of other languages where this
programmer might actually end up with something half-assed that
"mostly" works).

For some reason it seems to me a lot harder to find bad programmers
surviving using C than a lot of the other languages.

Alex
