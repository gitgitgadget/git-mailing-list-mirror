From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git diff: add option for omitting the contents of deletes
Date: Mon, 28 Feb 2011 10:58:26 +0100
Message-ID: <4D6B71C2.6080203@drmicha.warpmail.net>
References: <AANLkTi=++gcw5CDQnTRbhUGkvWc9Zm+Ct4Zm5oGGYKUh@mail.gmail.com>	<7vk4gm7dz3.fsf@alter.siamese.dyndns.org>	<4D6A6291.8050206@drmicha.warpmail.net> <AANLkTik+MPPYOm+O5cmFur_2DKKy0bt9i0XeuKbHbaJU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?Mart_S=F5mermaa?= <mrts.pydev@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 11:02:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtzvU-0006Ry-GH
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 11:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753309Ab1B1KBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 05:01:48 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33472 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752886Ab1B1KBs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 05:01:48 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B7E562056D;
	Mon, 28 Feb 2011 05:01:47 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 28 Feb 2011 05:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=GUtcs5SyboSGXXDvhg3hx+Na7Lo=; b=saj2IonbAG0ub1uFvpuXGDqEeOpfXBHaVoR9n4ZZ2lDYECEbS2T5rjSz6xnLEO91AQ4WaGCkPdaQrqvsfkIpKcquPbYWgCMOdc4sJ17kaQf59q9zb//6VBDJnutle+3+bu0yC8xaVwsBo4Iv8aQswPIOULsjKqf3MnSS74UNW5g=
X-Sasl-enc: YTRzh+oUJKcgKFwT2Kfqrz7OukgVHA2wUo0U9yXod623 1298887307
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2479E404F58;
	Mon, 28 Feb 2011 05:01:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTik+MPPYOm+O5cmFur_2DKKy0bt9i0XeuKbHbaJU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168094>

Mart S=F5mermaa venit, vidit, dixit 27.02.2011 23:33:
> Junio, jokes aside, do you think this is useful?
> Would you accept a patch that implements this?
>=20
> Micheal, thanks for the indirect + :). Is it +0 or +1?

It's -1 for the spelling of my name (unless it is correct in your
language), and +1 for having "-D". As Junio explained, it is important
to have this only for "viewing diffs" (like the color stuff) and not in
the way of generation of patches which are meant to be applied (with -R=
,
possibly), so that one can have it "on" by default for viewing. OTOH, i=
f
(it's off by default, naturally, and) there's no config and just let
people have their option (like --color-words) I don't see a problem.

Michael
