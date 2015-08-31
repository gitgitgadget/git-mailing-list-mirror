From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] trailer: support multiline title
Date: Mon, 31 Aug 2015 11:13:31 -0700
Message-ID: <xmqq4mjfwcl0.fsf@gitster.mtv.corp.google.com>
References: <1440962080-24804-1-git-send-email-chriscool@tuxfamily.org>
	<vpqtwrfg8dt.fsf@anie.imag.fr>
	<CAP8UFD3KH=5Y+Y3MKu7U-FkSTeu1qFkRYapne8LyNWVT_qF9iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:13:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWTaK-0004OR-S1
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbbHaSNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:13:33 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35687 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbbHaSNd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:13:33 -0400
Received: by pacdd16 with SMTP id dd16so146772691pac.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7KHC6wtg8Sc12csdqJVwsT0NRgYijfBXue/dqGpaqp4=;
        b=qUDmToZ+s0mw1ctS3X1v2NS0x/IE2/tqPibZj1T6jWFk66eiPGydx4JfvsUyj2Tlab
         Q45F02mEdtB89StjvuKpF7xU6d43TAV+Gp4ArONvCF6XUBHlgZznDfs3jzBEysUWN2jj
         aX1JJcIl3kLyedaf38lnDopXIuHUVfrORNINzzwYKDjjmXInhUjeXYKEuo7FU8sXVJWB
         jhhRRXzkMFskCkGQTZ7mUEsZmet96js+ogK72kvMiPdOSQkApnpy2NNOf+KOpV6jmQqi
         lYn45NPjIiac451QzfjjHcHpw79UPYY4H9861pTfYVO21ZdVc4gghZ5RhzMRjP9KN8BU
         o70Q==
X-Received: by 10.68.68.198 with SMTP id y6mr39983511pbt.30.1441044812677;
        Mon, 31 Aug 2015 11:13:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id jd12sm11735099pbd.44.2015.08.31.11.13.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 11:13:32 -0700 (PDT)
In-Reply-To: <CAP8UFD3KH=5Y+Y3MKu7U-FkSTeu1qFkRYapne8LyNWVT_qF9iQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 31 Aug 2015 11:14:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276902>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Aug 31, 2015 at 10:38 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> That's why instead of ignoring only the first line, it is better to
>>> ignore the first paragraph.
>>> ---
>>
>> Lacks sign-off again.
>
> Ooops, sorry.

Let me forge one just for this time.

>
>> This replaces PATCH 2/2 in your previous series, but requires PATCH 1/2,
>> right? If so that would be simpler to resend both patches IMHO.
>
> This first patch is already in master. That's why I only sent the
> second one. But yeah I could have explained that after the three
> dashes.
>
>> The patch works for me, thanks.
>
> Thanks for reviewing and testing,
> Christian.
