From: "Gaer, A." <Andreas.Gaer@baslerweb.com>
Subject: AW: git performance after directory copy
Date: Mon, 20 Sep 2010 13:53:15 +0200
Message-ID: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B865@ahr075s.basler.corp>
References: <C5A8FDEFF7647F4C9CB927D7DEB307730F33B7C9@ahr075s.basler.corp> <vpq62y0hh63.fsf@bauges.imag.fr> <4C974A00.8030905@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 20 13:53:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxew3-0003jl-DR
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 13:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab0ITLxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 07:53:21 -0400
Received: from mail01.baslerweb.com ([80.156.24.166]:27168 "EHLO
	mail01.baslerweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671Ab0ITLxV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 07:53:21 -0400
Received: from mail.baslerweb.com ([80.156.24.162])
  by mail01-out.baslerweb.com with ESMTP; 20 Sep 2010 13:54:05 +0200
Received: (from smtpd@127.0.0.1) by mail.baslerweb.com (8.13.4/8.13.4)
	id o8KBrFwS012610; Mon, 20 Sep 2010 13:53:15 +0200
Received: from unknown [80.156.24.166] by gateway id /processing/kw4zbnpW; Mon Sep 20 13:53:15 2010
Received: from unknown (HELO AHR075S.basler.corp) ([172.16.20.75])
  by mail01-out.baslerweb.com with ESMTP; 20 Sep 2010 13:54:01 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <4C974A00.8030905@viscovery.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git performance after directory copy
Thread-Index: ActYubdz+0uiACUfTyucynFrdPgpGAAADAsw
X-SecurE-Mail-Gateway: Version: 5.00.3.1 (smtpd: 6.53.8.7) Date: 20100920115315Z
Content-class: urn:content-classes:message
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156619>

Hello Johannes,

you are right. Sorry. I totally overlooked release notes for 1.7.1.1. T=
hanks for all your help!

Regards,
 Andreas.
=20

-----Urspr=FCngliche Nachricht-----
Von: Johannes Sixt [mailto:j.sixt@viscovery.net]=20
Gesendet: Montag, 20. September 2010 13:48
An: Matthieu Moy
Cc: Gaer, A.; git@vger.kernel.org
Betreff: Re: git performance after directory copy

Am 9/20/2010 11:56, schrieb Matthieu Moy:
> But I'm surprised that the next "git status" are still slow. Other
> people may get a better explanation, but this very much looks like a
> bug.

Most likely, Andreas works with 1.7.1. From the release notes of 1.7.1.=
1:

 * "git status" stopped refreshing the index by mistake in 1.7.1.

-- Hannes
