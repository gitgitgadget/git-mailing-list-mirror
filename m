From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 10:46:38 -0400
Message-ID: <F47212AE-B31D-4025-9859-6794E7405DF2@silverinsanity.com>
References: <4624CD58.90103@gmail.com> <81b0412b0704170721i2b64999aqbd0d7489074454d6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rene Herman" <rene.herman@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 16:46:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdoxL-0001Vq-Vt
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 16:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXDQOqo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 10:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbXDQOqo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 10:46:44 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56433 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030501AbXDQOqn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 10:46:43 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B586B1FFC022;
	Tue, 17 Apr 2007 14:46:42 +0000 (UTC)
In-Reply-To: <81b0412b0704170721i2b64999aqbd0d7489074454d6@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44775>


On Apr 17, 2007, at 10:21 AM, Alex Riesen wrote:

> Kind of. It can be done with git-read-tree. I.e.:
>
>  $ git-read-tree --index-output=.git/tmp-index <branch-name> && \
>     mv tmp-index .git/index && \
>     git update-ref HEAD <branch-name>

This does not appear to do what you think it will.  git update-ref  
will write the SHA1 of <branch-name> into the current HEAD, not  
switch HEAD to a new branch.

However, the first two lines will correctly update the index to the  
new head which is probably a good idea.

~~ Brian
