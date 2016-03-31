From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/GSOC] Git Beginner | Warnings for potentially destructive
 commands (v2)
Date: Thu, 31 Mar 2016 09:59:38 +0200 (CEST)
Message-ID: <1915268342.2536406.1459411178113.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <56F51089.2050703@gmail.com> <56FBF760.3040106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	philipoakley@iee.org, Jacob Keller <jacob.keller@gmail.com>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 09:57:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alXTM-0007sB-FY
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 09:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbcCaH4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 03:56:48 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:37236 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754819AbcCaH4f convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 03:56:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id DC6B8219E;
	Thu, 31 Mar 2016 09:56:31 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id saXiwClk_gL8; Thu, 31 Mar 2016 09:56:31 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id C4E45219D;
	Thu, 31 Mar 2016 09:56:31 +0200 (CEST)
In-Reply-To: <56FBF760.3040106@gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: Git Beginner | Warnings for potentially destructive commands (v2)
Thread-Index: 8ifvJdzdIMt2sxJm/TC4pEdj3f4LLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290376>

Sidhant Sharma <tigerkid001@gmail.com> wrote:
> $ ggit push --force
>=20
> Pushing changes to $REMOTE/$BRANCH
> [WARNING] You are about to purge commits from the $REMOTE/$BRANCH bra=
nch and
> overwrite it's history to match yours.
> For instance, assume the following history exists where 'origin' is
> a configured remote and the current branch is master:
>=20
>         o---o---o---A---B  origin/master
>              \
>               X---Y---Z  your master
>=20
> After force push:
>=20
>         o---o---o---X---Y---Z  origin/master and your master

It should be:

        o---o---X---Y---Z  origin/master and your master

(The last 'o' commit should have been overwritten by the force push)

Thanks,
R=C3=A9mi
