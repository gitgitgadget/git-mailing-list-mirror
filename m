From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] send-email: lazily assign editor variable
Date: Tue, 23 Mar 2010 11:56:19 +0100
Message-ID: <4BA89E53.3000201@drmicha.warpmail.net>
References: <20100322145947.GA1709@pengutronix.de> <eb0d92cf28820eb9783e789a8c4c62c3af4dd0d0.1269274203.git.git@drmicha.warpmail.net> <20100323005806.GA9335@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 11:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu1pg-0002NM-Q2
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 11:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab0CWK7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 06:59:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42134 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752006Ab0CWK7I (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 06:59:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5EEE7E9A63;
	Tue, 23 Mar 2010 06:59:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 23 Mar 2010 06:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xSBNlUmit90DRtDtIh0vG2RFuUw=; b=cDi4qeT/4AD1iS7WKjm3kL5FNe1pr9niqy1NsyzzY0qCTzkW3W3KitDXdrKiJwRcsEM0VVpQrKXa4IMX3kk+Lwd9rCwWEg4kgqBzU9cPrkmWyVe5EchrWe94kSsQ2RA6beH0utdmy07CaC/8smwMEA7CqB9UCm1jIDKVoY4gk2o=
X-Sasl-enc: 9Di8XkBNSCqKmrZeZ4O4oyxCDUZ0hGr4QyghGZGGGZFm 1269341947
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 75D794B979A;
	Tue, 23 Mar 2010 06:59:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <20100323005806.GA9335@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143005>

Jonathan Nieder venit, vidit, dixit 23.03.2010 01:58:
> Michael J Gruber wrote:
>=20
>> b4479f0 (add -i, send-email, svn, p4, etc: use "git var GIT_EDITOR",
>> 2009-10-30) introduced the use of git var GIT_EDITOR which may lead =
to
>> problems when send-mail is used without a tty.
>>
>> Therefore, use git var GIT_EDITOR only when we actually edit somethi=
ng.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> FWIW:
>=20
>   Acked-by: Jonathan Nieder <jrnieder@gmail.com>
>=20
> Next time, please CC me.

Yep, sorry for the omission.

Michael
