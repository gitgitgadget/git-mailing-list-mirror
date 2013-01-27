From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Behavior of stash apply vs merge
Date: Sun, 27 Jan 2013 20:51:09 +0100 (CET)
Message-ID: <35452020.1815583.1359316269106.JavaMail.root@dewire.com>
References: <7vfw1mwibu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 20:51:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzYGK-0000OE-TD
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 20:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab3A0TvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 14:51:11 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:40493 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab3A0TvK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 14:51:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 879CB82715;
	Sun, 27 Jan 2013 20:51:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DRnAEeNhmiuZ; Sun, 27 Jan 2013 20:51:09 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 2BA5A826F3;
	Sun, 27 Jan 2013 20:51:09 +0100 (CET)
In-Reply-To: <7vfw1mwibu.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214721>



----- Ursprungligt meddelande -----
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > Thanks. Feeling a bit studid now.
> >
> > I was actually thinking about using merge to implement stash apply
> > in JGit. What we have is broken so I tried using merge to implement
> > it and them compared to git merge --no-commit.. FAIL.
> 
> Do you have "cherry-pick"?
>
> In short, "stash apply" is a "cherry-pick" in disguise.

Yes, that's what I did. Thanks for confirming this. One for the working
tree and if that succeeds I do another one to restore the index if requested.

-- robin
