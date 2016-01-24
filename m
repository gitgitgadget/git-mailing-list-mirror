From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 09/11] config: add core.untrackedCache
Date: Sun, 24 Jan 2016 16:31:07 +0100
Message-ID: <CAP8UFD1kX2bQaaAd+P3-cZaLw1cTabyyZmab5tGR1kYpQVvR4A@mail.gmail.com>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
	<1453283984-8979-10-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kZzPOQ=w98bvGNMtb_AMd4+GvNBiDop14J6rp3aW6z72g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 16:31:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMdG-0001xZ-DZ
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbcAXPbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:31:10 -0500
Received: from mail-lb0-f196.google.com ([209.85.217.196]:35095 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbcAXPbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:31:09 -0500
Received: by mail-lb0-f196.google.com with SMTP id dx9so5826374lbc.2
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cjXDdLKzDHRA2tjJzpJxb+LSVPjbCbIvNrzKQ40rQZQ=;
        b=RvpQmAng5H7z/YC0HvLrPw+RANzpUQhRPvvTcJLXI/UukwT2KGjssf263Wd8tNyShf
         31d/O3Mf2ww4Cs75FsoaVu31QiA6KGuQzcSw63Kdy4nmobZlTRY6Y+ipph31SuMKp8Ds
         mnS28tFW8C6kL/gc9KzZEufVDl4de8ZH0zysBj9kSrlU7HQ7MsUeyBTewAl3L3LNP6SD
         s28MRqu1T6q6wa2Fosm/ib0fCwObo6s9/fcFLjJVK2xAO3qnwi1L/CIyZsnGvFaYF6YJ
         yUvRWYcpeG0hxsX1z6EGW5LSjRo7KwYODLZeJFvyzg3i/HhUYqAWEWdffM5M5bNppNlK
         xVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cjXDdLKzDHRA2tjJzpJxb+LSVPjbCbIvNrzKQ40rQZQ=;
        b=j68TpEFRSMyDnWMgFO1SnW54g21aOM6k1fUvgeUO+EbpDgaZT9FUR5SU6F7zN4V+De
         y4XJ7fJZXlRPtihBKHi0lEQfP7Dt9JfqBMEdeVagsAkzAzA+UzoHYxFbjAFGq7CUBFlD
         wm535mu1LXczWAku8m5V0TvF1+HN0f5WB5hYi3Rnha3pSCzSlThR16+csarlZWmO9HRV
         tEes2yigkLdHtAlNz5+jstAeuEC4p3outumK17RR9AqZKIhtB0A70kG3keEFcuug45JW
         af8S1Ng7N9lb22diB4k5fjY5OmFNqXqpyCtLgkkwAjy4NCwq7P6lSwOpOPDsBRNFKyam
         UKhg==
X-Gm-Message-State: AG10YOREgPA22P21qwbgKfjeEBo6nL8CDuzks23zz3vUFFO/vUOYr19Ln4WOjR1xsnf4hQ8eqq23iySuRvDVog==
X-Received: by 10.112.142.101 with SMTP id rv5mr4503527lbb.101.1453649467771;
 Sun, 24 Jan 2016 07:31:07 -0800 (PST)
Received: by 10.25.216.143 with HTTP; Sun, 24 Jan 2016 07:31:07 -0800 (PST)
In-Reply-To: <CAGZ79kZzPOQ=w98bvGNMtb_AMd4+GvNBiDop14J6rp3aW6z72g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284663>

On Sat, Jan 23, 2016 at 1:56 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Jan 20, 2016 at 1:59 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> When we know that mtime on directory the environment gives us is
>> usable for the purpose of untracked cache, we may want the
>> untracked cache to be always used by default without any mtime
>> test or kernel name check being performed.
>
> I had to read this twice to understand, how about:
>
>     When we know that mtime on directory as given by the environment
>     is usable for the purpose of untracked cache, we may want the
>     untracked cache to be always used without any mtime
>     test or kernel name check being performed.

Ok, thanks!
