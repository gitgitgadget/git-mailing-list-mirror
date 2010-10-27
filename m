From: Eric Raible <raible@nextest.com>
Subject: Re: Re: Re: How do I get a list of all unmerged files?
Date: Wed, 27 Oct 2010 12:18:36 -0700
Message-ID: <4CC87B0C.8020906@nextest.com>
References: <20101026143245.11433.qmail@science.horizon.com> <AANLkTi=JipA6P72hY5_FSvohCruf8hqsJc8Rh53FzAzT@mail.gmail.com> <4CC85AA2.1050406@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	George Spelvin <linux@horizon.com>, <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 21:18:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBBWF-0007uq-NJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 21:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab0J0TSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 15:18:39 -0400
Received: from smtps.nextest.com ([12.96.234.114]:20940 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755385Ab0J0TSi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 15:18:38 -0400
Received: from [131.101.151.88] (131.101.151.88) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Wed, 27 Oct 2010 12:18:37 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b2 Thunderbird/3.1.4
In-Reply-To: <4CC85AA2.1050406@nextest.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160115>

On 11:59 AM, Eric Raible wrote:
> On 11:59 AM, Jay Soffian wrote:
>> $ git help unmerged
>> `git unmerged' is aliased to `!git ls-files --unmerged | cut -f2 | uniq'
>>
>> If there's a better way to do it, I don't know what it is.
> 
> How about: git diff --name-only | uniq

Or even better: git diff --name-only --diff-filter=U
