From: Slawomir Testowy <slawomir.testowy@gmail.com>
Subject: Re: What's the best way to push/fetch replace refs?
Date: Mon, 2 Jan 2012 07:16:16 +0100
Message-ID: <CAA61mJjCKJYAifD3DihAg+pH4Q0Z9y26n3P5KBBy09n-wK9LXg@mail.gmail.com>
References: <CAA61mJgCjt0O5LE5OQ=aNbtUHCZeZdZ=3dXYTNv_AhFi7JXwkA@mail.gmail.com>
	<CAP8UFD3KSjdZz1q+QYsH4JpRkiavtTbT1WqQSdxqCaxc24j=Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 02 07:16:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhbCJ-0007mt-2w
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 07:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005Ab2ABGQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 01:16:18 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53002 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960Ab2ABGQR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 01:16:17 -0500
Received: by pbdu13 with SMTP id u13so8145221pbd.19
        for <git@vger.kernel.org>; Sun, 01 Jan 2012 22:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DCGN5ijeKVteGVHLzGjOfNmt96B9YJLffUv9QuCUJMc=;
        b=hvNTtgCFHT0Yt1+Bf4yWMz62L9Kawj6KYPIkJvKpwfYdNx6E1RyR0pwRLOwjDlXISD
         C4uOMUHf2klIMR1pn0Lw9e+71esUVNdZ3f4DWDcIy7whRDBdZTNF/O5HgGMxOBP2q4Q9
         WEpXOkQRPiqq5HQNe5hr4TZ/e8wxTvwEqV7xQ=
Received: by 10.68.75.199 with SMTP id e7mr119939605pbw.128.1325484976594;
 Sun, 01 Jan 2012 22:16:16 -0800 (PST)
Received: by 10.143.142.9 with HTTP; Sun, 1 Jan 2012 22:16:16 -0800 (PST)
In-Reply-To: <CAP8UFD3KSjdZz1q+QYsH4JpRkiavtTbT1WqQSdxqCaxc24j=Rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187835>

2011/12/30 Christian Couder <christian.couder@gmail.com>:
> On Fri, Dec 30, 2011 at 12:59 PM, Slawomir Testowy
> <slawomir.testowy@gmail.com> wrote:
>>
>> # I also added "fetch = +refs/replace/*:refs/replace/*" to [remote
>> "origin"] in "b" and this also seems to work.
>
> Yeah, the simplest is probably to just add "fetch =
> +refs/replace/*:refs/replace/*" to the remote(s) you want to get the
> replace refs from, and "push = +refs/replace/*:refs/replace/*" to the
> remote(s) you want to push the replace refs to.
>
> Regards,
> Christian.

Thanks Christian, I thought maybe there is some magic "git clone
--get-also-replace-refs" or something. I'm asking because I'm about to
tell people how to clone my repository and some of them don't know Git
at all so I wanted to find out the simplest/best way to fetch replace refs.

Thanks.
