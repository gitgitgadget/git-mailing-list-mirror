From: Eric Raible <raible@nextest.com>
Subject: Re: Re: How do I get a list of all unmerged files?
Date: Wed, 27 Oct 2010 10:00:18 -0700
Message-ID: <4CC85AA2.1050406@nextest.com>
References: <20101026143245.11433.qmail@science.horizon.com> <AANLkTi=JipA6P72hY5_FSvohCruf8hqsJc8Rh53FzAzT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: George Spelvin <linux@horizon.com>, <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 19:00:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB9MU-0004et-DA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 19:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299Ab0J0RAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 13:00:23 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:38375 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752294Ab0J0RAV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 13:00:21 -0400
Received: from [131.101.151.88] (131.101.151.88) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Wed, 27 Oct 2010 10:00:19 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b2 Thunderbird/3.1.4
In-Reply-To: <AANLkTi=JipA6P72hY5_FSvohCruf8hqsJc8Rh53FzAzT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160101>

On 11:59 AM, Jay Soffian wrote:
> $ git help unmerged
> `git unmerged' is aliased to `!git ls-files --unmerged | cut -f2 | uniq'
> 
> If there's a better way to do it, I don't know what it is.

How about: git diff --name-only | uniq
