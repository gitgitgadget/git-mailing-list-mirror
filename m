From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 20:18:47 +0600
Message-ID: <CAErtv26WEYXPpi2D=54NfxfYKBFMKhExHKkWL0EWP_ZCUPEiXA@mail.gmail.com>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:19:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYFn-00018S-G6
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab3L0OSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:18:49 -0500
Received: from mail-vc0-f172.google.com ([209.85.220.172]:34984 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab3L0OSs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:18:48 -0500
Received: by mail-vc0-f172.google.com with SMTP id ij19so4817877vcb.31
        for <git@vger.kernel.org>; Fri, 27 Dec 2013 06:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EJbS8jYmnh2afGrGWIQ5ltotaTR3LJQQZLvwrZuSGKI=;
        b=Nvvj4RY8o8LIqm2PRsEn/5m+tjf6XuskTZHxtkcTRgZZaJTfwkQR0A7kT/gYqFMp2m
         c9B88yKApw7RfZrXV1/x4oAUrNUTNiMTrrLGKqBpCWaQrkghDEkGPNdLQDuCJDdKzlK/
         yEOaFgpu58sI+ex6cYfAWw9b/SKITery9jd7WX53DUTIc/S0ixiX8NhA7gjXS6LTnMVN
         Kn2mPQQMan/Dx7i2ttRAgkd4WTVmMbRyJnpmmwFLHs4ALOP9MXVoksy/ge6U0XpLop2z
         az55r75x+0q4TWChzSYsZQkRVBx9AJzwTYY78N+4YaKtfJeBxUstR/vygI9pWt9fRuMy
         pdHA==
X-Received: by 10.52.244.15 with SMTP id xc15mr4575519vdc.52.1388153927294;
 Fri, 27 Dec 2013 06:18:47 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Fri, 27 Dec 2013 06:18:47 -0800 (PST)
In-Reply-To: <87mwjm4c3s.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239734>

Our sysadmns are mainly worried about possible MITM which might give
users completely wrong repo.

For sure users might simply compare hash of HEAD from https'ed site
with repo browser with what they've got in the checkout. But that's an
extra step which we'd like to avoid without security harm :)

On Fri, Dec 27, 2013 at 8:12 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Sergey Sharybin <sergey.vfx@gmail.com> writes:
>
>> So guess we just need to recommend using https:// protocol instead of
>> git:// for our users?
>
> Given how easy it is to verify the integrity of a git repository out of
> band there isn't really much of added security by using TLS for
> transport.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."



-- 
With best regards, Sergey Sharybin
