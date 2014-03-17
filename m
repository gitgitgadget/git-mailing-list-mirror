From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Mon, 17 Mar 2014 16:39:34 -0400
Message-ID: <CALs4jVEqAVXEjioHniu8Wf8c+nb_JQXG5gn__AZ+urc5tbx=Ag@mail.gmail.com>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
 <1394742059-7300-1-git-send-email-zhaox383@umn.edu> <CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
 <xmqqiorghgaj.fsf@gitster.dls.corp.google.com> <CAPig+cSG0YsdTGWWyxWrg+s235qDe7Xr-jXT2mOkpvA6OaGWyg@mail.gmail.com>
 <7v38ihuvq7.fsf@alter.siamese.dyndns.org> <5327027D.6090500@alum.mit.edu> <CAPig+cQ07mqZDsHQ7qgWARx6eZ2mD+-w0YF3pJXwiJxufj-peg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:40:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPeKH-00070T-Ar
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 21:40:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbaCQUj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 16:39:57 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37590 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbaCQUj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 16:39:56 -0400
Received: by mail-wi0-f181.google.com with SMTP id hm4so2804846wib.8
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QY+2XLM2lbhhG2UqsBggBOQqUvpNnL3RCr55ewvJy3w=;
        b=B6jd3/lse04S6mJEbn7Jnn0Nz8qk3XDNrNBmypfIx/6f01sl2HKGKxmA/G8a20TAhx
         2OQTj7hoP4rxJbFQBUuAlmguaZxIKHgWAMKvTlBKpnm+THnGNYJpneGRRc3Xsz7AwTHC
         ZJfRYFKlLnp1CuPlsBSuKBhviRZlRONuCox9sO1PR1JObH87Wl52o7Kj1lUu/Xr4LEPx
         LoYysO7Irs1ikZDKW2LwMTtQx/qVGUJxkWjs/Zs6OEehLXSOK9JbQnQRYgI2kgOty3Up
         TNc56tD81pCZ5JdLmldBRRziUV288UXCpS2zMLdDu25TZDWQ3rg1/ZC7ngoFXhPgXYG6
         +TEw==
X-Received: by 10.180.100.169 with SMTP id ez9mr11520342wib.15.1395088795000;
 Mon, 17 Mar 2014 13:39:55 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Mon, 17 Mar 2014 13:39:34 -0700 (PDT)
In-Reply-To: <CAPig+cQ07mqZDsHQ7qgWARx6eZ2mD+-w0YF3pJXwiJxufj-peg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244281>

2014-03-17 15:27 GMT-04:00 Eric Sunshine <sunshine@sunshineco.com>:
> A quick (perhaps inaccurate) search of the mailing list shows that, of
> the remaining "untaken" items, #10, 11, 12, 15, 16, and 18 have had
> just one submission, and #13 had two, so we're okay.

I am still working on #14: "Change fetch-pack.c:filter_refs() to use
starts_with() instead of memcmp(). Try to find other sites that could
be rewritten similarly."
Another version of the patch should be on this list within the hour.

Quint
