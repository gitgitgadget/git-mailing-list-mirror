From: Jonathan Kamens <jkamens@quantopian.com>
Subject: Re: [PATCH] Revert "stash: require a clean index to apply"
Date: Thu, 25 Jun 2015 17:51:40 -0400
Message-ID: <fab199f5-b69a-4e07-9fb4-6a13b3ed81dd.maildroid@localhost>
References: <5570F094.10007@quantopian.com>
 <20150607124001.GA11042@peff.net>
 <CADQvvWWpjZoXt7=8yAEt110pBTNtBfg7XfPOTbJRfPUH=J3OKw@mail.gmail.com>
 <20150610185635.GA22800@peff.net>
 <xmqq616vl6gm.fsf@gitster.dls.corp.google.com>
 <20150610192734.GA23715@peff.net>
 <xmqqsi9samx1.fsf@gitster.dls.corp.google.com>
 <20150615182721.GA4041@peff.net>
 <xmqqy4jk7muq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?b=C3=A4r?= <crashcookie@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 23:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8F3l-0003d5-VA
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 23:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbbFYVvp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2015 17:51:45 -0400
Received: from mail-vn0-f48.google.com ([209.85.216.48]:33766 "EHLO
	mail-vn0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbbFYVvo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2015 17:51:44 -0400
Received: by vnbf190 with SMTP id f190so13077428vnb.0
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 14:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-type
         :content-transfer-encoding;
        bh=iISoRhraq2sFOc5c8qyq4rusJzcBCwWH/b4JF+Ssf2I=;
        b=FH2mGY+ELrZeNgDT/416jMdexzCYvHcK5BhT0s80AGZzMt9LMQmOSGAeZWk/SYpUpp
         cul+eNCsxrSGu8CxT0aas5wQBFjQTgDSBRdqlr/DJIl+6oJfBzgNT+/udocV1thA7cdr
         bIJYqMzhQO8Ncx8Lw4K5cyda0YvysKCIn9WONjM52vgFfbrlBXwqoQwl/c/Z00nOFpN0
         TXburhwnYjQ5Nyu1Dqy31U17sN0owsBo/DzxkFjtzPqTgrx7Xvd4w0ICiWhXQ8uwa0jo
         xkdcz6D5PlrQJAQcuIbZl1P9o4RFos45fbXjqgkq4Zysrt9NTZaBmq5koa9LQgXA8QVF
         /oBA==
X-Gm-Message-State: ALoCoQkYPSfqgVH1Lc7vqHon4jeHRuQjB3UELAlwof17YfsRz11b12kdN98o44tIKSYtWh0+tfiM
X-Received: by 10.52.72.84 with SMTP id b20mr34003465vdv.6.1435269104151;
        Thu, 25 Jun 2015 14:51:44 -0700 (PDT)
Received: from ?IPV6:2607:fb90:e1b:62e0:b9:fc82:77ca:9d27? ([2607:fb90:e1b:62e0:b9:fc82:77ca:9d27])
        by mx.google.com with ESMTPSA id cj9sm5800818vdd.14.2015.06.25.14.51.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 14:51:43 -0700 (PDT)
In-Reply-To: <xmqqy4jk7muq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272739>

Is this revert going to be applied and released?

Sent from my Android device



-----Original Message-----
=46rom: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: "b=C3=A4r" <crashcookie@gmail.com>, Jonathan Kamens <jkamens@quanto=
pian.com>, Git List <git@vger.kernel.org>
Sent: Mon, 15 Jun 2015 4:11 PM
Subject: Re: [PATCH] Revert "stash: require a clean index to apply"

Jeff King <peff@peff.net> writes:

> Subject: Revert "stash: require a clean index to apply"
>
> This reverts commit ed178ef13a26136d86ff4e33bb7b1afb5033f908.

Thanks.
