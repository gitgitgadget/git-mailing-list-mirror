From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 00/15] Mark "init", "clone", and "add" output for translation
Date: Tue, 22 Feb 2011 12:22:08 +0100
Message-ID: <AANLkTimvwKHvPfbUiAmfdAC2KgaRfRBMY7fO+ESywoPD@mail.gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
	<20110221040012.GB26968@elie>
	<20110221101229.GA32137@elie>
	<AANLkTikDnfUb6oCP8q7XrAqKan5GcPhyRnag2vW2ZDXW@mail.gmail.com>
	<7v1v30frll.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 12:23:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrqKc-0003Qh-V1
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 12:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab1BVLW5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 06:22:57 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53285 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab1BVLW4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 06:22:56 -0500
Received: by fxm17 with SMTP id 17so2626751fxm.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 03:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IZ0m+8T1hjxqsO5r5h2NJHnjYZwB3ptcxffPY0oBvvw=;
        b=UuvmxTZ/0Yg6P6jPRWqHzkB05//SJ+IdWc+TH7WPEyglYbHSvAnfQ6oVOnDccbgRbp
         vylTRvfpUaVtVGUHpXUiWMKmotMmf35LqPa4+s9DE8gg1z9vE3pLVBBygynQ52gnqMi4
         3bmT8oo75Te6BUR0Bx3OEMMt8dQ9zFFJ32f7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dJOkaDTCHi8cCvyH0euwx/d2+UR4D1+rzxZoXTCF+w+YO1Or8paR2Noc30w+qTU2xa
         WxOhlgKgItrT4OA2+VUOQ+htHpUgFHf9Gn0hOTek/Pv50n2z/2xphpJyBJK3/plLXeHw
         9pNcB94eICWdgnWFjSkTRbgWP/Lf5Y9m3qUBs=
Received: by 10.223.96.12 with SMTP id f12mr3311109fan.79.1298373728742; Tue,
 22 Feb 2011 03:22:08 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Tue, 22 Feb 2011 03:22:08 -0800 (PST)
In-Reply-To: <7v1v30frll.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167540>

On Tue, Feb 22, 2011 at 08:36, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Feb 21, 2011 at 11:12, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>>> Please feel free to try it out, complain, ack, send patches, and so
>>> on.
>>
>> Thanks a lot for taking this on.
>
> I compared this miniseries with the early part of your original. =C2=A0=
It seems
> to contain only sane refinements, adding missed markings etc.

Yeah it's looking much better.

I've been coordinating with Jonathan on #git-devel. Some more changes
were made yesterday. I'm going to pack them up and re-submit again
(just minor nits etc). That series should be in a form that's
acceptable for being applied as-is.
