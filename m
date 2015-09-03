From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v5] git-p4: add config git-p4.pathEncoding
Date: Thu, 3 Sep 2015 10:26:56 +0200 (CEST)
Message-ID: <983771583.1014619.1441268816360.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1441226355-61103-1-git-send-email-larsxschneider@gmail.com> <1441226355-61103-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, gitster@pobox.com,
	tboegi@web.de, sunshine@sunshineco.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 03 10:18:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXPjM-0004cN-7j
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 10:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbbICISn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 04:18:43 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:57506 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751756AbbICISk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 04:18:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A59C921C3;
	Thu,  3 Sep 2015 10:18:37 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t45fLWBtU2uD; Thu,  3 Sep 2015 10:18:37 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 908A921A8;
	Thu,  3 Sep 2015 10:18:37 +0200 (CEST)
In-Reply-To: <1441226355-61103-2-git-send-email-larsxschneider@gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF40 (Win)/8.0.9_GA_6191)
Thread-Topic: git-p4: add config git-p4.pathEncoding
Thread-Index: IBgy9j0SlAPwO1RXEbIO9Xpcg44TRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277184>

Hi Lars,

Lars Schneider <larsxschneider@gmail.com> writes:

> +test_expect_success 'Clone repo containing iso8859-1 encoded paths w=
ith git-p4.pathEncoding' '
> +
> +        test_when_finished cleanup_git &&
> +        (
> +                cd "$git" &&
> +                git init . &&
> +                git config git-p4.pathEncoding iso8859-1 &&

Wouldn't 'test_config' be better here?

Thanks,
R=C3=A9mi
