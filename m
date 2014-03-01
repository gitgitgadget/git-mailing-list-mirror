From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] Replace memcpy with hashcpy when dealing hash copy globally
Date: Sat, 1 Mar 2014 22:55:05 +0800
Message-ID: <CAJr59C3Lc_NrXNVT8aB9CThQRZvakBJWVVghf0M7S0z0qSN=DA@mail.gmail.com>
References: <1393636024-17576-1-git-send-email-sunheehnus@gmail.com>
	<CACsJy8Apoz43HPAgdrTHSNgSOcUhv9j258+r0xDJeioY3iogig@mail.gmail.com>
	<CALUzUxo=5aUCjL0GDz=3JjuQqN4+9pTPbmNWO3Rda+UuLDOYhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Tay Ray Chuan <rctay89@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 15:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJlJq-0002Q6-LZ
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 15:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbaCAOzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 09:55:08 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:35921 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbaCAOzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 09:55:07 -0500
Received: by mail-we0-f173.google.com with SMTP id w61so1527280wes.18
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=nfTlYSfPsoydx9X4Jc28YIlAXsZpKuAzdikLSUj5wEE=;
        b=yjkiIgZR7T8Us/n2THk4i3ei6JGzpe7FsyEyQTyloM57DpunaClJTGG0hnOe1PcU6n
         ayvUYDnYNj06sDUseDNd08TGaH6t7XdowgQmCxn3wcxJi9wVbdqoG5h377Ze7BlGF5n3
         qkfiWjI77B3yVivaWRNj9IwbhsENak/vOiwjWyi8POlAy/DFxoraF/fdJcWBXofNQjAF
         TzuAhqittIaCFtEhH12M6RpD31omvfT1CgicW5CdRitxP2uYLeLh1c9Lzg+qCkgt5MVy
         JRWsLDRre52nU2EVyTKRu9KQidVN8qULU/6HjEl+gAiYs+JyUAlxvhcGxQxND8MOMYXx
         VzGQ==
X-Received: by 10.180.205.130 with SMTP id lg2mr7799673wic.59.1393685705543;
 Sat, 01 Mar 2014 06:55:05 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Sat, 1 Mar 2014 06:55:05 -0800 (PST)
In-Reply-To: <CALUzUxo=5aUCjL0GDz=3JjuQqN4+9pTPbmNWO3Rda+UuLDOYhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243100>

Got it.
Thanks.

2014-03-01 17:13 GMT+08:00 Tay Ray Chuan <rctay89@gmail.com>:
> On Sat, Mar 1, 2014 at 10:58 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Mar 1, 2014 at 8:07 AM, Sun He <sunheehnus@gmail.com> wrote:
>>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>>> ---
>>>  Find the potential places with memcpy by the bash command:
>>>    $ find . | xargs grep "memcpy.*\(.*20.*\)"
>>>
>>>  Helped-by: Michael Haggerty<mhagger@alum.mit.edu>
>>
>> You may want to put this Helped-by before "---" because it's supposed
>> to end up in the final commit.
>
> To elaborate further: anything below the three-dash is ignored when
> the patch is applied. So it doesn't show up in the commit at all. I
> don't really know the reason for this - probably a patch (1) thing.
>
> You could put the patch the Helped-by before your Signed-off-by
> (sometimes referred to as S-o-b).
>
> --
> Cheers,
> Ray Chuan
