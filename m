From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: move detection doesnt take filename into account
Date: Tue, 1 Jul 2014 11:16:44 +0200 (CEST)
Message-ID: <287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
References: <53B105DA.30004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Elliot Wolk <elliot.wolk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 11:16:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1uBL-0001SX-MH
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 11:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485AbaGAJQv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2014 05:16:51 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:43136 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbaGAJQu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jul 2014 05:16:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 4DC02815DC;
	Tue,  1 Jul 2014 11:16:49 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 81TaqqQ3RbbQ; Tue,  1 Jul 2014 11:16:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 97D9381686;
	Tue,  1 Jul 2014 11:16:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GX2kKsrZIAtW; Tue,  1 Jul 2014 11:16:44 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 7D02781683;
	Tue,  1 Jul 2014 11:16:44 +0200 (CEST)
In-Reply-To: <53B105DA.30004@gmail.com>
X-Originating-IP: [80.252.171.62]
X-Mailer: Zimbra 8.0.7_GA_6020 (ZimbraWebClient - FF30 (Mac)/8.0.7_GA_6020)
Thread-Topic: move detection doesnt take filename into account
Thread-Index: Y/JBMI6zZA3ggM/v7bBPmXCfuKfA2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252714>



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "Elliot Wolk" <elliot.wolk@gmail.com>
> Till: git@vger.kernel.org
> Skickat: m=C3=A5ndag, 30 jun 2014 8:38:18
> =C3=84mne: move detection doesnt take filename into account
>=20
> if you move two identical {e.g.: empty} files to two new locations in=
 a
> single commit, the move detection picks them {seemingly?} arbitrarily=
=2E
> it should use a statistical algorithm to compare the filenames and pi=
ck
> a likely match.

I think it does, but based on filename suffix. E.g. here is a rename of
three empty files with a suffix.

 3 files changed, 0 insertions(+), 0 deletions(-)
 rename 1.a =3D> 2.a (100%)
 rename 1.b =3D> 2.b (100%)
 rename 1.c =3D> 2.c (100%)

-- robin
