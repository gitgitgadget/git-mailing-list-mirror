From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC/PATCH] Update compat/regex
Date: Mon, 16 Aug 2010 14:26:55 +0200
Message-ID: <4C692E8F.7090904@gnu.org>
References: <1278549735-19278-1-git-send-email-avarab@gmail.com>	<7viq4ppxt9.fsf@alter.siamese.dyndns.org>	<AANLkTikuGY4LVrCB6UoGFhxthoI8MgvAXCwCbiXhwq_d@mail.gmail.com>	<7vtyo0vdpz.fsf@alter.siamese.dyndns.org>	<AANLkTim-4I5Sdu653yJOmnVYDqI8bb71839Vqfd3FKCi@mail.gmail.com>	<20100715220059.GA3312@burratino>	<AANLkTimQZDT3PuiLDdjPXzWlLiEI5Iv1zy5iFPlRswyC@mail.gmail.com>	<m2630fqzn1.fsf@igel.home> <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 14:27:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okyma-0005NI-FQ
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 14:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850Ab0HPM1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 08:27:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35246 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab0HPM1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 08:27:05 -0400
Received: by vws3 with SMTP id 3so3286123vws.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 05:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=oHjxIUnruIr2bZcofhxsBK3BS8/COoTmLjHr941xbC8=;
        b=wVVl7a0Ut7w8pnR9ed743KmTlN9QiFkU/e30sh2z8gFDKj5AuuABDXfwIAQObPUDax
         eCz8YAflewGdToNSSJOBU3Idpq66TAA7wzG322BbVa7QVGb/lQtm0S9fEYrMnyIHCnb0
         muwKviSEHEpL8ziUoV9t2FFjsE49ovQXTsDxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=VB67Pb1wCq+j7UM86rNN6J9uq0GS83ITNYdcZBecMnr1Y4tkp3/sV4PZpZnhEojUub
         K5i9N7zDqX2Ynm0YLbkjdOqI5/uVjfAeOV8I3MyG/wVYo2afldqKZacJlnZjsVjtrXRm
         O9+pFnjF8+okmqlgOe1MLc4PH/D90T5UacDZs=
Received: by 10.220.98.140 with SMTP id q12mr3052767vcn.268.1281961624030;
        Mon, 16 Aug 2010 05:27:04 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id b8sm1666476vci.45.2010.08.16.05.27.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 05:27:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100621 Fedora/3.0.5-1.fc13 Lightning/1.0b2pre Mnenhy/0.8.3 Thunderbird/3.0.5
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <AANLkTik4FL56EM4HdpfZ7ha8GNkbLsJeb415WFWUh+O_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153658>

On 08/15/2010 01:08 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, Jul 16, 2010 at 14:17, Andreas Schwab<schwab@linux-m68k.org> =
 wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason<avarab@gmail.com>  writes:
>>
>>> This patch has all the glibc-specific stuff that makes it break har=
d
>>> if you don't have the GNU C library. Writing macros/definitions to =
fix all that
>>> stuff up was the "easier said than done" part I was referring to.
>>
>> You might want to try out the gnulib version instead.
>
> I fiddled a bit with gnulib for both the regex engine and libintl, bu=
t
> I can't get it to do what I want.
>
> The assumption with gnulib seems to be that you're including the
> libraries in a GNU program that only uses the autotools, it seems to
> be about as easy to just copy/paste things from glibc if you're addin=
g
> libraries to a program like Git that uses its own build system.

Andreas is right, the glibc code is not meant to be portable.

It is really simpler if you start from the version in gnulib, which is=20
the one that is included in most GNU packages nowadays.  You should=20
download GNU grep 2.6.x and (starting from lib/reg*) add headers from=20
its lib/ directory until it compiles.

Alternatively try out gawk, as it does not use gnulib but has the same=20
set of sanitizations.

Paolo
