From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Thu, 18 Apr 2013 00:17:21 +0100
Organization: OPDS
Message-ID: <BCD944518C304D7D9809346DD899B68F@PhilipOakley>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com> <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com> <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com> <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de> <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com> <5161D3C5.9060804@web.de> <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com> <20130407212342.GA19857@elie.Belkin> <CACsJy8BoWfng7p=kHbiF9s6XYH1mPMtAGW6BRz54uYM5454O0w@mail.gmail.com> <CALkWK0mcnA8Qss3uxRXhfHst65RLkv43wje9xdFxmFKi7MtZvA@mail.gmail.com> <CACsJy8Bz+yNefiiwEivaaUgRymHTmUUKEFs8_uuonhmRfT3UGg@mail.gmail.com> <CALkWK0m9QmZaSDruY=+2F-Kkw+fd6E1TYC
 TBpVQHRJrzq2VjCQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jonathan Nieder" <jrnieder@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>,
	"John Keeping" <john@keeping.me.uk>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 01:17:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USbbW-00033t-2d
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 01:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab3DQXRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 19:17:25 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:52948 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751453Ab3DQXRY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Apr 2013 19:17:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlgOAPArb1FZ8Yje/2dsb2JhbAAuIoMGg2eFP7daBAEDAYEDF3SCGgUBAQQBCAEBGRUeAQEhBQYCAwUCAQMOBwEEAgUhAgIUAQQIEgYHFwYBEggCAQIDAYdxAwkKqnuIcQ2JXYEjiySBEVhqgjoyYQOOQoZhjVuFHIMMO4E3
X-IronPort-AV: E=Sophos;i="4.87,496,1363132800"; 
   d="scan'208";a="426051435"
Received: from host-89-241-136-222.as13285.net (HELO PhilipOakley) ([89.241.136.222])
  by out1.ip01ir2.opaltelecom.net with SMTP; 18 Apr 2013 00:17:16 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221585>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Wednesday, April 17, 2013 12:56 PM
>
> We've been over this several times in earlier emails.  [...]

> Again, I'm not saying that my approach is Correct and Final.  What I'm
> saying is: "Here's what I've done.  Something interesting is going on.
> It's probably worth a look?"
>
[...]
>     The point is to
> have structured parseable information that the object-parsing code of
> git code and easily slurp and give to the rest of git-core.
>
> Please clear your reading backlog to avoid bringing up the same points
> over and over again.
> --

Ram,
The email thread is pretty long with a lot of too and fro, that would be 
difficult to catch up on (too much $dayjob+$family vs $sparetime).

Would it be possible to summarise the key points and proposals of where 
the subject is now?

The submodules does need 'fixing', as does agreeing the problem and 
abuse cases.

Philip 
