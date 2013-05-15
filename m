From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: is this a bug of git-diff?
Date: Wed, 15 May 2013 11:34:41 +0200
Message-ID: <vpqhai4y4b2.fsf@grenoble-inp.fr>
References: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
	<CALWbr2z338CJgavC9sVGffHSoqr0Sb9nCsr4LKURDYpkOog2TQ@mail.gmail.com>
	<CABwUO_Wyq34S=CwbLeAqmzaFLxORkvGEvrjUzMXjkJdE1jnbhA@mail.gmail.com>
	<CALWbr2z2jB53=2UsEneqymU2peiL4OW9Tyace_8BN3=1gA9jNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: eric liou <accwuya@gmail.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 11:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcY6n-000349-Bu
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 11:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758474Ab3EOJet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 05:34:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56243 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758450Ab3EOJes (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 05:34:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4F9Ye8a012720
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 11:34:40 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UcY6b-0006AX-Gz; Wed, 15 May 2013 11:34:41 +0200
In-Reply-To: <CALWbr2z2jB53=2UsEneqymU2peiL4OW9Tyace_8BN3=1gA9jNg@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 15 May 2013 09:10:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 15 May 2013 11:34:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4F9Ye8a012720
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369215283.89334@j79vesfYkZL17KAWEsluVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224391>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Wed, May 15, 2013 at 8:52 AM, eric liou <accwuya@gmail.com> wrote:
>> Thank you for the quick reply.
>> But this line is not correct: "@@ -4,5 +4,6 @@ int a = 1;"

Antoine's answer is correct. In addition, I'd say that you may want to
enable color in the output to make it clearer (the @@ ... @@ part would
be colored, but not the function name):

  git config --global color.ui auto

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
