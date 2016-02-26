From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged warnings
Date: Fri, 26 Feb 2016 16:33:44 +0700
Message-ID: <CACsJy8Dc1dHp7kGgz_pY1uoXum-k3gnzD0AHFsaLQzuZihUKcw@mail.gmail.com>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
 <CACsJy8CjOkNuEg=QRTATQLkYzMxpf5zryMXERZu6Zn59VDUB_Q@mail.gmail.com> <17AFC0E6-FC83-4BD4-9C19-43A6B9103866@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:40:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZEtI-0001sm-HJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 10:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395AbcBZJkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 04:40:47 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34599 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbcBZJeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 04:34:15 -0500
Received: by mail-lf0-f66.google.com with SMTP id i75so219188lfb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 01:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g7CDXkeoO749qOCl/lHWf1lrKlCHKx9JIVGlbHRaXSE=;
        b=j0b0TQnNO9ibJcSSir0m/W6m/AMq6RaoIHe2jjfxqZoALJDDEmYNs3b0nQDPs16IAD
         PjS01GF4ZSMLYg4gZaXLHwzekqkSfI5dtHBPS6bU5J1v9jDU0OUDJg1y4LfLrBbDpvqz
         HpwWjkwi85DT1zXf8+CPqfqgu1AdLVEpKTBMUIjfifut3IFCdim1qDXaMombGym2fPCZ
         31Ity/lJ3pfV3lJY3vX90CXJI1MobpwsIqZ1+19BRkQ5e+1tYlOZD0+1ZnxWvqdVTGS3
         F0O9LgBrJuHoa+jh2tcQlJhZz6k5CTuUsex6WVc5ZsoQ6yjKhdzbefcv3RG/Nazl0Onq
         ePRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g7CDXkeoO749qOCl/lHWf1lrKlCHKx9JIVGlbHRaXSE=;
        b=ddKJ2XQHVE3z8j6EsvEkJwplhwKQZvH/+sHRiNy0w2RXrKmbc7C+FZv0j7BgQRVyeF
         uvkv/ei0ICkZ5YHZcc49J7LLCLfH8FXH99vk0oVT8rBDqyL1s3JN/GUl1L75jkWpfqJ/
         6nz1zGa40bdj9ozvDC/dYvyemGtJSOFOZrjLfkFdil6o2axSRHgyirNG7e+IdkpWTMWx
         sq8pWl6AP9HuCYubUh2YObmOvsFNT2L0D0JYNp0R+p9a3MAwNuvOUXkcVe0MFrvxGXR6
         bwecx+IMHJmJLjg1/arg60fNic6nxX47qqQI9sGO/GJi6v5W9Tsqrt54uBbId66d+6lI
         mxwA==
X-Gm-Message-State: AD7BkJLkOgHGbU+8LpYMa+Fg6lGXfsx9jJ9lymIcWWg2MQ7RRRZkQcMczp8dMq47IyWzrw6Vd0ac85xxgaiQ8w==
X-Received: by 10.25.5.6 with SMTP id 6mr190372lff.3.1456479253700; Fri, 26
 Feb 2016 01:34:13 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 26 Feb 2016 01:33:44 -0800 (PST)
In-Reply-To: <17AFC0E6-FC83-4BD4-9C19-43A6B9103866@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287560>

On Fri, Feb 26, 2016 at 4:30 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 26 Feb 2016, at 10:26, Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> On Thu, Feb 25, 2016 at 3:42 PM,  <larsxschneider@gmail.com> wrote:
>>> +ifdef DEVELOPER
>>> +       CFLAGS +=       -Werror \
>>> +                               -Wdeclaration-after-statement \
>>> +                               -Wno-format-zero-length \
>>> +                               -Wold-style-definition \
>>> +                               -Woverflow \
>>> +                               -Wpointer-arith \
>>> +                               -Wstrict-prototypes \
>>> +                               -Wunused \
>>> +                               -Wvla
>>
>> With the exception of $(SCRIPTS) in Makefile, I think we prefer to
>> avoid \ and have one addition per statement
>>
> I guessed that because I actually looked through the makefile to find how you deal with line
> brakes. The problem here was that this line gets really long and then it is hard to see what
> warnings are enabled.
> Would you be OK with using \ for readability here?

Probably misunderstanding. I meant something like this

CFLAGS += -Werror
CFLAGS += -Wdecl..
CFLAGS += -Wno-form..
-- 
Duy
