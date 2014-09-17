From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Query: Failed to suppress CC while sending patchset
Date: Wed, 17 Sep 2014 08:59:38 +0200
Message-ID: <vpqd2au20md.fsf@anie.imag.fr>
References: <CAMf-jSkjYFEsN01DZc=Xc6qb037zeVeo4cUKDJJN-Q0Z4f6B9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pramod Gurav <pramod.gurav.etc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 08:59:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU9DV-0005mj-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 08:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbaIQG7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 02:59:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54998 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751406AbaIQG7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 02:59:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s8H6xcrh031826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Sep 2014 08:59:38 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s8H6xc3L030422;
	Wed, 17 Sep 2014 08:59:38 +0200
In-Reply-To: <CAMf-jSkjYFEsN01DZc=Xc6qb037zeVeo4cUKDJJN-Q0Z4f6B9Q@mail.gmail.com>
	(Pramod Gurav's message of "Wed, 17 Sep 2014 12:20:13 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 17 Sep 2014 08:59:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s8H6xcrh031826
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1411541978.38163@FlrykdbQ4NT83CDvZFiOug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257214>

Pramod Gurav <pramod.gurav.etc@gmail.com> writes:

> gpramod:linux-next$ git send-email --to=pramod.gurav.etc@gmail.com
> --suppress-cc=cc --suppress-cc=self --suppress-cc=author 000*

I guess you lacked the --suppress-cc=bodycc.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
