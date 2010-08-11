From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked
 	files
Date: Wed, 11 Aug 2010 22:50:43 +0200
Message-ID: <4C630D23.5090001@web.de>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu> <AANLkTikPSR36SdUuzWsXxZsy9jsKOnp=_iz43BF-6nYe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg Brockman <gdb@mit.edu>, git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 22:50:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjIGB-0008WU-DM
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 22:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab0HKUup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 16:50:45 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:56976 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab0HKUup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 16:50:45 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id C23DD16609B0C;
	Wed, 11 Aug 2010 22:50:43 +0200 (CEST)
Received: from [80.128.112.119] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OjIG3-0003YK-00; Wed, 11 Aug 2010 22:50:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTikPSR36SdUuzWsXxZsy9jsKOnp=_iz43BF-6nYe@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/9goYZO0Z3na+9XepKWsIONS18CwtRm2O36iw+
	NR6hytpjv0NCLUoy5AR1NBljhEVhOcH7cwmq5x7gKsqdChos0s
	0iicPwlGFUH3z2bas7IA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153304>

Are we talking about two different issues here?

Am 11.08.2010 14:24, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Wed, Aug 11, 2010 at 07:03, Greg Brockman <gdb@mit.edu> wrote:
>> Currently, 'git add' will complain about excluded files, even if the=
y
>> are already tracked:

I'm all for not complaining when adding an ignored file that is
already tracked, as the user already told us he wants to track
this file despite .gitignore.

>> ... so it feels natural to me not
>> to require extra user confirmation when an explicit path has been pr=
ovided.
>=20
> I like it. I keep a /etc in git with .gitignore "*". This would help =
a
> lot for use cases like that. Explicitly specifying a full path should
> override gitignore IMO.

I'm not so sure if we should silently add ignored files just because
they appear on the command line. For me having to force the first time
I do a "git add" for an otherwise ignored file looks like a feature.
