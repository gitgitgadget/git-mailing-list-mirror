From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v6 p2 3/9] transport-helper: trivial code shuffle
Date: Wed, 28 Nov 2012 03:15:16 +0100
Message-ID: <CAMP44s2MtEie+tF4MDyzNV3A27zu+UhinS+EkaLE8DMZ71UNOQ@mail.gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
	<1353727520-26039-4-git-send-email-felipe.contreras@gmail.com>
	<7vk3t7nfql.fsf@alter.siamese.dyndns.org>
	<CAMP44s0fmt+bHN-ycza8b+y8Ep-Cyqmg1U1PVas267fTY5iPPQ@mail.gmail.com>
	<7vwqx6jxv2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXBW-0000vS-ED
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135Ab2K1CPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:15:18 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57404 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab2K1CPR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:15:17 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11598106obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 18:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yPYhswUR7uZ125nOhLUbNYyL9N7S1F4PuvNVzRdo9GQ=;
        b=PdBf0tXR2GZPj2OgiaKTLFZhI8ho2RR5Dav2x1y3ZBmMfwMPB7QaxgkqCNqvBeCfdP
         np4iJggXOGutcMUNtIoC+sQhHH+c28YB1VlhV+3BAYFA4Ho1MLu1lVvyLGdcy9QhRcRc
         gNENOBotrmyGzQ3K/dXcJxt/zhzr8/yaWxf1N+B8DlrEDC1qBQCas6WgcuxktUoUnO+m
         EFs2d9HA0eOnqRAeuusHO9b9Qo0qYnf4MUddh/Gd2R3A4lX9dJdirCh3Svzp9pNWMsM/
         Uh4idOIUHr3E2UV1Km4a4BKtV3FgwRjkbJOecY1LOiYFb9R0jhfMPMqh9kQjtH0E1R85
         ostg==
Received: by 10.60.4.227 with SMTP id n3mr14318639oen.136.1354068916966; Tue,
 27 Nov 2012 18:15:16 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 18:15:16 -0800 (PST)
In-Reply-To: <7vwqx6jxv2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210670>

On Wed, Nov 28, 2012 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> This is not just "just shuffle the die to make it explicit" but it
>>> does change the semantics; earlier ref->deletion was perfectly fine
>>> as long as data->refspecs is not given, but the new code always
>>> dies.
>>>
>>> If this semantic change is a good thing, please explain why it is so
>>> in the log message.  If the change is "it does not matter because
>>> when data->refspecs is not given and ref->deletion is set, we die
>>> later elsewhere in the code anyway", then it needs to be described.
>>
>> refspecs are optional, but when they are not present the code doesn't
>> work at all. This patch changes the behavior that was totally broken
>> anyway.
>
> In case it was not clear, I did not request/expect responses in the
> discussion thread, but a rerolled series with updated description.

An updated description that is irrelevant; the stuff is totally
broken, that's my point. But I'm tired of explaining it, and showing
it with test cases, and patches that fix those test cases, it's not my
itch, and "the other camp" doesn't even bother to acknowledge that
indeed remote helpers without marks just don't work, or even utter a
single word replying to one of these patches, nothing.

Not blaming you, just saying that I don't think anybody cares, clearly
nobody is exercising this code.

Cheers.

-- 
Felipe Contreras
