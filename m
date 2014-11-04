From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git reflog --date
Date: Tue, 4 Nov 2014 12:06:23 -0500
Message-ID: <CABURp0oHYtnv1hB12XVssjppCkZOpSR2xsZmYR=Etu=sTT0nXg@mail.gmail.com>
References: <CAHQ6N+oQV8Uesv_eCBZc+hpwR5rDWA22OXR05AJ_zXcf7bfQ7g@mail.gmail.com>
 <xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 18:07:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlhZO-00020x-0e
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 18:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbaKDRG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 12:06:57 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:56656 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbaKDRGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 12:06:43 -0500
Received: by mail-ig0-f180.google.com with SMTP id h3so6986052igd.7
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 09:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nRX6kuUB2PVSxcnb1+YutWtORy3r0O/UUJ3R0JX2hN0=;
        b=yi58c2TFMX488RqeL7uE/WI63QP7D0gzg9mE+KuKXCd9r5hkBmS1Mqv26cGkKU0fOi
         a5rftYyD9s3HUSftVkQTpaAa6EeJkpmylE45uNv+9MSp6lrupdlPJ9yDcDktlfzGpO4I
         fA84DtsRxcJFcWQYTn9dxiEFKXl0ajP9wZ1MitBzr/2yWgJrq+KJDSKSnQ22aaNgg4Xn
         tS+MV/cW/XuALbclt4G3EmoNNoCtcsvwIjFHzUA8hn4+aiI4x0I01bNaY23sJZkTPrsP
         67atUgQJlux5cHUevTfTbbWiOZFC1vEAwttwI8GTuA6goN9h/T3TnFaU8QwQwHyGBFEm
         OqOQ==
X-Received: by 10.50.28.14 with SMTP id x14mr25489647igg.39.1415120803345;
 Tue, 04 Nov 2014 09:06:43 -0800 (PST)
Received: by 10.107.137.11 with HTTP; Tue, 4 Nov 2014 09:06:23 -0800 (PST)
In-Reply-To: <xmqqh9yx1gkt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 21, 2014 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Tapsell <johnflux@gmail.com> writes:
>
>> Hi all,
>>
>>   Could we add a default to "--date" so that:
>>
>> git reflog --date
>>
>> just works?  (Currently you need to do:   git reflog --date=iso)  It
>> should probably obey the default in log.date?
>
> Hmph.  "--date=<style>" is not the way to choose between timed and
> counted output in the first place, though.

Of course not.  I always use --relative-date for this.
