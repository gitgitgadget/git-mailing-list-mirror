From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 22:05:48 +0200
Message-ID: <vpqhae97f8j.fsf@anie.imag.fr>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 22:06:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEm07-0006l8-2j
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 22:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab3H1UFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 16:05:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54936 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755231Ab3H1UFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 16:05:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7SK5knL000468
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 28 Aug 2013 22:05:46 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VElzw-0001CK-Ul; Wed, 28 Aug 2013 22:05:48 +0200
In-Reply-To: <1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 28 Aug 2013 14:23:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 28 Aug 2013 22:05:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7SK5knL000468
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378325148.99701@xUBGpsXhyjCyWuYr/Higag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233206>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> +	echo greg >> content &&
> +	git add content &&
> +	git commit -m one

test_commit would make it shorter.

> +	bzr log | grep "^committer: " > ../actual
> +	) &&
> +
> +	echo "committer: Gr=E9goire <committer@example.com>" > expected &&

Git's source code usually says >../actual and >expected, without space
after '>'.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
