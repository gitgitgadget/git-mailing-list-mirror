From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: git log --raw abbreviates SHA1s, despite what manual says
Date: Fri, 15 May 2015 17:42:51 +0200 (CEST)
Message-ID: <297757279.1883703.1431704571028.JavaMail.zimbra@imag.fr>
References: <loom.20150515T164345-901@post.gmane.org> <vpqfv6xc1zd.fsf@anie.imag.fr> <loom.20150515T171548-204@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Fri May 15 17:43:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtHlf-00044k-6b
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 17:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946176AbbEOPnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 11:43:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33760 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423113AbbEOPmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 11:42:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4FFgn3x017907
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2015 17:42:49 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4FFgpn9009929;
	Fri, 15 May 2015 17:42:51 +0200
In-Reply-To: <loom.20150515T171548-204@post.gmane.org>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF31 (Linux)/8.0.6_GA_5922)
Thread-Topic: git log --raw abbreviates SHA1s, despite what manual says
Thread-Index: C3WwKfd4lMBVOJTac/iI6un7kj20gA==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 15 May 2015 17:42:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4FFgn3x017907
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1432309369.20369@VoxANMZ2FFJj9fr1RZKXEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269153>

----- Original Message -----
> Thanks for the explanation.  Plain 'git log' does not print any diffs.
> Does that mean that the --raw flag is a no-op in that case?

No, it displays the patch, in raw format. But you're right that the doc is unclear.

> Perhaps running 'git log --raw' should print a warning
> 
>     --raw given for raw-format diffs, but the output format you have chosen
>     does not include diffs.  Did you mean 'git log --format=raw'?

I'd rather fix the doc. Patch follows.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
