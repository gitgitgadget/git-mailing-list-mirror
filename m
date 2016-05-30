From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Mon, 30 May 2016 13:32:08 +0200 (CEST)
Message-ID: <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 13:21:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7LG8-0007RK-Tu
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 13:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbcE3LVP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 07:21:15 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:40303 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752924AbcE3LVP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 07:21:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 3B40420AD;
	Mon, 30 May 2016 13:21:13 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QP5QH-DEY8pI; Mon, 30 May 2016 13:21:13 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 2987A2098;
	Mon, 30 May 2016 13:21:13 +0200 (CEST)
In-Reply-To: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: strbuf: improve API
Thread-Index: kEZ8GvVrmXq2sj+9jyweWFM/Ss+yyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295887>

William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
> This patch series implements an improvment of the strbuf API, allowin=
g
> strbuf to use preallocated memory. This makes strbuf fit to be used
> in performance-critical operations.
>=20
> The first patch is simply a preparatory work, adding tests for
> existing strbuf implementation.
> Most of the work is made in the second patch: handle pre-allocated
> memory, extend the API, document it and test it.

Seems interesting, however do you have any test/example that would
show the difference of performance between using these optimizations
and not using them?

Such values would make a nice addition to help convince people that
your series is interesting to have and use.

Thanks,
R=C3=A9mi
