From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCHv2] t5525: test the tagopt variable and that it can be overridden
Date: Fri, 13 Aug 2010 21:39:04 +0000
Message-ID: <AANLkTikP5xsvfBt7Rq9CoNnF=7SE4-V6LBML=tDMtT_Q@mail.gmail.com>
References: <AANLkTimYm+GmJ4BmZKOmcZkJf_wgeUiKhTs06qxex+0q@mail.gmail.com>
	<1281734852-21413-1-git-send-email-ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Daniel Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 23:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok1y1-0002Vy-EA
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab0HMVjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 17:39:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50502 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab0HMVjE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 17:39:04 -0400
Received: by iwn7 with SMTP id 7so208168iwn.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 14:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZT45SONlSkvL14/dZ3YIIHy2vHWyjK5K2qDiwZwpEq8=;
        b=Udy/xOu3g9fTRGHKCOIuiuGEgJ7dODBvL6GY9JLwzYWV05yaPrtFkPyPPmJ7Zymq5t
         e/uDvsgcdB8vs4TGcFAm+mpe01/EazfTKdg0Gbzkld1vYmi6z8P+m87vI/ZLI6ggz6qF
         o7KHCCI5ppHP5wPTBFT7lW3S0k4DnDoYXj1Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CewoxkEOe4XJbax6VPmARPLjWe/yK6vdF9cs0Zmv1v+D9VRrGqMJWogXHrLApd0olx
         S7XAErgmYN7SPKbP4lzL6z2U18eGQ0+BU7EluJmhpiJGg+8r0t/Qk+JpazYINP5ReAjb
         Tgfbfyk+n2uLLLGxPb4qLvxhcsLbhhtQAP6tU=
Received: by 10.231.147.131 with SMTP id l3mr2148492ibv.74.1281735544196; Fri,
 13 Aug 2010 14:39:04 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 14:39:04 -0700 (PDT)
In-Reply-To: <1281734852-21413-1-git-send-email-ComputerDruid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153514>

On Fri, Aug 13, 2010 at 21:27, Daniel Johnson <computerdruid@gmail.com>=
 wrote:
> ---
>>> @@ -0,0 +1,44 @@
>>> +
>>> +#!/bin/sh
>>
>> Is that an empty line before the test begins? The shebang should be =
on
>> the first line.
> Embarrassing. That's what I get for using yank/put and not paying clo=
ser
> attention. The rest is fixed too.

Nice, I haven't actually *run it* but it looks good, so provided that
it passes tests when our beloved maintainer applies it:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
