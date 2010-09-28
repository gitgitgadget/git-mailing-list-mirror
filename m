From: Eric Raible <raible@nextest.com>
Subject: Re: Re: Qn about git pull and git fetch
Date: Tue, 28 Sep 2010 12:51:23 -0700
Message-ID: <4CA2473B.2040600@nextest.com>
References: <AANLkTi=-UU8X-7h8c4=UENRwNe+G2xGy54YhvWPnnY7y@mail.gmail.com> <9732E43E-124D-4145-A289-2E78F2277ACE@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: suvayu ali <fatkasuvayu+linux@gmail.com>, <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 21:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0gD4-0002GJ-7v
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 21:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285Ab0I1TvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 15:51:25 -0400
Received: from pops.nextest.com ([12.96.234.114]:17066 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755101Ab0I1TvY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 15:51:24 -0400
Received: from [131.101.151.88] (131.101.151.88) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Tue, 28 Sep 2010 12:51:23 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b2 Thunderbird/3.1.4
In-Reply-To: <9732E43E-124D-4145-A289-2E78F2277ACE@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157462>

On 11:59 AM, Brian Gernhardt wrote:
> 

> Your branches should be set to track automatically but if they didn't for
> some reason and are using v1.7.0 or newer, you can:
> 
> $ git branch --set-upstream master origin/next
> Branch master set up to track remote branch next from origin.
> $ git pull
> 
> If you're using git prior to v1.7.0, you can instead:
> 
> $ git config branch.master.remote origin
> $ git config branch.master.merge refs/heads/master
> $ git pull

Seems to me that to be equivalent, the first should be:

	git branch --set-upstream master origin/master

or the second should be:

	git config branch.master.merge refs/heads/next

Eh?
