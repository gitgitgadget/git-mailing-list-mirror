From: Gary Yang <garyyang6@yahoo.com>
Subject: How to update the tag to Git server?
Date: Wed, 3 Dec 2008 18:16:32 -0800 (PST)
Message-ID: <84437.20577.qm@web37903.mail.mud.yahoo.com>
Reply-To: garyyang6@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 04 03:17:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L83mq-000607-QP
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 03:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbYLDCQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 21:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYLDCQe
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 21:16:34 -0500
Received: from web37903.mail.mud.yahoo.com ([209.191.91.165]:41961 "HELO
	web37903.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750942AbYLDCQe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 21:16:34 -0500
Received: (qmail 20758 invoked by uid 60001); 4 Dec 2008 02:16:33 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=E/10U3kpxWlsrH+VJ1jfoMCivhwmd4X5u5njo2rQ1LeNUCn7Cvu9wrNcAP6iYxmfHdsZvvFcOggTv+Rj0oRtLnImT5b+eoZUSaxg5YjvWwwl2mCs2qgpPkr+UaOlS8XdY4N7LqD/DYWkoGZyuMnTtYhQoGh83HM+HsEClfl3y/c=;
X-YMail-OSG: uNX94E8VM1nBX95mL2aFw5A8KBXMfwIDE87yxe63lvBjOVmU5sjS8hhcMbTWYotMAfQsVay_bgU_d_08MnSOSYgzxrLM9DrDFkSe5AHJ30H3323YDJwFlmSM5VdWOeCFW8We38MFxAgpJjsKiUtPGMlBsqtU1ledoHijnK5KccxzVI6ij1BJOF0Ob7Zp
Received: from [76.195.33.70] by web37903.mail.mud.yahoo.com via HTTP; Wed, 03 Dec 2008 18:16:32 PST
X-Mailer: YahooMailWebService/0.7.260.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102322>


I pushed code from my local repository to Git Server.
git push git.company.com:/pub/git/training.git

I, then tagged my local repository.
git tag -u gyang@company.com RELEASE_2

I want to update the Git server so that I can have the tag at my Git server, I did:
git push git.company.com:/pub/git/training.git
Everything up-to-date

I got "Everything up-to-date". Same story for the command with -f.
git push -f svdcgit01.amcc.com:/pub/git/training.git

git tag -l
RELEASE_2

>From my git server, git.company.com, I cannot see the tag at summary. I need to have the tag, RELEASE_2 at git.company.com. Can someone tell me how to do it?

Thanks.







      
