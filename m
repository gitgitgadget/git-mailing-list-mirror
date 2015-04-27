From: Stefan Beller <sbeller@google.com>
Subject: Re: Regular Rebase Failure
Date: Mon, 27 Apr 2015 16:55:12 -0700
Message-ID: <CAGZ79kY7kLF=uNm13xuqETMB1S+uwnB09_NzgU32bpODJHg8tg@mail.gmail.com>
References: <553685E0.8010304@gmail.com>
	<CAGZ79kadXgsdCLH-YFQ5RhyKbRv9-qmUOQo-9QkKM2=8p17j+g@mail.gmail.com>
	<55369509.2080200@gmail.com>
	<CAGZ79kY0pbC6qH+Refm8Py0PyF2xNMLfSarhA+3-7eaU==RK7w@mail.gmail.com>
	<CAF72XQfVfjMLe2VqNWHkGXq75DLMPU6VVqLeGzgh9rZNC0qp3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Adam Steel <adamgsteel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:55:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymsry-00033G-HA
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 01:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbbD0XzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 19:55:14 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36889 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbbD0XzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 19:55:13 -0400
Received: by igblo3 with SMTP id lo3so7483089igb.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=28A14OYIUzE8aIJ9SK4MVqSpVC32V6uGXx+fmh+FAmo=;
        b=Un/P8CK86s96+mcnvRK6qBTqlSAoo+2RPnc7cHn2/c1/r1Tk8rPIJ7JqzeLoo96GLa
         EdqFBJ1eBcl7lsJqwL4o2JU/0VdJdvAXbxv9GtfelkZkgZfBP3ksdDuu8yXSxEE6kB7V
         Lrwkn67L5uUENzyTyEms1RhEXaOgm+p+JpXu1L5uUvB1z+DdXWMt3SCDhxiBFdSs3XEd
         9GEN0pbU25k/84HK0fYWvMRaUnzLfql5pAj6N7iqyKSdPWWIGsxR/QdcHUmwEX5HBaRD
         l+jynndv3tBwGEiPRVDduEDQDiG6k9Vg+BXTt/OX8y6EvSenyTk8IPw0f4n2JLTjB6Ua
         dQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=28A14OYIUzE8aIJ9SK4MVqSpVC32V6uGXx+fmh+FAmo=;
        b=UyHXaaZrNIOVUHr1i+1l3Mj33C7hI5iAZmZrJ8M4jddz13bmdEj1B6ZbNHdgjhKyc0
         pUuEOkjDGG33wXEfTB6mCLxJIRx7hg9Fscw55Bb9bdBat5P23hS+UuejQPgK/wqgLSFY
         Tb6nw/NnLI5HHciXyeNMJyWGoJVBoipL9GP3T2w9YzZQrkCxt5VpG90mrhzlTpW3eIlI
         7B9d6eHHWM+yQbjhMk2k7fZr/xz29Nwm8wQOkJSfcKERd7+zOlwuv9jSjQOfSyAtXr2w
         kdxxM1CYazE9AkTV5stMYdy4Vf1flc6oQwdPnltBoJ6GpZ46KM2xe3JO5nZDSOKp0Ljt
         gLVg==
X-Gm-Message-State: ALoCoQmxhLMHvlepL7DNIopg1f2Fc4Ru57Mv+zhwToSDQa1BweAplg5Y2Igf9qvHgDoQHbKtGTXO
X-Received: by 10.42.213.136 with SMTP id gw8mr15067194icb.95.1430178912219;
 Mon, 27 Apr 2015 16:55:12 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 27 Apr 2015 16:55:12 -0700 (PDT)
In-Reply-To: <CAF72XQfVfjMLe2VqNWHkGXq75DLMPU6VVqLeGzgh9rZNC0qp3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267887>

[+mailing list, so others can also chime in and have an answer/opinion]

On Mon, Apr 27, 2015 at 10:07 AM, Adam Steel <adamgsteel@gmail.com> wrote:
> Stefan,
>
> So I switched git versions.
>
> $ git --version
> git version 2.3.1
>
> I'm still getting the same regular rebase failures.
>
> ---
>
> fatal: Unable to create
> '/Users/asteel/Repositories/rails-teespring/.git/index.lock': File
> exists.
>
>
> If no other git process is currently running, this probably means a
>
> git process crashed in this repository earlier. Make sure no other git
>
> process is running and remove the file manually to continue.
>
> ---
>
> Any ideas?
>
> Adam
>
> On Tue, Apr 21, 2015 at 12:34 PM, Stefan Beller <sbeller@google.com> wrote:
>> [+mailing list]
>>
>> On Tue, Apr 21, 2015 at 11:20 AM, Adam <adamgsteel@gmail.com> wrote:
>>> I'm using git version 2.3.2 (Apple Git-55).
>>
>> We should loop in the maintainers of the Apple Git version, they'd know
>> what changed in git about two weeks ago.
>> I have no idea who that is though.
>>
>>>
>>> That explains why I can't find the index.lock file, since the error that was
>>> thrown deleted it. I'm still not sure what to do about this, though.
>>
>> Complain at the right people so it gets fixed. ;)
>>
>>>
>>> Thanks for responding.
>>>
>>> Adam
>>>
