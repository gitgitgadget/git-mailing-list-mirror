From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/9] Add has_extension()
Date: Thu, 10 Aug 2006 19:48:40 +0200
Message-ID: <44DB7178.4090706@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx> <11552221581171-git-send-email-rene.scharfe@lsrfire.ath.cx> <Pine.LNX.4.63.0608101825000.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 19:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBEeF-0001pJ-Df
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 19:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbWHJRsn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 Aug 2006 13:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422666AbWHJRsn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 13:48:43 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:11402
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1422664AbWHJRsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 13:48:42 -0400
Received: from [10.0.1.3] (p508E54C8.dip.t-dialin.net [80.142.84.200])
	by neapel230.server4you.de (Postfix) with ESMTP id 75B2F7004;
	Thu, 10 Aug 2006 19:48:41 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608101825000.10541@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25204>

Johannes Schindelin schrieb:
> On Thu, 10 Aug 2006, Rene Scharfe wrote:
>=20
>> The little helper has_extension() documents through its name what we=
 are
>> trying to do and makes sure we don't forget the underrun check.
>=20
> While I think it is a good change, it is independent of verify-pack, =
no?

I could have limited has_extension() to verify-pack.c initially and the=
n
sent a conversion for the other files after this series had been
accepted, yes.  It's one of the main cleanups for verify_one_pack(),
though, because it allowed me to drop some comments -- without losing
readability (IMHO).

I could have documented it broader scope better in the commit message. =
:-/

Thanks,
Ren=E9
