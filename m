From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/2] submodule: don't print status output with ignore=all
Date: Wed, 04 Sep 2013 08:31:25 +0200
Message-ID: <vpqa9jtayiq.fsf@anie.imag.fr>
References: <1378066009-1017855-1-git-send-email-sandals@crustytoothpaste.net>
	<1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	judge.packham@gmail.com, gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Sep 04 08:35:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH6g7-0008TK-CQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 08:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761997Ab3IDGez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 02:34:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52653 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761948Ab3IDGey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 02:34:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r846VPkK026375
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 4 Sep 2013 08:31:25 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VH6cf-000233-Na; Wed, 04 Sep 2013 08:31:25 +0200
In-Reply-To: <1378066009-1017855-3-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Sun, 1 Sep 2013 20:06:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 04 Sep 2013 08:31:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r846VPkK026375
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378881088.96075@72ybldKrjWZLGIGiOKN+GA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233808>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Tests are included which verify that this change has no effect on git submodule
> summary without the --for-status option.

I still don't understand why this is needed. Why do we want "git status"
and "git submodule summary" to display different information? Wasn't it
a nice property that the part of "git status" about submodule is the
same as "git submodule summary"?

This should at least be explained in the commit message IMHO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
