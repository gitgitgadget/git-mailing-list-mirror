From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Zile as git core editor?
Date: Fri, 26 Apr 2013 10:57:53 +0200
Message-ID: <vpqppxhfz3i.fsf@grenoble-inp.fr>
References: <877gjp91w5.fsf@gmail.com>
	<CALUzUxpZ9=8aVEMBfFUH2hN5ZkwzKVX31J79MVzkCEGRX++LPw@mail.gmail.com>
	<87txmt7km9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Thorsten Jolitz <tjolitz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:58:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVeTp-0004h9-5p
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759526Ab3DZI6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:58:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:47530 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758706Ab3DZI6B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:58:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3Q8vqcd001517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Apr 2013 10:57:52 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UVeTZ-0004zg-M9; Fri, 26 Apr 2013 10:57:53 +0200
In-Reply-To: <87txmt7km9.fsf@gmail.com> (Thorsten Jolitz's message of "Fri, 26
	Apr 2013 10:37:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Apr 2013 10:57:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3Q8vqcd001517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367571475.25489@WPMzgAxGDC0r4Udn/+U6YQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222516>

Thorsten Jolitz <tjolitz@gmail.com> writes:

> BTW - would 'git config --global core.editor zile' or 'git config
> --global core.editor /usr/bin/zile' the right way to set it (both did
> not work)? I can start Zile simply with 'zile' on the command line. 

What do you mean by "did not work"? Does the launching fail? Or is
another editor launched?

Try:

GIT_TRACE=true git commit -a

to see what's going on.

BTW, you may also try "emacs -nw -Q" instead of zile.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
