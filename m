From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged' options
Date: Fri, 18 Sep 2015 20:52:37 +0530
Message-ID: <CAOLa=ZRPwoNJv9kG7GfG4ZyjHAoPa7h2PDXErZbV1_B1_ipZ7g@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441902169-9891-3-git-send-email-Karthik.188@gmail.com> <20150917213619.GI17201@serenity.lan>
 <xmqq37ycitps.fsf@gitster.mtv.corp.google.com> <vpqoah0kxtb.fsf@anie.imag.fr>
 <20150918084208.GJ17201@serenity.lan> <CAOLa=ZQmGD2vo1B2K21-f_2RZRXduFt4VNKq2Pp9B_5bO=8=+w@mail.gmail.com>
 <vpq8u83kb5d.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 18 17:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcxVK-0006T7-7b
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 17:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbbIRPXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 11:23:08 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36274 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754393AbbIRPXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 11:23:07 -0400
Received: by vkfp126 with SMTP id p126so31900047vkf.3
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/EjILUoVVdoboRMTwiHZc9FSKXCK2sGedzHNzIOKjzI=;
        b=rB1gdoFCH/x3Wi65LZDCCQeOuqwcSaV3ZiHaows+OQiephNOpr6uFSiwUfUUePnu8O
         MwjUROkNHKeSLzSsaNCUVyakFVaCo9ybR+lubUwKjRplBHTc6Oy1n6CKDf4J+HF8XVuF
         8HoQifC/M4mldXKedzCxEtw6liz95NI2IIX7v/EPbzvz5uY2iHLd9x6BQBot7qHf91ra
         SRmkyulfBf+JWCEUYlCf/Nf+kbVofIVvvl7BDSgiEHu1qqt6jXsnUuWvA2h9GIGpLK/H
         mrVtGG4zQDPZVmIXkhSU01+QxEAs0B64RnOgWFczQ83H3EYfItZRLn/+ykqpHOPYfCXO
         dx8A==
X-Received: by 10.31.142.73 with SMTP id q70mr3888385vkd.13.1442589786338;
 Fri, 18 Sep 2015 08:23:06 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Fri, 18 Sep 2015 08:22:37 -0700 (PDT)
In-Reply-To: <vpq8u83kb5d.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278202>

On Fri, Sep 18, 2015 at 8:49 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Not sure this is much of a problem with regards to "--[no-]merged"
>> I mean isn't the square brackets self-explanatory?
>
> Well, usually --no-foo means "cancel the effect of --foo", ie. "git
> command --foo --no-foo" is equivalent to "git command".
>
> Here, --no-merged=some-ref does not _cancel_ the effect but introduce a
> new behavior that was not the default. So it may make sense to explain
> this more clearly.

maybe we should s/no/not ? makes not sense to me

-- 
Regards,
Karthik Nayak
