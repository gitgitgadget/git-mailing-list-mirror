From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: case where diff output needs improving? (was Re: [PATCH v2 0/7] 
	tests: use skip_all=* to skip tests)
Date: Thu, 12 Aug 2010 06:43:38 +0000
Message-ID: <AANLkTiktfhsFWuS5V9aBcuUwQUUAvkc3+q4rhZhTarYP@mail.gmail.com>
References: <7vd3tpxao1.fsf@alter.siamese.dyndns.org>
	<1281553450-26467-1-git-send-email-avarab@gmail.com>
	<87zkwsxsd0.fsf_-_@hariville.hurrynot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Raja R Harinath <harinath@hurrynot.org>
X-From: git-owner@vger.kernel.org Thu Aug 12 08:43:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjRVx-0007oP-Us
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 08:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564Ab0HLGnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 02:43:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59868 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab0HLGnk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 02:43:40 -0400
Received: by bwz3 with SMTP id 3so662293bwz.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cITUuMEidssZdbVa+sGqFxC7f8LoKtJQJZt0VeACpMo=;
        b=r1M95qnYUViIeO1FFxdK6v8zoJpFtGy/qo5oay1gOElA/a3jqhjGaW/gNRCwKCPJ+L
         Lq4+C9l0Fknm46lkI8xuZzGYaTeIQLYjDoWlw/oTbOPCDXzu9V+nwopbK++dMygHHkuF
         VyzmpHy4G7uEfcn95pDiQoHOFv6yVnU1t1PJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aDLh53vcPUhSGBcIBYP1w+zoP3KUuIB+FsvIByuQNyTQS/v4Dcecj/xGb8DuEk1eBb
         xKtSb9+myB9Py9b9NOMbD84QzFHeamlzz9HHF6UAZg+vBKcqFnhvcfpZBzhsu+IMz6BY
         SWpyFKia1XDbg6r4LQ9rxHC9gGe5K4VrBMycM=
Received: by 10.223.117.194 with SMTP id s2mr21114988faq.57.1281595418670; 
	Wed, 11 Aug 2010 23:43:38 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 23:43:38 -0700 (PDT)
In-Reply-To: <87zkwsxsd0.fsf_-_@hariville.hurrynot.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153348>

On Thu, Aug 12, 2010 at 06:22, Raja R Harinath <harinath@hurrynot.org> =
wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> [snip]
>> =C2=A0 =C2=A0 diff --git a/t/t4016-diff-quote.sh b/t/t4016-diff-quot=
e.sh
>> =C2=A0 =C2=A0 index 10e2db3..ab0c2f0 100755
>> =C2=A0 =C2=A0 --- a/t/t4016-diff-quote.sh
>> =C2=A0 =C2=A0 +++ b/t/t4016-diff-quote.sh
>> =C2=A0 =C2=A0 @@ -14 +14 @@ P2=3D'pathname with SP'
>> =C2=A0 =C2=A0 -if P3=3D'pathname
>> =C2=A0 =C2=A0 +P3=3D'pathname
>> =C2=A0 =C2=A0 @@ -16 +16 @@ with LF'
>> =C2=A0 =C2=A0 -: 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P1"
>> =C2=A0 =C2=A0 +if : 2>/dev/null >"$P1" && test -f "$P1" && rm -f "$P=
1"
>
> Assuming this was from a git invocation, it seems that 'diff' could j=
ust
> show line 15 instead of '@@ -16, +16 @@' above.

That was from -U0, and showing line 15 would go against the -U0 paramet=
er.
