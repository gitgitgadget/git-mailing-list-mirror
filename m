From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v8] git-p4: Obey core.ignorecase when using P4 client
 specs
Date: Fri, 28 Aug 2015 12:46:23 +0200 (CEST)
Message-ID: <1850907036.888095.1440758783529.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1440679948-28271-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 28 12:38:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVH3d-0003xS-MO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 12:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbbH1Kik convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2015 06:38:40 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:52863 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525AbbH1Kii convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 06:38:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DBBAA2195;
	Fri, 28 Aug 2015 12:38:35 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ANo8_AbEofrp; Fri, 28 Aug 2015 12:38:35 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id CA4EF2192;
	Fri, 28 Aug 2015 12:38:35 +0200 (CEST)
In-Reply-To: <1440679948-28271-1-git-send-email-larsxschneider@gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF40 (Win)/8.0.9_GA_6191)
Thread-Topic: git-p4: Obey core.ignorecase when using P4 client specs
Thread-Index: Y05nZiULnuugi6dkLfbxMIe+MwRkIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276716>

Hi,

Lars Schneider <larsxschneider@gmail.com> writes:
> Fix this by using the path case that appears first in lexicographical
> order when core.ignorcase is set to true. This behavior is consistent

s/core.ignorcase/core.ignorecase

> with "p4" and "p4v".

Thanks,
R=C3=A9mi
