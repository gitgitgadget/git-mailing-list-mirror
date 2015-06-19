From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Fri, 19 Jun 2015 12:50:25 +0200 (CEST)
Message-ID: <319721281.628788.1434711025325.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com> <CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com> <CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com> <20150617191235.GB25304@peff.net> <20150618101353.GA6525@lanh> <xmqqioalezhq.fsf@gitster.dls.corp.google.com> <20150619103946.GA20493@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:49:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5trB-0002k4-MW
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 12:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbbFSKtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 06:49:00 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:42786 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932465AbbFSKsz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 06:48:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 2C1FA3758;
	Fri, 19 Jun 2015 12:48:53 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3s-xgoUK1vf; Fri, 19 Jun 2015 12:48:53 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 14EFA3730;
	Fri, 19 Jun 2015 12:48:53 +0200 (CEST)
In-Reply-To: <20150619103946.GA20493@lanh>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Win)/8.0.9_GA_6191)
Thread-Topic: strbuf: stop out-of-boundary warnings from Coverity
Thread-Index: E5WfdSMpU1enH9FeryZvNQ/1dzqfbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272123>

Duy Nguyen <pclouds@gmail.com> writes:

> + sb.buf[0] =3D 'Z';
> + printf("%c\n", strbuf_slopbuf[0]);
> + return 0;
> startup_info =3D &git_startup_info;

I might be wrong, but I definitely think that this
printf and return 0 are some debug lines that you=20
forgot to remove.

R=C3=A9mi
