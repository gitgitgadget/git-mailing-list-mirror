From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Setting up a Git server (+ gitweb) with .htaccess files HOWTO
Date: Mon, 13 Feb 2012 17:34:43 +0100
Message-ID: <vpqbop266ak.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 17:34:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwyrb-0005Ot-So
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 17:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138Ab2BMQer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 11:34:47 -0500
Received: from mx1.imag.fr ([129.88.30.5]:50302 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325Ab2BMQeq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 11:34:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q1DGVkKJ007912
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 13 Feb 2012 17:31:46 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RwyrU-00088v-4Y; Mon, 13 Feb 2012 17:34:44 +0100
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 13 Feb 2012 17:31:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1DGVkKJ007912
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1329755507.83683@OZOfC71P39DZ1w9CJKTcug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190637>

Hi,

I've set up a Git server on a machine on which I have a webspace,
permission to run CGI scripts, but no shell or root access. Good news:
it worked :-).

I've documented the process here in case anyone's interested:

  http://www-verimag.imag.fr/~moy/?Host-a-Git-repository-over-HTTP-S

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
