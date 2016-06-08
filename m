From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v4 1/6] t9001: non order-sensitive file comparison
Date: Wed, 8 Jun 2016 16:22:09 +0200 (CEST)
Message-ID: <1755917243.420844.1465395729704.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org> <20160608130142.29879-1-samuel.groot@grenoble-inp.org> <20160608130142.29879-2-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tom russello <tom.russello@grenoble-inp.org>,
	erwan mathoniere <erwan.mathoniere@grenoble-inp.org>,
	jordan de-gea <jordan.de-gea@grenoble-inp.org>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>, gitster@pobox.com,
	aaron@schrab.com, e@80x24.org
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 16:10:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAeBS-0007ZO-Nw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 16:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161617AbcFHOKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2016 10:10:08 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:51683 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161492AbcFHOKH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2016 10:10:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 66A6520B2;
	Wed,  8 Jun 2016 16:10:03 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dND2yjUQUuWx; Wed,  8 Jun 2016 16:10:03 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4F39920A5;
	Wed,  8 Jun 2016 16:10:03 +0200 (CEST)
In-Reply-To: <20160608130142.29879-2-samuel.groot@grenoble-inp.org>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: t9001: non order-sensitive file comparison
Thread-Index: cmSGDF0d4ymrvUeJoe6DA9poo1ekfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296798>

Hi Samuel,

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
> +test_cmp_noorder () {
> +        sort "$1" >"$1_noorder"
> +        sort "$2" >"$2_noorder"
> +        test_cmp $1 $2

You meant `test_cmp "$1_noorder" "$2_noorder"`, I guess.

Thanks,
R=C3=A9mi
