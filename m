From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: does a successful 'git gc' imply 'git fsck'
Date: Mon, 03 Dec 2012 14:46:18 +0100
Message-ID: <vpq4nk3uu39.fsf@grenoble-inp.fr>
References: <CAMK1S_iBq1ReGkjuy2UBENSQXOWyKj2ZzSCcg7Z89FVtVL2wMw@mail.gmail.com>
	<7vlidgls09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 14:46:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfWM7-00047s-Fp
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 14:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660Ab2LCNq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 08:46:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53842 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233Ab2LCNq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 08:46:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qB3DaUQ5025705
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Dec 2012 14:36:30 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TfWLi-0004HU-Bt; Mon, 03 Dec 2012 14:46:18 +0100
In-Reply-To: <7vlidgls09.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 02 Dec 2012 01:31:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 03 Dec 2012 14:36:33 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qB3DaUQ5025705
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1355146594.68303@QJ7M147QTHRmOnY0S24NIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211037>

Junio C Hamano <gitster@pobox.com> writes:

> But a "gc" does not necessarily run "repack -a" when it does not see
> too many pack files, so it can end up scanning only the surface of
> the history to collect the recently created loose objects into a
> pack, and stop its traversal without going into existing packfiles.

Isn't that the behavior of "git gc --auto", not plain "git gc" ?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
