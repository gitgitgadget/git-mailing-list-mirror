From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 1/2] rm: better error message on failure for multiple  files
Date: Mon, 10 Jun 2013 17:08:22 +0200
Message-ID: <vpqobbef1g9.fsf@anie.imag.fr>
References: <1370874127-4326-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<vpqtxl6ghf5.fsf@anie.imag.fr>
	<580989b4b95a7302a42c7f25024c3375@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>, <gitster@pobox.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: Mathieu =?iso-8859-1?Q?Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 17:08:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3iC-0003Nn-BP
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 17:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009Ab3FJPIi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 11:08:38 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51398 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab3FJPIh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 11:08:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5AF8LvK024706
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 17:08:21 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Um3hn-0003De-1v; Mon, 10 Jun 2013 17:08:23 +0200
In-Reply-To: <580989b4b95a7302a42c7f25024c3375@ensibm.imag.fr> ("Mathieu
	\=\?iso-8859-1\?Q\?Li\=E9nard--Mayor\=22's\?\= message of "Mon, 10 Jun 2013
 16:57:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Jun 2013 17:08:24 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227299>

Mathieu Li=E9nard--Mayor <mathieu.lienard--mayor@ensimag.fr> writes:

> Well the current code is only using errs=3Derror(...), using the same
> variable errs over and over, no matter how many times it loops.
> That's why i implemented it similarly.

OK, consistency is a good argument then.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
