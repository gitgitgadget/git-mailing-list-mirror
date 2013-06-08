From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 16:13:59 +0200
Message-ID: <CALWbr2x4xGjYXa30vpbK4Q2WAVfmzuz1jNWFyGKSPO0To4P-0w@mail.gmail.com>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com>
	<CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
	<CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com>
	<CAMP44s1p-VDMLNhoym5fH3XAn8CWqu2yqGq0mb+55qHOq-r_ww@mail.gmail.com>
	<CALkWK0mBnG7houMKHDorz3oSm=R7u4Va1s=AepSM0CPY6Gy4cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:14:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJu9-0003p7-EK
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab3FHOOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 10:14:00 -0400
Received: from mail-qe0-f51.google.com ([209.85.128.51]:36573 "EHLO
	mail-qe0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab3FHOOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 10:14:00 -0400
Received: by mail-qe0-f51.google.com with SMTP id a11so1297156qen.24
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mQnwcf2DLjzVNk5U8oWEoq2HeHNqm4+s4+2uxVcuTak=;
        b=raUCfNtGR/2mwYsaRnu0JNRxX80Fe0e1ZyJcBCxJn/vDtySaHb8gC3gKy+V7J8iEgK
         kaxvj3P+abB0MZf+LoexvB4N3cylQh+8wivUGmZCpOmDcnLpZTY6deU/EGHZjn6T4Rpw
         EgLr2UmoiXeyYKV/L0Z+511NO9PpNLC1JIOoT4UdUR6TK9t1/p7QtAfCfZz4wWSZrrVq
         2ISOxDgV5uFcNKreYFSOIfG3WiscSOst9SxHIxYAWxX9qL5cxaxtScIDPC7ZB8RuX41B
         qBsE0v/WqiPcoD/J6htcTkmkW1gD/DGMJnvPEisXcSi2nCyZPfzNaoKm7pX3iP92Y6PU
         rb1w==
X-Received: by 10.229.170.199 with SMTP id e7mr1222261qcz.29.1370700839285;
 Sat, 08 Jun 2013 07:13:59 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Sat, 8 Jun 2013 07:13:59 -0700 (PDT)
In-Reply-To: <CALkWK0mBnG7houMKHDorz3oSm=R7u4Va1s=AepSM0CPY6Gy4cw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226831>

On Sat, Jun 8, 2013 at 4:04 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>> Ofcourse they're implementation details.  Even in this very test, I
>>> check $dotest/autostash plenty of times.
>>
>> The more the test relies on implementation details, the worst.
>
> I'm not convinced about this.

My understanding of these tests is that they make sure new/better
implementations don't break the user experience/defined behavior. If
the test relies on the implementation, then they lose most of their
interest.
