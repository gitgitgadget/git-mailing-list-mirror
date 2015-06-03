From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC v3 2/4] git-am.txt: add configuration section in git am
 documentation
Date: Wed, 3 Jun 2015 10:26:34 +0200 (CEST)
Message-ID: <217974219.58943.1433319994168.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433266446-2845-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <1433266446-2845-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr> <556E95AC.7040305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 03 10:26:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z040R-0007TX-OF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 10:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbbFCI0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2015 04:26:32 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:36479 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752986AbbFCI03 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 04:26:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A6C544884F;
	Wed,  3 Jun 2015 10:26:27 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9W-fqBEI1C4; Wed,  3 Jun 2015 10:26:27 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8EF6548846;
	Wed,  3 Jun 2015 10:26:27 +0200 (CEST)
In-Reply-To: <556E95AC.7040305@web.de>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-am.txt: add configuration section in git am documentation
Thread-Index: QptdKyK1w6QxxVAO0GzPtUr3dSgCvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270666>

> On 06/03/2015 07:50 AM Torsten B=C3=B6gershausen <tboegi@web.de> wrot=
e
>
> > +CONFIGURATION
> > +-------------
> > +
> > +am.keepcr::
> > +        If true, git-am will call git-mailsplit for patches in mbo=
x format
> > +        with parameter '--keep-cr'. In this case git-mailsplit wil=
l
> > +        not remove `\r` from lines ending with `\r\n`. Can be over=
ridden
> > +        by giving '--no-keep-cr' from the command line.
> (This documentation assumes that am.keepcr is true)
> Would it be clearer to put the "overridden" into one line and write l=
ike
> this:
>=20
> Can be overridden by giving '--no-keep-cr' or '--keep-cr' from the co=
mmand line.

Yes I agree, or maybe:

'--keep-cr' and '--no-keep-cr' take precedence over this variable.

Actually, I don't know if we need to write it (as Paul Tan suggested
in the previous version of this patch for the threeway option
http://article.gmane.org/gmane.comp.version-control.git/270150)

I checked the documentation of different commands. From what I've
seen, such indications either does not appear or are right after the
text. I agree that it's a good idea, but for the sake of consistency,
I'd rather use one of these two format as long as it's ok for you.
