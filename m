From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH v3] write_pack_file: use correct variable in diagnostic
Date: Mon, 3 Mar 2014 09:20:21 +0800
Message-ID: <CAJr59C1Azr9EnoeRPKZF+AB9GBw1RR7fUkvaYChyTfHwoJSvFA@mail.gmail.com>
References: <1393745411-30980-1-git-send-email-sunheehnus@gmail.com>
	<CAPig+cSuBfuzL-NXYkvFoz5+jPrEUNfTqoMf-iAYyMSv3jDsqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Eric Sunshine <sunshine@sunshineco.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 02:20:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKHYS-0002db-5s
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 02:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbaCCBUY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 20:20:24 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:45716 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbaCCBUX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 20:20:23 -0500
Received: by mail-wg0-f52.google.com with SMTP id k14so636313wgh.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 17:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=8eY0chnY/B6IwUfv2OSp8aXQtd83GrySgtXN/x1W4tg=;
        b=pr4YwZswfEgGMd4DrbkBT8ctazICZx/gSMCosngUg840MmVVi4R04xbDKbOWif0qdk
         m2euIq3LNlN6UnHP8UB5AjrphXirjOMqGsDXV4O0PdM/o0LIfj+PCkRTwo2XUnrYjSRq
         ln+jaeidbtxOaE6kHyV/gTYXsM1RLUIB6PkAeJ2oEb6vZm8QrGs5z/DDEKbMqOraMkg7
         CndNeWDG3A2uoqg642U7rUXJwIJPIcL4TrGwROqquH4NEyiK0n9zIr3nieZ7l9wrVds7
         byCBLe3HebvB10qsh6smNR0N4UHXU4kLdR0AYN/dbXAAnLT1RulSaMFuY08wOoPmfKI+
         GrTg==
X-Received: by 10.195.12.102 with SMTP id ep6mr1216197wjd.76.1393809622017;
 Sun, 02 Mar 2014 17:20:22 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sun, 2 Mar 2014 17:20:21 -0800 (PST)
In-Reply-To: <CAPig+cSuBfuzL-NXYkvFoz5+jPrEUNfTqoMf-iAYyMSv3jDsqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243170>

2014-03-03 2:42 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Sun, Mar 2, 2014 at 2:30 AM, Sun He <sunheehnus@gmail.com> wrote:
>> 'pack_tmp_name' is the subject of the utime() check, so report it in=
 the
>> warning, not the uninitialized 'tmpname'
>>
>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>> ---
>>
>>  Changing the subject and adding valid information as tutored by
>>  Eric Sunshine.
>>  Thanks to him.
>>
>>  builtin/pack-objects.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index c733379..4922ce5 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -823,7 +823,7 @@ static void write_pack_file(void)
>>                                 utb.modtime =3D --last_mtime;
>>                                 if (utime(pack_tmp_name, &utb) < 0)
>>                                         warning("failed utime() on %=
s: %s",
>> -                                               tmpname, strerror(er=
rno));
>> +                                               pack_tmp_name, strer=
ror(errno));
>>                         }
>>
>>                         /* Enough space for "-<sha-1>.pack"? */
>> --
>> 1.9.0.138.g2de3478.dirty
>
> Nicely done. Everything is where it ought to be.
>
> As this is an actual bug fix (not just a GSoC microproject):
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Thank you so much for everything you have done.
I am honored to do this with all your support and kindness.

Regards=A3=AC
He Sun
