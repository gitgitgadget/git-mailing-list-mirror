From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 1/3] compat/regex: use the regex engine from gawk for compat
Date: Tue, 17 Aug 2010 03:50:58 +0000
Message-ID: <AANLkTikKB6dLF9RVPt7s9KyVdafvOY-i3z+VCMbEwF=m@mail.gmail.com>
References: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
	<1282015548-19074-2-git-send-email-avarab@gmail.com>
	<20100817033701.GB17840@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 05:51:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlDCq-0007Lw-Cg
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 05:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab0HQDvA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 23:51:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56560 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab0HQDu7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 23:50:59 -0400
Received: by gyg10 with SMTP id 10so2182764gyg.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 20:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0+nm0+6k3AIyiXwXl7Ad3PAqBvaGyLrhvszWyDRpeZI=;
        b=OIcXWTRDlRzNJSjBpho0bnNd0VP663VKf50JRJKRrgJoYPjcEAlIsFvn7F6pcMVRqf
         K6ZnPfbsbkHfjLIMuialNgMsmags1BERSrarimTc9ZhbqVLJTUkVIj7uMe6hxPg0HOUQ
         F8CeHNnjdlN8KQ15cAw0yThs5utzk7OuqriCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OVkNAucKc/A4wK0p+KS3ozF8J0IPKDymPoLUgrZHulYmubfoxDKbIbGhuAtRVWAEqx
         SphbEQ2/5x5xG4QPA7OMa9zY6IGXq3P5/uH5N96uhEmy3k+UHIfPeIQbGJBoRnvL5+bD
         dvUTB57MIZsLvwU9n927mtTpvTWhTc1RwoRdU=
Received: by 10.231.31.135 with SMTP id y7mr7128234ibc.139.1282017058852; Mon,
 16 Aug 2010 20:50:58 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 16 Aug 2010 20:50:58 -0700 (PDT)
In-Reply-To: <20100817033701.GB17840@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153693>

On Tue, Aug 17, 2010 at 03:37, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> +++ b/compat/regex/mbsupport.h
>> @@ -0,0 +1,59 @@
>> +/*
>> + * mbsupport.h --- Localize determination of whether we have multib=
yte stuff.
>> + */
>> +
>> +/*
>> + * Copyright (C) 2004, 2005 the Free Software Foundation, Inc.
>> + *
>> + * This file is part of GAWK, the GNU implementation of the
>> + * AWK Programming Language.
>> + *
>> + * GAWK is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 3 of the License, o=
r
>> + * (at your option) any later version.
>
> Worrisome. =C2=A0(Most of git is still GPL-2 only, which would not be
> compatible.)

Actually it's LGPL-2.1 (all the copyright headers in the *.[ch] files
agree), I just copied the wrong license.
