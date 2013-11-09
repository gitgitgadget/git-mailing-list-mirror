From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-remote-mediawiki: do not remove installed files in "clean" target
Date: Sat, 09 Nov 2013 12:32:47 +0100
Message-ID: <vpqli0xstcw.fsf@anie.imag.fr>
References: <20131109022239.GI10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Thorsten Glaser <t.glaser@tarent.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 12:34:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf6nN-0007tN-DM
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 12:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab3KILdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 06:33:22 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41409 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab3KILdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 06:33:22 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rA9BWraW018967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 9 Nov 2013 12:32:53 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rA9BWlSW031888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 9 Nov 2013 12:32:54 +0100
In-Reply-To: <20131109022239.GI10302@google.com> (Jonathan Nieder's message of
	"Fri, 8 Nov 2013 18:22:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 09 Nov 2013 12:32:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rA9BWraW018967
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1384601575.21186@5sft89WcF5wgQIudzZTE+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237573>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Running "make clean" after a successful "make install" should not
> result in a broken mediawiki remote helper.

Acked-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Ideally, there could be a "make uninstall" removing the installed file.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
