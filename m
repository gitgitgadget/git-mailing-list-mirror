From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Folding commits together
Date: Wed, 22 Sep 2010 13:13:03 +0200
Message-ID: <vpqsk12rpz4.fsf@bauges.imag.fr>
References: <loom.20100922T123419-101@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Wed Sep 22 13:17:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyNK6-00013U-Ix
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 13:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516Ab0IVLRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 07:17:08 -0400
Received: from imag.imag.fr ([129.88.30.1]:64237 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab0IVLRH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 07:17:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8MBD3XR000632
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Sep 2010 13:13:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OyNG3-0005ak-Im; Wed, 22 Sep 2010 13:13:03 +0200
In-Reply-To: <loom.20100922T123419-101@post.gmane.org> (Maaartin's message of "Wed\, 22 Sep 2010 10\:51\:43 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 22 Sep 2010 13:13:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156797>

Maaartin <grajcar1@seznam.cz> writes:

> I've made a couple of trivial commits I'd like to fold into a single commit now. 
> In the manpage of git-rebase I saw a recipe how to do it using rebase -i and it 
> seemed quite trivial, but it doesn't work for me. I'm in a clean state on branch 
> master and want fold the last 3 commits into one - this is probably the most 
> trivial use case. Whatever I try I get an empty .git/rebase-merge/git-rebase-
> todo, so I can't get to the point of using <<If you want to fold two or more 
> commits into one, replace the command "pick" for the second and subsequent 
> commits with "squash" or "fixup".>>

Which exact command did you type? Something like this should do it:

git rebase -i HEAD~3

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
