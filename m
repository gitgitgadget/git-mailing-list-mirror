From: <pacco@tropezien.de>
Subject: Re: How to get rid of doubled branch after renaming a branch in
 svn-repository
Date: Wed, 01 Dec 2010 16:08:12 +0100
Message-ID: <35e60ee2f6d83801d130d53a56a8ae18@tropezien.de>
References: <0a6b49e3cc0b08a717c0d6141073f32d@tropezien.de>
 <4CF6553C.70500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 16:08:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNoI7-0001dk-RE
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0LAPIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:08:14 -0500
Received: from mail.croxxserver.de ([78.46.191.12]:52895 "EHLO
	mail.croxxserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab0LAPIO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:08:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.croxxserver.de (Postfix) with ESMTP id 68D958FC214;
	Wed,  1 Dec 2010 16:08:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv.croxxserver.de
Received: from mail.croxxserver.de ([78.46.191.12])
	by localhost (croxxserver.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AlNNcgANS7wE; Wed,  1 Dec 2010 16:08:12 +0100 (CET)
Received: from webmail.croxxserver.de (mail.croxxserver.de [78.46.191.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pacco@tropezien.de)
	by mail.croxxserver.de (Postfix) with ESMTPSA id D98758FC212;
	Wed,  1 Dec 2010 16:08:12 +0100 (CET)
In-Reply-To: <4CF6553C.70500@drmicha.warpmail.net>
X-Sender: pacco@tropezien.de
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162528>

 Hi Michael,

 On Wed, 01 Dec 2010 15:01:32 +0100, Michael J Gruber 
 <git@drmicha.warpmail.net> wrote:
 [snipped]
> svn records the rename as a copy+delete (it also sets some rename 
> info
> which git-svn seems to ignore). So, git-svn stays on the safe side by
> keeping the branch. Note that deleting the branch would possibly 
> delete
> at least some info since the branch name is not recorded in the 
> commit
> (if you use svn.noMetadata).
>
> You can safely delete the branch if you're sure its head commit is
> contained in some other branch (as will be for an ordinary rename).

 thank you for your explanation. I suspected that this issue might be a 
 mixture of different VCS-philosophy and uncertainty-handling.
 Okay, then I will delete the branch manually. Of course I would have 
 preferred to have an automatic solution, because I got attention on this 
 renaming by accident. I hope renaming a branch will not become a new 
 trend in repository actions.

 pacco
