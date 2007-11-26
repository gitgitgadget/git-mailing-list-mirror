From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 13:39:42 +0100
Message-ID: <B14406EA-E1E8-4737-8FCE-853A3BBBE34C@lrde.epita.fr>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com> <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 13:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwdFx-0003n1-06
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 13:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbXKZMjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 07:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbXKZMju
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 07:39:50 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:51586 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbXKZMju (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 07:39:50 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IwdFd-0000gW-6Z; Mon, 26 Nov 2007 13:39:49 +0100
In-Reply-To: <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66066>

On Nov 26, 2007, at 1:34 PM, Wincent Colaiuta wrote:

> How about something like this? It would obviously be nice if we  
> could avoid adding another option to builtin-revert; perhaps when/ 
> if git-rebase becomes a builtin we can avoid that. The other  
> alternative, and probably one I like I bit more, would be to auto- 
> detect that a rebase is in progress by looking inside the GIT_DIR,  
> although that would also alter the behaviour of manual invocations  
> of git-revert and git-cherry-pick during an interactive rebase (do  
> people actually do that?). What do you think?


Hmm yeah, I agree that it's a little bit of a dirty workaround but,  
as you pointed out, until rebase is builtinified, this looks like the  
best/easiest alternative.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
