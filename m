From: Britton Kerin <britton.kerin@gmail.com>
Subject: Re: no luck with colors for branch names in gitk yet
Date: Fri, 5 Feb 2016 13:29:26 -0900
Message-ID: <CAC4O8c81h-JEGN2mS=SgUnBQM+A-RojDBOY65f=Jmubo6CZCwA@mail.gmail.com>
References: <CAC4O8c-MPwrJ2H+iHjQxk+XoX4_vPm80Lz1=wbuHHd2gsB8R0Q@mail.gmail.com>
	<B88DD991725D43E19185D46EED20FDDF@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:29:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRosd-0001fr-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648AbcBEW32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:29:28 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35559 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbcBEW31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:29:27 -0500
Received: by mail-wm0-f42.google.com with SMTP id r129so45595791wmr.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 14:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YzatfSeaAQs2khecD9OKK56QKhDx/5zS2UeSX7uRuPU=;
        b=lgZO45ID3geDlsUldwy/RKlHYdTj5eIL2CYHjCrtCYWcccjMYlC1efNjHE8bJHg8Qj
         zca7T6fHlSzdDXAbo2SfFdsmtp2MjWPb6tk8ed70rH1aJETb2i4bVda2BYj1DDGCiNh7
         xjrV0VWvdnFNz8NvTMMhXqDAmliPa6nCFiZk/BsLrkuhRul7Yo+1xXpP785welp4KqGp
         uW2sDqzR2VvXSTtqzALuabhmcmkrjiEi2DbWIFGXOUrlbMtW2p07bE1eO1mQSema4mAq
         7maAg9ClZyOsFhv5k5e0QDBPOCEJqzcuGxsTkWWocCZPGzM6R5qsbv+caY3D+u0ZngIc
         5ylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YzatfSeaAQs2khecD9OKK56QKhDx/5zS2UeSX7uRuPU=;
        b=kPdOLpmT+00yWwVW1S9ztWkzFZo98fzTjnQsqsMm5tCX3zoDubv1z8Ftob+NNdDo2k
         EXub7qg7E2aL2DjeWAwM+s6SagVjh4hIJW+LMKTPK/i48y9MIwZslCn/Xci4lhDUBkUz
         hyPgfIANpx78rMt3qeXd+xTeg0gGUewjsOR9kd79qsc3lM0EEnABBJfE7fCdrf7ytIAQ
         Tv5Ad+zYYE5D1499d+fWKuqvKzXt4kb82XyW17nwvJUza3EMMtNc0dXBr2FCzThd6K36
         kqX0y8bpH8kYBxBSGc8qZrwWddDCmNDuhqA/8ZDNsNzNvHHbOl5s1W3tqlitSHo6czsU
         E9xA==
X-Gm-Message-State: AG10YOS2LVNLgvWBJc9gxz9s91xFzFAbu4HNlueY1zgILGtg24zAGFcHPeZWxtTZAsmRWlwVwNYzPizfBNsZ7g==
X-Received: by 10.28.90.133 with SMTP id o127mr19895405wmb.101.1454711366248;
 Fri, 05 Feb 2016 14:29:26 -0800 (PST)
Received: by 10.194.178.161 with HTTP; Fri, 5 Feb 2016 14:29:26 -0800 (PST)
In-Reply-To: <B88DD991725D43E19185D46EED20FDDF@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285648>

On Fri, Feb 5, 2016 at 12:25 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Britton Kerin" <britton.kerin@gmail.com>
>>
>> Someone suggested using color.branch.upstream, I tried like this and
>> variants
>>
>> [color "branch"]
>>  local = red bold
>>  upstream = red bold
>>
>> Doesn't seem to matter what I put in for upstream, including invalid
>> colors, gitk just ignores it and does the dark green for local
>> branches
>> --
>
> Alternate, try
> https://github.com/oumu/mintty-color-schemes/blob/master/base16-mintty/base16-default.minttyrc
> (or any of the other colour schemes) and copy them into your .minttyrc file
> (works for me on g4w : git version 2.7.0.windows.1 )

I'm on linux so I think mintty is not an option.  Also, I'm a little
surprised in affects the rendering of branch tags in gitk, I would
have thought that would be an X or window system thing.

Britton
