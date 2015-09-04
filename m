From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v5] git-p4: add config git-p4.pathEncoding
Date: Fri, 4 Sep 2015 10:30:13 +0200 (CEST)
Message-ID: <1646294553.1067005.1441355413320.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1441226355-61103-1-git-send-email-larsxschneider@gmail.com> <1441226355-61103-2-git-send-email-larsxschneider@gmail.com> <983771583.1014619.1441268816360.JavaMail.zimbra@ensimag.grenoble-inp.fr> <5E77893F-8E13-4696-B7A6-46E10FE41989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, gitster@pobox.com,
	tboegi@web.de, sunshine@sunshineco.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 10:22:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXmFy-0007D1-TD
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 10:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758335AbbIDIVz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2015 04:21:55 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:34835 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753174AbbIDIVw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Sep 2015 04:21:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 0EA3F294E;
	Fri,  4 Sep 2015 10:21:49 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFJfbt1gKQgA; Fri,  4 Sep 2015 10:21:48 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id F09CF293E;
	Fri,  4 Sep 2015 10:21:48 +0200 (CEST)
In-Reply-To: <5E77893F-8E13-4696-B7A6-46E10FE41989@gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF40 (Win)/8.0.9_GA_6191)
Thread-Topic: git-p4: add config git-p4.pathEncoding
Thread-Index: yj8JtwF/Ggup++Ppmj56pdiso1Wc/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277293>

Lars Schneider <larsxschneider@gmail.com> writes:

> > Hi Lars,
> >
> > Lars Schneider <larsxschneider@gmail.com> writes:
> >
> >> +test_expect_success 'Clone repo containing iso8859-1 encoded path=
s with git-p4.pathEncoding' '
> >> +
> >> +        test_when_finished cleanup_git &&
> >> +        (
> >> +                cd "$git" &&
> >> +                git init . &&
> >> +                git config git-p4.pathEncoding iso8859-1 &&
> >
> > Wouldn't 'test_config' be better here?
> >
> If I got Eric=E2=80=99s explanation right in "[PATCH v1] t9821: use
> test_config=E2=80=9D then we should not use =E2=80=9Ctest_config=E2=80=
=9D here?

After reading Eric's point of view, I agree with him about this.

So, sorry for the noise, now I'll know better in the future when
to use and not use 'test_config'.

Thanks,
R=C3=A9mi
