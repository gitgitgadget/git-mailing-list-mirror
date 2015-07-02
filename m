From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 3/4] log --count: added test
Date: Thu, 2 Jul 2015 11:09:28 +0200 (CEST)
Message-ID: <134930107.140053.1435828168932.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com> <1435815536-30611-3-git-send-email-lawrencesiebert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Lawrence Siebert <lawrencesiebert@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 11:06:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAaSM-0002oa-IN
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 11:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbbGBJGu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2015 05:06:50 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:60058 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752621AbbGBJGs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jul 2015 05:06:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 288678EE4;
	Thu,  2 Jul 2015 11:06:46 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XGzReesfPWk; Thu,  2 Jul 2015 11:06:46 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 18CF28EBA;
	Thu,  2 Jul 2015 11:06:46 +0200 (CEST)
In-Reply-To: <1435815536-30611-3-git-send-email-lawrencesiebert@gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: log --count: added test
Thread-Index: epe2NLoITTKQlZioSFOEZccNsu9eIw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273219>

Hi Lawrence,

Lawrence Siebert <lawrencesiebert@gmail.com> writes:
> +test_expect_success 'log --count' '
> +        git log --count HEAD > actual &&
> +        git        rev-list --count HEAD > expect &&

Why the huge space here between 'git' and 'rev-list'?
Also no space after the redirection ('>'), it should be '>actual' and
'>expect'.

> +        test_cmp expect actual
> +'       =20
> +       =20

In the mail I see some trailing whitespace after the last two lines.
I can't apply it myself before some time, so I can't see if 'git am'
warns me about trailing whitespace.
You can use 'git log --check' to see the trailing whitespace in your
commits.
I'll look if I see some trailing whitespace in your other parts of the
patch but I might miss some.

R=C3=A9mi
