From: David Greaves <david@dgreaves.com>
Subject: Re: Correcting timestamps when importing archives to git
Date: Tue, 26 Feb 2008 12:55:07 +0000
Message-ID: <47C40C2B.8040003@dgreaves.com>
References: <47C3FBC4.4030206@dgreaves.com> <alpine.LSU.1.00.0802261215171.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 13:56:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTzLn-0003gN-Ex
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 13:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYBZMz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 07:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbYBZMz0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 07:55:26 -0500
Received: from mx1.ukfsn.org ([77.75.108.10]:50938 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751453AbYBZMz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 07:55:26 -0500
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id E73D7DECE4;
	Tue, 26 Feb 2008 12:57:18 +0000 (GMT)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id GxLbUw0f2k23; Tue, 26 Feb 2008 12:44:04 +0000 (GMT)
Received: from elm.dgreaves.com (i-83-67-36-194.freedom2surf.net [83.67.36.194])
	by mail.ukfsn.org (Postfix) with ESMTP id BDEC8DECAB;
	Tue, 26 Feb 2008 12:57:18 +0000 (GMT)
Received: from ash.dgreaves.com ([10.0.0.90])
	by elm.dgreaves.com with esmtp (Exim 4.62)
	(envelope-from <david@dgreaves.com>)
	id 1JTzKu-0007Dh-9R; Tue, 26 Feb 2008 12:55:08 +0000
User-Agent: Mozilla-Thunderbird 2.0.0.6 (X11/20071009)
In-Reply-To: <alpine.LSU.1.00.0802261215171.17164@racer.site>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75134>

Johannes Schindelin wrote:
> 
> Wow.  That is sure one of the most complicated ways to go about it.
Depends. after checking the git pages for time arguments then spoofing the time
is (was!) the most obvious way to do it IMO :)
Thereafter it took a few seconds to google faketime, download and implement.

> IMO GIT_AUTHOR_DATE and GIT_COMMITTER_DATE (mentioned in 
> Documentation/git.txt, and described in Documentation/git-commit-tree.txt) 
> would have been the tools to use.

Indeed - I forgot all about those - and I wrote the first versions of those
files IIRC!

The variables are not written about much more and didn't show up when I was
googling for managing git timestamps/dates. Maybe they will now.

And - the whole point of the email was for the archives - so thanks for the
reply and the reminder/better suggestion.

David
