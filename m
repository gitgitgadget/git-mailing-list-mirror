From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Wed, 18 May 2016 17:19:58 +0200
Message-ID: <CACBZZX6t5RsTe0GCPifA9cq7wbChY-ekVXZOYSqPTuOHp_D4Vw@mail.gmail.com>
References: <20160517032247.25092-1-sbeller@google.com> <CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
 <CAGZ79kaJoAxqtsTuErQSgJiVeD_vdZ1MQXKr-LTtyro-FbscTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 18 17:20:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b33Gq-0003JL-Fe
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 17:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbcERPUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 11:20:20 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:34517 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbcERPUS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 11:20:18 -0400
Received: by mail-qg0-f66.google.com with SMTP id e35so4435057qge.1
        for <git@vger.kernel.org>; Wed, 18 May 2016 08:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=APOT28UZKRPVHxLa+sxrFQ+UtcuxCpDGP6ERoiGYjNc=;
        b=mpmcmTNA0iDCT/7mtgSDqbJNEvKzvM+2r2wK+p7GDh8tvialZLbIAMuKdokuUONDMC
         jlgcVC+c5YfWF3s9xmR38SFAjPrQCnB7QuzjFmkYt59ujyKdywbhb7lFOJoz7eSgiLC8
         /YZ0hWvLJ0xtMt6Sw5ekFGIq5gOe1k6TocFYBFzR/+hY8C7kzYL++u0Hg0Y5HP1ESupC
         OVENTFB2uUaGun6WYo0OQ4jpqAdr7jIbKk8f5uZtanqeHQQ+HGl/3Cv26EC6P27x2Dih
         i28V5nZJQdkfDkJdx7Eho3Zbwv2KguoNO+vOHLYXjdB+qCDC7VpN3UZT6Byu72s3z5JJ
         6chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=APOT28UZKRPVHxLa+sxrFQ+UtcuxCpDGP6ERoiGYjNc=;
        b=UFM9+kZVjTAt5b+yybfyW5Bx0eiTGDRPRnO68sFB0jxRg8SwnAzkbWW3cuoLErHI6t
         CGhNXl9ApDc3mwuNg3yTuFOpoBA07BilO9VxJHueIiHVQHBOaPW3pSCRq3r4BQu0zkra
         nIR5I4aSMPpOhI0DqKmZ7l5QlS8SO35DhZ/w484q1voT9L61A01GwtCrOgOYrcEJwgLu
         EmbmTF/DY18ciT566zKGGQBy4ByWZNyD6+hFywomEPhGPM+EI7bUVL75vj7aGOEU2E9i
         oPdDv4wzdsQWpEDTgmeq8r+cJJ1tSb7Di+a61dmXr20gqXiINANVLO8DYEKQdFFlEKRP
         ILPQ==
X-Gm-Message-State: AOPr4FWDJ/jOP1IyXzyEwTgjwNjG9hSaWGRNPOf5psddYjKe60H8g5ZI31Z3WJ6G0MLhCploBZFt6ANxzXcBmA==
X-Received: by 10.140.108.183 with SMTP id j52mr8131494qgf.90.1463584817731;
 Wed, 18 May 2016 08:20:17 -0700 (PDT)
Received: by 10.55.77.133 with HTTP; Wed, 18 May 2016 08:19:58 -0700 (PDT)
In-Reply-To: <CAGZ79kaJoAxqtsTuErQSgJiVeD_vdZ1MQXKr-LTtyro-FbscTQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294943>

On Tue, May 17, 2016 at 7:58 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, May 16, 2016 at 8:41 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, May 16, 2016 at 11:22 PM, Stefan Beller <sbeller@google.com> wrote:
>>> When using automated tools to find memory leaks, it is hard to distinguish
>>> between actual leaks and intentional non-cleanups at the end of the program,
>>> such that the actual leaks hide in the noise.
>>>
>>> The end goal of this (unfinished) series is to close all intentional memory
>>> leaks when enabling the -DFREE_ALL_MEMORY switch. This is just
>>> demonstrating how the beginning of such a series could look like.
>>
>> Considering the signal-to-noise ratio mentioned above, the goal seems
>> reasonable, but why pollute the code with #ifdef's all over the place
>> by making the cleanup conditional? If you're going though the effort
>> of plugging all these leaks, it probably makes sense to do them
>> unconditionally.
>
> I tried that once upon a time. The resentment from the list was:
>
>     We're exiting soon anyway (e.g. some cmd_foo function). Letting the
>     operating system clean up after us is faster than when we do it, so don't
>     do it.

Not a direct comment on this patch, but has anyone done some detailed
performance testing of this with git? E.g. using a free() that just
no-ops, or one that no-ops unless runtime > x_seconds, or no-ops
unless total_allocated > some_limit.

It might be interesting to play with that as a performance optimization.
