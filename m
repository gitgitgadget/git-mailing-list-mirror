From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 06:12:32 +0200
Organization: Pardus / KDE
Message-ID: <200712040612.32483.ismail@pardus.org.tr>
References: <4753D419.80503@clearchain.com> <20071203230432.GA1337@wolf.clearchain.com> <200712040037.37204.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benjamin Close <Benjamin.Close@clearchain.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 05:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzP8e-00033A-Ra
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 05:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbXLDELo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 23:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXLDELo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 23:11:44 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:37348 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751334AbXLDELo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 23:11:44 -0500
Received: from ninjamobile.local (unknown [85.102.220.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 841C661CA646;
	Tue,  4 Dec 2007 06:11:40 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <200712040037.37204.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67002>

Tuesday 04 December 2007 Tarihinde 01:37:35 yazm=C4=B1=C5=9Ft=C4=B1:
> On Tue, 4 Dec 2007, Benjamin Close wrote:
> > On Tue, Dec 04, 2007 at 12:20:26AM +0200, Ismail Donmez wrote:
> > > Can you try the attached patch?
> >
> > I confirm that the patch corrects the problem.
> >
> > Without it I get the Cannot decode string error. With it gitweb
> > displays correctly.
>
> But the patch _avoids_ issue (des not convert owner to utf8), rather
> than solving it, if I understand it correctly. What if gecos is in
> utf-8?

Indeed its a workaround but UTF-8 username is correctly displayed in gi=
tweb so=20
my understanding was gecos field is already UTF-8.

--=20
Never learn by your mistakes, if you do you may never dare to try again=
=2E
