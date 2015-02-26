From: Stefan Beller <sbeller@google.com>
Subject: Re: compiling master fails
Date: Thu, 26 Feb 2015 12:57:28 -0800
Message-ID: <CAGZ79kZ-4-5zD4xZn7sLjvT3WJEueGFKT6Df7V1By77u5uosgA@mail.gmail.com>
References: <CAGZ79kaRJg1QzFSyj0iAtUn2nUFxzZRy7BsrYC2++kaN0RD1Aw@mail.gmail.com>
	<CAGZ79kZvVFTGASbsx6vZXvYJUwLjgqDeCGrN0Cz=3pjW58Qbyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	eungjun.yi@navercorp.com
X-From: git-owner@vger.kernel.org Thu Feb 26 21:57:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5V0-0005Ro-NF
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 21:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbbBZU5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 15:57:30 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37280 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbbBZU53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:57:29 -0500
Received: by iecrl12 with SMTP id rl12so21070445iec.4
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 12:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=rFW5TwnOY9p0E62kV++jBkUMMjmAm2m7mO4byODMSW4=;
        b=b1cCKk8Q+stRKsro9PjKFpF8Oh8HyW1mUA+UT6J5qjKcyAwfcLKtnLSfdcbNJ1QaSJ
         mXS4Ir68IhnTiMmTruGksfxYAOtZizixjBrr+DH9pwuQliTCft3SNFrw6Pzdd0mMqUIS
         /gvWiH+8C49XC2H2RnuVwuoTRZeYVM5NS/PlMlV6fNalFFyDtRxgVAzG6wb7pmUDi0oD
         qRqYMRzSJVUnPa66h3OGW5YeBdRBVwSF3e6x4/EbgsA1KalWsNC74AOeasZYyr6DNBXn
         PNBCKx7XuQRBy6fCtc8+YqtQjPUNf80atrPZWTj01XkoU8ylJn71m1UMKJ1JIE7DkBgW
         0qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=rFW5TwnOY9p0E62kV++jBkUMMjmAm2m7mO4byODMSW4=;
        b=YnWy6D5onVg1ITwVXtv0OaJ4yjvfHXfrStDwQFyO8/6238ialm+9qPLCSelz09fCUx
         4u0W66CEqTomFUUCsB00ix6RrlA8INx0+ooAX+QhIRt0LRpRmi2d7IQxQOcHalgtYazh
         HpMijIHzv1p8Iuh8Pz9MwZKmeGcT+YaF0fo9+TdQwy1cRBk4QjSNZho2RWIZqlIFeIHs
         f7SAr0BF5kTQeUaPJnSRAXFpw7kJi80FhO0G1TPHd9+hCDzpP5bBD/wbuLSen8yJGga7
         nLGrVtWvbdjFmQEcSnIddnWRvQw0lwVim3Ykmu+NfxLk8n2iNv2LnFpmv4N9/B1QFIDc
         s6hA==
X-Gm-Message-State: ALoCoQm0f8HdOLMLjGCZxgzc6mbflm7TqOPr+d7t+huBrHoT3rqtuGJjVxKKXXkvnXw8jzc/gm67
X-Received: by 10.43.100.67 with SMTP id cv3mr12026684icc.92.1424984248820;
 Thu, 26 Feb 2015 12:57:28 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 26 Feb 2015 12:57:28 -0800 (PST)
In-Reply-To: <CAGZ79kZvVFTGASbsx6vZXvYJUwLjgqDeCGrN0Cz=3pjW58Qbyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264460>

> On Thu, Feb 26, 2015 at 12:48 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Post 2.3 cyle (batch #5) (v2.3.1-167-g7f4ba4b)
>>
>>     CC http.o
>> http.c: In function 'get_preferred_languages':
>> http.c:1021:2: warning: implicit declaration of function 'setlocale'
>> [-Wimplicit-function-declaration]
>>   retval = setlocale(LC_MESSAGES, NULL);
>>   ^
>> http.c:1021:21: error: 'LC_MESSAGES' undeclared (first use in this function)
>>   retval = setlocale(LC_MESSAGES, NULL);
>>                      ^
>> http.c:1021:21: note: each undeclared identifier is reported only once
>> for each function it appears in
>> make: *** [http.o] Error 1


On Thu, Feb 26, 2015 at 12:52 PM, Stefan Beller <sbeller@google.com> wrote:
> Removing config.mak makes it compile again.
> config.mak contained:
> CFLAGS += -Wall -g -rdynamic -O0
> # CFLAGS += -Wextra
> # CFLAGS += -Werror
> CFLAGS += -Wno-format-zero-length
> CFLAGS += -Wdeclaration-after-statement
> CFLAGS += -Wpointer-arith
> CFLAGS += -Wstrict-prototypes
> CFLAGS += -Wold-style-declaration
> # CFLAGS += -flto
> # CFLAGS += -fwhole-program
> CC = /usr/lib/gcc-snapshot/bin/gcc
>
> Mind that compiling did work with this exact version of
> config.mak, (I did not touch it for a few weeks now),
> so I suspect new changes in changes to break the
> compilation.
>
>


"git bisect run make" shows
f18604bbf2c391c689a41fca14cbaeff5e106255 is the first bad commit
commit f18604bbf2c391c689a41fca14cbaeff5e106255
Author: Yi EungJun <eungjun.yi@navercorp.com>
Date:   Wed Jan 28 21:04:37 2015 +0900

Is there an easy way to fix it or is my config.mak bogus now?
