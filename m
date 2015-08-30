From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Sun, 30 Aug 2015 10:04:16 +0200
Message-ID: <CAHYJk3RXtS0d7mKNExbmX==O7PiTj=2m9ik3npO5_b5HV44_QA@mail.gmail.com>
References: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
	<20150825171238.GB9674@sigill.intra.peff.net>
	<xmqqh9nnz08i.fsf@gitster.dls.corp.google.com>
	<20150825185210.GA10032@sigill.intra.peff.net>
	<20150825185414.GA10895@sigill.intra.peff.net>
	<CAPig+cQ1COjZuBq2YWKNdQ7zrzfvrppX-84vc9i1mJ6-yp_ZiQ@mail.gmail.com>
	<20150826021517.GA20292@sigill.intra.peff.net>
	<CANy2qHd_GTxr2CsjxLiNCvdwMLtEqcmURUTfFv9+t16FMEjuiw@mail.gmail.com>
	<CANy2qHcCDkszLeOm-aJDCvkUaFFngtEy_VN+_B46K7KTQf4_Sg@mail.gmail.com>
	<CAPig+cSspbWKUcnp6NJ1rjYyWQV8bO3ZmV7L_J7QaHRFRh3-wg@mail.gmail.com>
	<CANy2qHfuFB6zJc0x_gDGT9MXtwQn2Jkb7v1mWyKoA8g1MjgGBA@mail.gmail.com>
	<CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Gabor Bernat <bernat@primeranks.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 10:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVxbL-0000yE-Or
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 10:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbbH3IEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 04:04:22 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34948 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbH3IES (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 04:04:18 -0400
Received: by qgj40 with SMTP id 40so167531qgj.2
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 01:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cbrx9TdOMUVMx+VcaBFuKpnUbzy92lSF5PfTj5KFKrs=;
        b=Rnzr4Vqbw+6xkCYsTcl3BaWQyk7UbZo08sNhZGOQ6qAQMiH6TDlaozB597/gbhcgr+
         /Bx+Ab6FehYrQBCub4Ellf/obg1TmgwIRRs+/lSoIvWdH1XklV4Gbt39xFdlcczgkNwU
         kv9bDW75LEegD9bWs1HIFCd6k5Ga18vZtQqKrYcckk/5+Gg+i7+ag/myeXuBDNMXmA69
         diQVO0bSQeg/MJKVXVUQntKAksHLqNyALg5vXEMCMYVBU5t5Y7a4lioz33KIHtRASstE
         06DbZQpLm/0tql2AU2B6BK9hIavF8p7AbS0MMf+5GMHVYjJlpDmEgz7pMMsU00jZ4wxY
         In9w==
X-Received: by 10.140.233.7 with SMTP id e7mr30324936qhc.79.1440921857076;
 Sun, 30 Aug 2015 01:04:17 -0700 (PDT)
Received: by 10.55.20.139 with HTTP; Sun, 30 Aug 2015 01:04:16 -0700 (PDT)
In-Reply-To: <CAPig+cTCQa6Vev2u4V-CbU1B5BGdrSk+8bjLE2Y1YBLog5Ehnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276808>

On Sun, Aug 30, 2015 at 5:15 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> (Please don't top-post on this list.)
>
> On Sat, Aug 29, 2015 at 11:00 PM, Gabor Bernat <bernat@primeranks.net> wrote:
>> Reading after it, I think the most close we can get with this is, awk
>> 'BEGIN { print strftime("%c", 1271603087); }; and just ignore setting
>> this value (and avoid displaying it) if that fails too. Do you agree?
>
> strftime() in awk is a GNU-ism. It doesn't exist in awk on Mac OS X or
> FreeBSD, or even the default awk on Linux (which is mawk on Linux
> installations I've checked).
>
> Most portable likely would be Perl, however, that's probably too
> heavyweight inside a loop like this, even if called only once each N
> iterations.

http://stackoverflow.com/questions/2445198/get-seconds-since-epoch-in-any-posix-compliant-shell
Found this,

awk 'BEGIN{srand();print srand()}'

srand() in awk returns the previous seed value, and calling it without
an argument sets it to time of day, so the above sequence should
return seconds since the epoch, or at least something in seconds that
is relative to a fixed point which is all that's needed in this
thread.

-- 
Mikael Magnusson
