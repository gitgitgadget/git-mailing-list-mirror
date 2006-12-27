From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: git-1.4.4.3, also 1.5.0rc0: send-email gets empty From:
Date: Wed, 27 Dec 2006 10:43:19 -0300
Message-ID: <200612271343.kBRDhKfA009927@laptop13.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Dec 27 14:43:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzZ4B-0002mZ-9D
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 14:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbWL0Nnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 08:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWL0Nnb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 08:43:31 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43817 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932818AbWL0Nnb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 08:43:31 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kBRDhO33014189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 27 Dec 2006 10:43:24 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kBRDhKfA009927
	for <git@vger.kernel.org>; Wed, 27 Dec 2006 10:43:24 -0300
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 27 Dec 2006 10:43:24 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35470>

I updated a local project, git-format-patch:ed, and then:

  $ git send-email --to=olpc@listas.inf.utfsm.cl --no-signed-off-by-cc /tmp/0001-Add-myself-to-AUTHORS.txt
  Who should the emails appear to be from? 
  Emails will be sent from: 
  Message-ID to be used as In-Reply-To for the first email? 
  /tmp/0001-Add-myself-to-AUTHORS.txt
  Use of uninitialized value in concatenation (.) or string at /usr/bin/git-send-email line 392.
  (mbox) Adding cc: Horst H. von Brand <vonbrand@inf.utfsm.cl> from line 'From: Horst H. von Brand <vonbrand@inf.utfsm.cl>'
  OK. Log says:
  Date: Wed, 27 Dec 2006 10:27:39 -0300
  Sendmail: /usr/sbin/sendmail
  From: 
  Subject: [PATCH] Add myself to AUTHORS
  Cc: Horst H. von Brand <vonbrand@inf.utfsm.cl>
  To: olpc@listas.inf.utfsm.cl

  Result: OK

I didn't add a From:, per manpage it is assumed to be GIT_COMMITER_IDENT
(from 'git-var -l' this is 'Horst H. von Brand <vonbrand@inf.utfsm.cl> 1167226309 -0300').
Note particularly the "Emails will be sent from:" line!

The resulting message is formed right (it has a From: header), so this is
just a UI glitch.

The same output from 1.5.0rc0 here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
