From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Mon, 25 Apr 2016 11:15:38 +0200
Message-ID: <CAP8UFD2PwqcFPnBGexehKKSog=kkGa_C749QokQE-R3wt0yLqQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<571CE4D5.8010403@ramsayjones.plus.com>
	<CAP8UFD0dEYPSku8w=7ehJFFgtNFO8EbUc4RDn+KRdrYG3-=Rxg@mail.gmail.com>
	<CAP8UFD0rKNAoZgCPQkfo_qd7b_V4rOtLqBvQ-XQoeT6OnZidGw@mail.gmail.com>
	<571D059B.2010908@ramsayjones.plus.com>
	<CACsJy8Bu+fsWP-dmckbSCRvonpqtCyvwGZWHCvjtfSWKY3A6QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 11:15:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auccK-0004S1-BU
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 11:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbcDYJPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 05:15:40 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37332 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbcDYJPj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 05:15:39 -0400
Received: by mail-wm0-f42.google.com with SMTP id n3so116872645wmn.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=73Ysv5QJOFKIA4UooJemZovWfINf0hOcW1j2P59NK0k=;
        b=JSc95MsjhEkzGcsy4+U0RAl8pgWfw6Na/wtLflL925foZq8iVESKPb6iY13t1KoXXh
         KCrHOOkxN3W/wJGIHmQ1zQUfUVgAtxHgkiSt1XKK9LqJnc59VJMsTBEhobzphEKypyjc
         yyPatRjeYmFtyOqx+wUsZxqpciWiGBzOWjShl+SZ5qbbgBamVellyCg8+rIwBHNT+bnP
         WBXiCQw79xcJXcSuwoysCgvKDi8WCcEV++4c2q1aB1oQrd6ODK5FQt6DiNLH9V848XV9
         bVcAhQ9B/qfR4734GopPRZhmFULwRc3WVf36fRGzhPmsFG+WZWUNJxmnHy/BYQftu4YF
         OUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=73Ysv5QJOFKIA4UooJemZovWfINf0hOcW1j2P59NK0k=;
        b=e421gJNJFPSNn/TvEXoyzY7CK8Um+HbKkLb82+sy3q5FjAZbBQ0N7y+nJtDz+7yLrm
         mTYTBh5G/oLq72QF5TfzV7VgcLlqR/acs2xPlYRaSJSsOgk08L0MVBx8VoWTUIqEUfTg
         z8vX7RRCd4fEhRoFiMuliAiw4dW+UxeNcG3hAJ1Ve4s0vOXJ1y2bg7tuaOD7gC+lHhR9
         Nw+h24t1KpldwiM7kvHAuTq8P25b8vnK4P6sasFWjBb777jQuYi+6v6/GjN1rw9+Yfx/
         AngaSOs+mKbH4A0iWqumPlVtxkYLHr2nYdpamUh/gh7UNOxvQRhXgZpH6tmwJE3IfkGb
         yfbw==
X-Gm-Message-State: AOPr4FVDd1JhnP8e5o6nZooUX5AENn7MqiEWojKF8d+F6/ItAd43Lr4x7GfK/5bVezav803ZiDVhw5I/O+ctRA==
X-Received: by 10.28.151.133 with SMTP id z127mr10602346wmd.79.1461575738085;
 Mon, 25 Apr 2016 02:15:38 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Mon, 25 Apr 2016 02:15:38 -0700 (PDT)
In-Reply-To: <CACsJy8Bu+fsWP-dmckbSCRvonpqtCyvwGZWHCvjtfSWKY3A6QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292461>

On Mon, Apr 25, 2016 at 2:14 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 25, 2016 at 12:42 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 24/04/16 17:56, Christian Couder wrote:
>>> On Sun, Apr 24, 2016 at 6:27 PM, Christian Couder
>>> <christian.couder@gmail.com> wrote:
>>>> On Sun, Apr 24, 2016 at 5:23 PM, Ramsay Jones
>>>> <ramsay@ramsayjones.plus.com> wrote:
>>>>>
>>>>> I just tried to git-am these patches, but patch #78 did not make it
>>>>> to the list.
>>>>
>>>> That's strange because gmail tells me it has been sent, and it made it
>>>> to chriscool@tuxfamily.org.
>
> #78 moves 4000k lines around and ends up ~260k in size, I think it may
> have hit vger limit.

Yeah probably. Thanks for looking at this.

I think I will have to split it into smaller patches in a v2.

>>> Instead of waiting for the patch to appear on the list, you might want
>>> to use branch libify-apply-use-in-am25 in my GitHub repo:
>>>
>>> https://github.com/chriscool/git/commits/libify-apply-use-in-am25
>>
>> Hmm, that branch doesn't correspond directly to the patches you sent
>> out (there are 86 commits, some marked with draft. I think commit d13d2ac
>> corresponds kinda to patch #83, but .... ).
>>
>> I think I'll wait to see the patches as you intend them to be seen. ;-)
>
> I git-am'd the series then compared with the rebased version of
> libify-apply-use-in-am25 on master. 33198a1 (i.e.
> libify-apply-use-in-am25^) matches what was sent in content (didn't
> compare commit messages).

Thanks for checking.
