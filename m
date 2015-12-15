From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 22:53:09 +0100
Message-ID: <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
 <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
 <xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com> <xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com> <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com> <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 22:53:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8xXL-0003Mr-0c
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 22:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933738AbbLOVxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2015 16:53:30 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35995 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932449AbbLOVx3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2015 16:53:29 -0500
Received: by mail-qg0-f48.google.com with SMTP id 103so19355406qgi.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 13:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ll9ZBL/8gGIc9xLZvNrT/R2U94PAd3rU26oQU3op50E=;
        b=JRebMYeQDNUep8kPElPWit8bWWsOXAobSBmxkQWwPxSEnECM1Li3qydYz1aZgpYh2P
         2UESvu4vRCQgNh7XOuZuBOq0B7KmVvh6ZnbbRxI184Os/jkAt4gfWuScI9/b3N5sSubq
         bDi41trh/A68BU6LEin3VY01iXm+Dt0cZ2DQCLAZJRIMj4dksnm7VCLqlpV7sxgymzaw
         di/bAZxZwp/1a4HEgVWa4KsM0zpZXICL7ZiVwU9B2e75JGoz/Z5P5R20nsI5lrHjpu9O
         J41RO6SFvX11wS7Gkuke8eTCQomymyBDidRV7nMUimy5qvXuy0vPZSIKkzQwRirh6RoF
         yzMA==
X-Received: by 10.140.253.3 with SMTP id y3mr22279583qhc.39.1450216408709;
 Tue, 15 Dec 2015 13:53:28 -0800 (PST)
Received: by 10.55.108.197 with HTTP; Tue, 15 Dec 2015 13:53:09 -0800 (PST)
In-Reply-To: <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282499>

On Tue, Dec 15, 2015 at 8:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> I still have a problem with the approach from "design cleanliness"
> point of view[...]
>
> In any case I think we already have agreed to disagree on this
> point, so there is no use discussing it any longer from my side.  I
> am not closing the door to this series, but I am not convinced,
> either.  At least not yet.

In general the fantastic thing about the git configuration facility is
that it provides both systems administrators and normal users with
what they want. It's possible to configure things system-wide and
override those on a user or repository basis.

Of course hindsight is 20/20, but I think that given what's been
covered in this thread it's been established that it's categorically
better that if we introduce features like these that they be
configured through the normal configuration facility rather than the
configuration being sticky to the index. It gives you everything that
the per-index configuration gives you and more.

So assuming that's the case, how do we migrate something that's
configured via the index towards being configured through git-config?

I think there's no general answer to that, but in this case the worst
case scenario with accepting this series as-is is that we downgrade
some users who've opted in to it to pre-v2.5.0 "git status"
performance.

Since the change in performance really isn't noticeable except on
really large repositories, which are more likely to have someone
involved watching the changelog on upgrades I think that's OK.
