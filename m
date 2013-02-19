From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Can git restrict source files ?
Date: Tue, 19 Feb 2013 17:17:20 +0100
Message-ID: <vpq4nh8p9bj.fsf@grenoble-inp.fr>
References: <DE551AEA-5C7D-4A2D-8AB4-33195EF351F8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Juan Pablo <juanpablo8517@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:18:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ptE-0007dv-JT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 17:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406Ab3BSQRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 11:17:34 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36033 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758557Ab3BSQRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 11:17:32 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1JGHI73016231
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 19 Feb 2013 17:17:18 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U7pse-0005rf-Hi; Tue, 19 Feb 2013 17:17:20 +0100
In-Reply-To: <DE551AEA-5C7D-4A2D-8AB4-33195EF351F8@gmail.com> (Juan Pablo's
	message of "Tue, 19 Feb 2013 11:06:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 19 Feb 2013 17:17:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1JGHI73016231
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361895447.71084@oNDxcDkLBDGqJrstRBXnzA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216628>

Juan Pablo <juanpablo8517@gmail.com> writes:

> Hi, 
>
> I have a question, can i control the access to specific files or
> folders ?? I need that some developers can't see some source files,
> thank you very much for your time

No, you can't. You can use e.g. gitolite to set up access control for a
branch, but Git needs access to the complete tree.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
