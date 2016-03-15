From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2] git-p4: map a P4 user to Git author name and email address
Date: Tue, 15 Mar 2016 18:37:41 +0000
Message-ID: <CAE5ih78VL2CFsLGtjfx_yUXBWSx8VvDB-Gv5NjjsJMq=PQSUhQ@mail.gmail.com>
References: <1456829396-38659-1-git-send-email-larsxschneider@gmail.com>
	<CAPig+cRwEKjGaDA-jy8KJSAhTheJYDmxtPq8SdVs0LA2f9-9Yw@mail.gmail.com>
	<CAE5ih7_EAjMtdNQ6ab2wrN4LMSBBZ=T7w-fPKLtdRqfvFUhzFQ@mail.gmail.com>
	<61210CAD-D3D2-40AC-88F9-02169619F5F6@gmail.com>
	<CB4CAAEA-0036-483A-9F2C-89B95E04037E@gmail.com>
	<CAE5ih79aKHM5yim-U_sauZ7ChgWR82CAre4EC3j5HQ8CCG=w_Q@mail.gmail.com>
	<xmqqbn6f8yzb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 19:38:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aftqn-0004wr-2r
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 19:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965668AbcCOSho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 14:37:44 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35610 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965617AbcCOShm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 14:37:42 -0400
Received: by mail-oi0-f41.google.com with SMTP id c203so20271296oia.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 11:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nFUHmPx4zVhuZ7Mg1Sw6B0L+RdyxRcSGl0VWSZEOOM0=;
        b=F1688Lo7pheiaYT1nimOTg4IJg9dFQTyp64t3myo1rmQsYl83YnU5V/MUMUJuM8Zia
         X9qDiE0wojW/ZzygnTd05DclPLHBo/ToBurxPwADuGhDNTYMjdoCQwQNKL2reJWsUrxu
         uwIo5G6s+psSqrdPQ3IrFxJjiWUMEfNMQY2l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nFUHmPx4zVhuZ7Mg1Sw6B0L+RdyxRcSGl0VWSZEOOM0=;
        b=VPnUS6d5w/K3HZB4/WR/a+U6LwKZoL/8bGDqEDWdbOZ7u4ZoJHqVOwks8GShUBknJB
         TFroQhLMICz+E3vHI6gt1az+AEPREcOW+U+wBV7XT1PLK2I7IsRcb3W1H5X6F9DyHVen
         vkFVA3CWdwioBC1I9XGAqlwgfBILGzjSZEab9A8s0K+BnqbIFhteXCk6DW6xFTIGQYw3
         BQaBY4JbTl2zQiYKQKJg67FnitWKbrrngSQza2kgzsNCIfbXG0vb+Fokl6CRzbhHn8ZK
         5xtjZZCZa4/n/yY7pPc5jqOxC+WL8qStUrjHX+kPIUNhEV3EC7uffNAOylFeql+PGISW
         cSUQ==
X-Gm-Message-State: AD7BkJJ2wriDnhYdK/owiVEUfNuadGLozA6uU+rwTbpi7lcGCUbrHTLzL6MUMJTEbGwUSGfKs5mEb1PbRjUhsQ==
X-Received: by 10.202.224.137 with SMTP id x131mr17977424oig.53.1458067061747;
 Tue, 15 Mar 2016 11:37:41 -0700 (PDT)
Received: by 10.202.172.132 with HTTP; Tue, 15 Mar 2016 11:37:41 -0700 (PDT)
In-Reply-To: <xmqqbn6f8yzb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288889>

Yes please.


On 15 March 2016 at 16:52, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>>> Is the patch uninteresting for git-p4 as it handles only an occasional
>>> exception or did the patch get lost in the noise? :-)
>>
>> I thought it was useful; I hadn't realised that it was needed for deleted users.
>>
>> Luke
>
> So..., should I just pick it up and queue with your Reviewed-by:?
>
> Thanks.
