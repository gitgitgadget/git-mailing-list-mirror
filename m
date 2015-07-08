From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Wed, 08 Jul 2015 10:36:41 -0700
Message-ID: <xmqqio9uy2ja.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
	<CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>
	<CAEcj5uXiGVvLm==s_SB7GnvBfuKi7j4yH+fgNq4JZtkvK7pZwg@mail.gmail.com>
	<CAPig+cRv6g_nAEdGtrESFiE+5+OxEHwjhEPX0Q0WL+eHzkCAGA@mail.gmail.com>
	<559CCFBE.9000702@drmicha.warpmail.net>
	<xmqqegkjyu0b.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1=KxcYyFfFZ++5Vty-KMv-ci8dtdo4bfX7oj_wgLOE7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Eric Raible <raible@nextest.com>,
	Emma Jane Hogbin Westby <emma@emmajane.net>,
	Max Kirillov <max@max630.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 19:41:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCtH8-0004a4-0m
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 19:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759256AbbGHRgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 13:36:45 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36630 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbbGHRgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 13:36:44 -0400
Received: by igrv9 with SMTP id v9so205386383igr.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=U1RC2B9S2ABt2Q0nVuKW148yuZt/jYDSxghNPzjXH/E=;
        b=ptQXgWC9ZGNVaQGvf4zKFVX/9+/7IrlclZfS8TO+jAtSZQnV4V65z/wJPYGC/TzhGz
         R4BL9wvyKvGgNk4bZNUooHOhd/brwLtDA4TyXQMHKwDZZwDBEfreFq1IjmjjvW2VrAhw
         Oa9VnbTbPgyC1uo2PBvVnIXaQgz4Y+xjcmtVF3tMdJCT3HIiQ4j+Ven4QzUarkR6O6yw
         IeQe5ermaF/r7zyofEkknb7dnyTUnaB0dge0X3al+I8GibkjpTqdY3VqzA2Z0X63qA8J
         voM4+JGk3wXVsQo+nFG8xea6vYpUOERjxOotpcrFoJoCQ9NmwZ5HwqJ9BVt6IYMqXi4H
         imhg==
X-Received: by 10.50.79.202 with SMTP id l10mr63146223igx.7.1436377003432;
        Wed, 08 Jul 2015 10:36:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id w4sm2338269igl.22.2015.07.08.10.36.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 10:36:42 -0700 (PDT)
In-Reply-To: <CAP8UFD1=KxcYyFfFZ++5Vty-KMv-ci8dtdo4bfX7oj_wgLOE7g@mail.gmail.com>
	(Christian Couder's message of "Wed, 8 Jul 2015 12:29:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273693>

Christian Couder <christian.couder@gmail.com> writes:
>
> I think sometimes the details might be interesting for different reasons.
> ...
> With the details, I think readers are more likely to remember the
> --merges option.

That unfortunately cuts both ways.

With too much details, the readers are more likely to skim and skip
the "--merges" buried in reams of text.  Only the ones who carefully
read from cover to cover would discover and contrast the first
iteration "sed" with the second iteration "--merges", but I'd expect
that they would also be the ones who carefully read the docs and
more likely to know about "--merges" without Rev News teaching them.

Used sparingly, the details do pull interested readers in.  The key
word in your message was "sometimes", I think.
