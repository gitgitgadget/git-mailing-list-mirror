From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: A tiny documentation patch
Date: Tue, 11 Aug 2009 10:01:57 +0200
Message-ID: <4A812575.50105@drmicha.warpmail.net>
References: <20090810144419.GB24183@headley> <200908101659.28291.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqMO-0002qk-Dv
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbZHKMVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 08:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbZHKMVT
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:21:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39238 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753702AbZHKMVS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 08:21:18 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DF588123FE;
	Tue, 11 Aug 2009 04:02:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 11 Aug 2009 04:02:14 -0400
X-Sasl-enc: 2EapbZ0l71PfdRS9np5YFyqTZqpuMAQy6Us4A87jnyxI 1249977733
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9FF715CF4;
	Tue, 11 Aug 2009 04:02:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.3pre) Gecko/20090811 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <200908101659.28291.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125532>

Thomas Rast venit, vidit, dixit 10.08.2009 16:59:
> =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:
[...]
> [...]
>> -In mirror mode, enabled with `\--mirror`, the refs will not be stor=
ed
>> +In mirror mode, enabled with `--mirror`, the refs will not be store=
d
> [...]
>> -mode, furthermore, `git push` will always behave as if `\--mirror`
>> +mode, furthermore, `git push` will always behave as if `--mirror`
>=20
> While I'm not sure how far back you'd have to go to find an asciidoc
> that does need this escaping, it's definitely *not* a typo.  In some
> instances, -- turns into em dashes.
>=20
> If you are seeing stray backslashes in the output (I don't), I suspec=
t
> you are either running asciidoc 8.x but forgot to set ASCIIDOC8, or
> 8.4.1+ and are missing the patch 71c020c (Disable asciidoc 8.4.1+
> semantics for `{plus}` and friends, 2009-07-25).
[...]

In current next's Documentation/, we have 149 lines with `-- and 48
lines with `\--. How is our policy regarding old AsciiDoc? I suggest
(read: volunteer) making these things uniform one way or the other,
depending which versions we want to support.

Michael
