From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Implicit stashes
Date: Tue, 29 Jun 2010 20:56:32 -0600
Message-ID: <4C2AB260.8020108@workspacewhiz.com>
References: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 04:56:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTnTd-0002c3-9Y
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab0F3C4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 22:56:33 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:41242 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0F3C4c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 22:56:32 -0400
Received: (qmail 27582 invoked by uid 399); 29 Jun 2010 20:56:31 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 29 Jun 2010 20:56:31 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b1 Thunderbird/3.1
In-Reply-To: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149942>

  ----- Original Message -----
From: John Tapsell
Date: 6/29/2010 8:48 PM
>    I was thinking that it would be nice if everything was undoable in
> git.  Currently there are some easily typed by irreversible commands
> that I keep seeing people doing.
>
> For example:
>
> $ git checkout folder
>
> Now all changes that you just worked on are deleted, with no way of recovering.
>
> $ git reset --hard
>
> I know this seems very explicit to delete changes, but I myself have
> done this and accidentally lost changes.  For example, I write a unit
> test and don't commit it in on purpose because I know that it
> currently fails and I want to test it against older versions.  I
> carefully git checkout older versions to find if the unit test fails,
> then in stupidity reset back to origin/master ..
>    Anyway, I think a nice solution is to have a separate stash for
> implicit stashes.  Then irreversible commands would simply stash
> before making the changes.
>    It would also be nice to add a 'git undo' which just undoes whatever
> the last operation was - i.e  unstash or reset to an earlier HEAD@{1}
See this thread: http://kerneltrap.org/mailarchive/git/2009/5/20/2915

Josh
