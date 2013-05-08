From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 00/10] interactive git clean
Date: Wed, 8 May 2013 11:18:36 -0400
Message-ID: <CAPig+cQ0wC8STfzZTNT=Thu3HuiORnoDDisYD7Bp5W4zwek48A@mail.gmail.com>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<CAPig+cR6aa+xODi=8DoiBpqQZM1eBHkGBvGzMGB2PSiT3osMEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 17:23:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua6Dh-0005Ub-Go
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 17:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755747Ab3EHPXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 11:23:49 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:64300 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab3EHPSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 11:18:37 -0400
Received: by mail-ie0-f178.google.com with SMTP id b11so3303025iee.23
        for <git@vger.kernel.org>; Wed, 08 May 2013 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Lb7Q6gprnlILh8jz5JvNjxBkKg75HbXZmCvm6/+2q90=;
        b=o6glSXjbStSUhQH1bXYW15mbBirErvTJH7E6qmxZRTR1j0tpSGXEkNBju35CL/pipL
         9Z6bW9UJ8V44aHIUsS/MUUhTvRRjttzMHiwP69hfCMLnxce9HJwAFJegoBBP/KQA9PY7
         exHwlq4R689GTDoPf/Be4+brJtrWTb2K/857dkjqqodVnwqbf2+V5V8COnZyrAe5JzUh
         RzAe+beVhr2VMbg2tPObAVfsrzEIdkQsFdTLRKTgbYgz8a19s/m5FfRZclxFIRyGe3mm
         xqJ2UQf6/6QENUPjoiKBuzReOu/ifDjtyXiRvH2c2mjrTauP9N03T6jxljZgPD9eS7oi
         GV+Q==
X-Received: by 10.50.111.233 with SMTP id il9mr6106160igb.103.1368026316480;
 Wed, 08 May 2013 08:18:36 -0700 (PDT)
Received: by 10.64.13.46 with HTTP; Wed, 8 May 2013 08:18:36 -0700 (PDT)
In-Reply-To: <CAPig+cR6aa+xODi=8DoiBpqQZM1eBHkGBvGzMGB2PSiT3osMEw@mail.gmail.com>
X-Google-Sender-Auth: a-60ss_UjB49uFH4dSLRFjlRikA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223673>

On Wed, May 8, 2013 at 11:15 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 8, 2013 at 7:38 AM, Jiang Xin <worldhello.net@gmail.com> wrote:
>>     *** Commands ***
>>       1: clean               2: edit by patterns    3: edit by numbers     4: rm -i
>>       5: flags: none         6: quit                7: help
>>     What now> 2
>>
>> You also could say `c` or `clean` above as long as the choice is unique.
>
> It is not obvious by reading the menu that "edit by patterns" can be
> abbreviated as 'p', and "edit by numbers" by 'n'. If you change the
> names a bit, then the abbreviations become more obvious. For instance,
> one possibility:
>
>   2. filter by pattern
>   3. select by number
>   5. toggle flags: none

By "more obvious", I meant that the initial letter of each option is
now unique across the entire menu:

  2. [f]ilter by pattern
  3. [s]elect by number
  4. [t]oggle flags: none
