From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git rm" is not a valid merge resolution?
Date: Mon, 21 Mar 2011 19:35:38 +0100
Message-ID: <vpqpqpk724l.fsf@bauges.imag.fr>
References: <4D879882.4070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1k0A-0007Xq-1e
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab1CUSil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:38:41 -0400
Received: from imag.imag.fr ([129.88.30.1]:48714 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265Ab1CUSik (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:38:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p2LIZdSq013879
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Mar 2011 19:35:39 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q1jx4-0004ac-Tc; Mon, 21 Mar 2011 19:35:38 +0100
In-Reply-To: <4D879882.4070608@gmail.com> (Piotr Krukowiecki's message of
	"Mon, 21 Mar 2011 19:27:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 21 Mar 2011 19:35:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169638>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> Hi,
>
> git-status shows a hint that says
>     use "git add/rm <file>..." as appropriate to mark resolution
>  
> But if I "git rm file" the file gets deleted. Is this really the 
> appropriate merge resolution?

In most cases, no, but when you have a modify/delete conflict for
example, "git rm" is one of the candidates to resolve the conflict. The
hint gives the general case.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
