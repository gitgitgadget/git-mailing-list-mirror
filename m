From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft of Git Rev News edition 5
Date: Wed, 08 Jul 2015 00:43:16 -0700
Message-ID: <xmqqegkjyu0b.fsf@gitster.dls.corp.google.com>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
	<20150705191101.GB9815@flurp.local>
	<CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
	<CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>
	<CAEcj5uXiGVvLm==s_SB7GnvBfuKi7j4yH+fgNq4JZtkvK7pZwg@mail.gmail.com>
	<CAPig+cRv6g_nAEdGtrESFiE+5+OxEHwjhEPX0Q0WL+eHzkCAGA@mail.gmail.com>
	<559CCFBE.9000702@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
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
	Paul Tan <pyokaga
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:44:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCk1e-0002Ve-GF
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253AbbGHHoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:44:01 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35945 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbbGHHnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:43:20 -0400
Received: by igrv9 with SMTP id v9so194107181igr.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 00:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NMSo2fqFoqXgEobFXgJbVmp7/ZbY37Zm5M0acnAqtP0=;
        b=mgGWCmz9Ce9dxg/RMfUqJwrh5/xEWMqdhdfrMl3Z3gQAm1qqI+1gR957pGz3QTRpvX
         C4MIFGujGuAhBuM0Hr6OHoGHIbztHjA1Xc/bXaK1dGN/o+ko14L/7cW/YpVt323VRd7t
         sLH0mT8ri44JTMNkz8a1a5d/ihKz8lmAx4w2zNf4zdXflyYgwKv8zcr7RoZGvTTiZZki
         +7Scij9H8KKkPb+O816OtTQFYu/9RV87O+sqkMMt4LMRYGvaLW7lzIFx6lx8rmLZpsT8
         kZwa3tlHTSFUjUKKZ07nxxQzBrI+Bvm0bX6IUlzYJ0C9nXnEjKlmB5kwN4zbU8BHAQZc
         if6w==
X-Received: by 10.50.50.201 with SMTP id e9mr6909488igo.0.1436341399117;
        Wed, 08 Jul 2015 00:43:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id d8sm1358935igl.19.2015.07.08.00.43.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 00:43:17 -0700 (PDT)
In-Reply-To: <559CCFBE.9000702@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 08 Jul 2015 09:22:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273648>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Maybe a matter of taste, but I think in general we could do with a bit
> less of "narrating" and more of "summarizing".

True.

> Just as an example, in the section on "visualizing merge diffs after the
> fact", few people will be interested in the detail that I pointed out
> the "--merges" option of rev-list to Dscho. While that recollection is
> true and everything on the git-ml is public, I consider "Git Rev News"
> to be "more public", targetted to a wider audience than the regulars.
> They don't all know how much Git owes to Dscho. If things like this end
> up in the news it makes me ponder for each on-list reply whether I'd
> rather reply in private. Maybe I'm being overly sensitive (though not
> affected in this case), but I just feel there are different degrees of
> "public".

I do not see "Michael pointed out that there was a slightly better
way to do that" as saying anything bad about his contribution.

I however do agree with you that we want to see the newsletter aim
to summarize things better.  Instead of saying "Dscho suggested X,
Michael then refined it to Y", with full details of what X and Y
looked like, it would be more appropriate for the target audience to
say "Dscho and Michael worked together to come up with a solution
Y".
