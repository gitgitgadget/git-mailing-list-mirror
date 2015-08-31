From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3] trailer: support multiline title
Date: Mon, 31 Aug 2015 20:26:02 +0200
Message-ID: <CAP8UFD0Y9HTzkGkrKnW3NABdGGVhzfcNPRaL6Ay9oNKMn+rLUA@mail.gmail.com>
References: <1440962080-24804-1-git-send-email-chriscool@tuxfamily.org>
	<vpqtwrfg8dt.fsf@anie.imag.fr>
	<CAP8UFD3KH=5Y+Y3MKu7U-FkSTeu1qFkRYapne8LyNWVT_qF9iQ@mail.gmail.com>
	<xmqq4mjfwcl0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:27:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWTnS-0007C9-VV
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbbHaS0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:26:07 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34306 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbbHaS0D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:26:03 -0400
Received: by igui7 with SMTP id i7so61985249igu.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9B3xIXuwT2Yxv/cuJswVJ2E24eJaeTAEoQlxGaau72I=;
        b=ZBvaJ9eOpXAJorKmc8IHml4JDGzbBWig/YWi1pSYEUKuz/Ha2rjT1Dr/JkHIFTljvk
         mAe2isxeDeVf/Bf42ABeZ1UR0ZHLQIy9Qx/CpMQcNfqlBeEMm9LER9SsZWb/bS+O6l84
         9S74Aw5YYIRIgeM5PVQqJEyGFjlaAUUdzz/ay6T/g3geXpXkUF01UfXx6p2CTaLX3RGt
         AQmZ9/KBfFBRQZT1xpHvRDBT+ziyOy3H6oOrGHxVFwgahNr13bomHG8CDETm8ZSX1nal
         lcfDycSYVnL4woso6MEhTgN8ufg6uEMItHyoZwaIowuZXKJow9FTYXQPAPrQV0F98VCZ
         CTPQ==
X-Received: by 10.50.67.65 with SMTP id l1mr7519921igt.31.1441045562126; Mon,
 31 Aug 2015 11:26:02 -0700 (PDT)
Received: by 10.79.93.131 with HTTP; Mon, 31 Aug 2015 11:26:02 -0700 (PDT)
In-Reply-To: <xmqq4mjfwcl0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276903>

On Mon, Aug 31, 2015 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Mon, Aug 31, 2015 at 10:38 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Christian Couder <christian.couder@gmail.com> writes:
>>>
>>>> That's why instead of ignoring only the first line, it is better to
>>>> ignore the first paragraph.
>>>> ---
>>>
>>> Lacks sign-off again.
>>
>> Ooops, sorry.
>
> Let me forge one just for this time.

Great, thanks!
