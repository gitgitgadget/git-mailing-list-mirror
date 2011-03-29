From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: suggestion: git status = restored
Date: Tue, 29 Mar 2011 20:56:01 +0200
Message-ID: <vpqr59piwn2.fsf@bauges.imag.fr>
References: <imil67$oec$1@dough.gmane.org>
	<20110329145818.GC10771@sigill.intra.peff.net>
	<4D92179D.6050102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Neal Kreitzinger <neal@rsss.com>
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:56:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4e5O-0004AQ-T7
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab1C2S4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 14:56:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54749 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab1C2S4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:56:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p2TItxUP007298
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Mar 2011 20:55:59 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q4e5B-0002GC-NY; Tue, 29 Mar 2011 20:56:01 +0200
In-Reply-To: <4D92179D.6050102@gmail.com> (Neal Kreitzinger's message of "Tue,
	29 Mar 2011 12:32:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Mar 2011 20:55:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p2TItxUP007298
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1302029762.15168@7qeNWarqzLsmqDWWXcVIiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170305>

Neal Kreitzinger <nkreitzinger@gmail.com> writes:

> I see your point about the current worktree/index/HEAD.  I'm not a git
> developer, but my idea is based on the concept that the sha-1 of the
> content already exists in the object store regardless of its path(s).

That wouldn't work: the blob is added to the object store at the time of
"git add", so at the time of "git status", it has to exist in the object
store, whether it's "restored" or "totally new".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
