From: "=?iso-8859-1?q?Jean-No=EBl?= AVILA" <avila.jn@gmail.com>
Subject: Re: t9902 fails
Date: Fri, 18 Jan 2013 23:23:55 +0100
Message-ID: <201301182323.55378.avila.jn@gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com> <7v8v7qsagd.fsf@alter.siamese.dyndns.org> <7vmww6qmck.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 23:24:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwKMO-0008G8-HJ
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 23:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab3ARWYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2013 17:24:07 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:54492 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab3ARWYG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2013 17:24:06 -0500
Received: from cayenne.localnet (unknown [82.239.31.145])
	by smtp2-g21.free.fr (Postfix) with ESMTP id BA13B4B0045;
	Fri, 18 Jan 2013 23:23:57 +0100 (CET)
User-Agent: KMail/1.13.7 (Linux/3.8.0-rc3jna; KDE/4.8.4; x86_64; ; )
In-Reply-To: <7vmww6qmck.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213943>

Le vendredi 18 janvier 2013 21:15:23, Junio C Hamano a =E9crit :
> Junio C Hamano <gitster@pobox.com> writes:
> > How about doing something like this and set that variable in the
> > test instead?  If STD_ONLY is not set, you will get everything, but
> > when STD_ONLY is set, we will stop reading from "help -a" when it
> > starts listing additional stuff.

I tried both of your propositions but none made test 10 of t9902 pass.

Am I supposed to run "make install" before running the test?
