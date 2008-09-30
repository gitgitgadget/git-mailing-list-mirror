From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Tue, 30 Sep 2008 08:37:00 +0200
Message-ID: <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 30 08:38:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkYsY-0001Fs-3O
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 08:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYI3Gh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Sep 2008 02:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYI3Gh1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 02:37:27 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:43427 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYI3Gh0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Sep 2008 02:37:26 -0400
Received: from cuzco.lan (107.pool85-53-4.dynamic.orange.es [85.53.4.107])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m8U6b1Yn029164
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 30 Sep 2008 02:37:03 -0400
In-Reply-To: <48E1C39F.4070906@op5.se>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97067>

El 30/9/2008, a las 8:13, Andreas Ericsson escribi=F3:

> Jeff King wrote:
>> On Mon, Sep 29, 2008 at 10:09:17PM +0200, Pieter de Bie wrote:
>>> How about something like
>>>
>>> 	Created commit abcd1234 on widget -- "subwidget: one line summary"
>> I think that is probably just trading one visual problem for another=
=2E
>> That is, there are other people will have the same problem with "--"
>> that I had with ": ".
>
> Created 6207abc (subwidget: one quite long line of sum...) on <branch=
>
>
> "commit" is just noise.

Excellent point on the noise. Independently of whether the branch info =
=20
gets added the word "commit" should probably be dropped.

As far as long-line-wrapping goes, I don't really think this is a =20
problem for Git to solve (by truncation or any other means); it's more =
=20
of a user behaviour thing where one would hope that users would get =20
into the habit of using concise subject lines and branch names.

Cheers,
Wincent
