Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66E01F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757133AbcIURSK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:18:10 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36397 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbcIURSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:18:09 -0400
Received: by mail-qk0-f182.google.com with SMTP id z190so52212538qkc.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gHheSIKZs00LppDpK3jK5At6awGZEz0MfQolfrnDi9M=;
        b=sT/Wfx8Cg8QhHIs5tjD8BZvZZ6TOB8TaRp+esQxsnHsFk64K7XG+2ecujbEjU1/ymh
         gz1wuI06+4bTQB/RU5D84D+W0FWoWdlOUla/51b5Zuu4M8iaf6x7Zk/R/vy+9OmxOXmD
         j4MdPuK3gJg+QqMtFqTbTN53GQJdO/p0C+YtKIEUrei4OvGfN720opYcCBJE/5Ngek3l
         UXW3uolAo7P7TVwfHAhtUEV/dLxZ3vddG40YLHQhuiFGkFW6P0+e973idRTim0rlDAFz
         EMxDu5aWkr8BfvfjqKl+f5ZEr/7Edr+i91ubDbgnJ8o4cmsFL0qkBi/5XG9iJXBdeJ/B
         ijSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gHheSIKZs00LppDpK3jK5At6awGZEz0MfQolfrnDi9M=;
        b=U78AEHLkulTanX9iqiN3fCtJ7qQ8TIRrSTvXb2Tuuya5IMF0cCI79Vz8egXvBKv92n
         ydRjxr+zRpyp1spZeHE9vXS89GsmZQrDhKTLSMf6yNgxaZjS1qVKv26JJTgfGIFqkDZz
         mLpBOTokI1/oae3Dh5jRcF8hBfo7qEl7/CzcoIN3XytAhk9HF80xoVTUV+Tq5lBEilW+
         N3rU7wDhlj0VerQfhlttQM6673SlKjxWcZ0iFKWCl/XDI/0npMrm0t1MHr0GmcLjC3qz
         n3vfbEgq7oBAipZAlbMg3cSWAojq92FUP5AUpg8UHWki3QNWutx/h481KY7Nwill6hLQ
         uJgw==
X-Gm-Message-State: AE9vXwMuoSlRqe/9jmgY+5vFbK6q4WlD8aIQSrJsULWw2mRgFNpS/1uTStwEwGG/kk/Rwb2QTge+rIyY5uGGug==
X-Received: by 10.55.8.138 with SMTP id 132mr44742676qki.198.1474478288982;
 Wed, 21 Sep 2016 10:18:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.87.133 with HTTP; Wed, 21 Sep 2016 10:17:48 -0700 (PDT)
In-Reply-To: <8b43ba22-9634-e2b8-8de7-d70c258f4034@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com> <d047a76d-8f13-5c90-3946-6821957d9278@gmail.com>
 <CACBZZX4QDTNYDpOF+GsK3tMQamoXQhJoXuPTgB3O+iEW3jBxag@mail.gmail.com> <8b43ba22-9634-e2b8-8de7-d70c258f4034@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 21 Sep 2016 19:17:48 +0200
Message-ID: <CACBZZX73N4A0WBOG0G6DUg2fbn0mCmfuApcC6gG=6b-6-UrW7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] gitweb: Fix an ancient typo in v1.7.7-rc1-1-g0866786
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2016 at 7:14 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 21.09.2016 o 16:17, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason napisa=
=C5=82:
>> On Wed, Sep 21, 2016 at 3:33 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>>> W dniu 21.09.2016 o 13:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason napis=
a=C5=82:
> [...]
>
>>>> -# Sanitize for use in XHTML + application/xml+xhtm (valid XML 1.0)
>>>> +# Sanitize for use in XHTML + application/xml+xhtml (valid XML 1.0)
>>>
>>> Nb. I wonder how common is use of XHTML nowadays, with HTML5 as standar=
d...
>>
>> It's sent to modern browsers, I noticed it because when doing the rest
>> of the patches in the series the slightest mistake in the HTML syntax
>> would cause the page not to render in Chrome, because
>> application/xml+xhtml activates its anal parsing mode.
>
> What I wanted to say is if we should support XHTML mimetype at all;
> the future is HTML5 and perhaps gitweb should always use 'text/html'.

Regardless of what MIME type we'd normally use, as long as browsers
support application/xml+xhtml developing with it is very handy,
because you get the instant equivalent of compile errors for your
HTML, as opposed to the usual behavior of "oh this doesn't parse, but
let's try to make sense of it anyway", which often leads to fruitless
debugging sessions just because you forgot to close some tag or
quotation.
