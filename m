From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: (Mosty harmless) protocol error when pushing
Date: Thu, 27 May 2010 14:33:05 +0300
Message-ID: <20100527113305.GB7865@LK-Perkele-V2.elisa-laajakaista.fi>
References: <AANLkTikbFaNhiDngY7Cgk0Ce0YhmNBGIpXtn7abjXnPR@mail.gmail.com>
 <20100525072824.GA19612@coredump.intra.peff.net>
 <AANLkTilc9-B79EhmmO2t-VsHFZdupQn8zX9LFYRrn5of@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 13:34:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHbMU-0004Eg-90
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 13:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab0E0Len convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 07:34:43 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:55081 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab0E0Lem convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 07:34:42 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 5D5748C139;
	Thu, 27 May 2010 14:34:39 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A06A83588BB; Thu, 27 May 2010 14:34:39 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 493B5158A63;
	Thu, 27 May 2010 14:34:36 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilc9-B79EhmmO2t-VsHFZdupQn8zX9LFYRrn5of@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147845>

On Wed, May 26, 2010 at 07:58:29AM +0200, Bj=C3=B6rn Gustavsson wrote:
> 2010/5/25 Jeff King <peff@peff.net>:
>=20
> Unfortunately, I was also unable to reproduce the problem,
> so I can't test it either.
>=20
> There is no easy way to force a GC on my repository at github,
> so I tried to push to a local repository having too many loose
> objects using the "file:" protocol but the problem did not occur
> (i.e. the repository was auto packed but the protocol error did
> not happen).

I can't reproduce it either.

I tried testing using git:// over TLS. I could trigger the auto-gc,
but got no messages about it (hmm... other sideband messages do
work...) and no protocol error.

Git 1.7.1 on both sides.

-Ilari
