From: Eric Raible <raible@nextest.com>
Subject: Re: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 10:04:52 -0700
Message-ID: <4CD2E7B4.3000908@nextest.com>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <kevin@sb.org>, <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 18:05:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE3FD-00038V-V4
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 18:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab0KDRE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 13:04:56 -0400
Received: from pops.nextest.com ([12.96.234.114]:39408 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751966Ab0KDREy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 13:04:54 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Thu, 4 Nov 2010 10:04:52 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <20101104112530.5c0e444a@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160732>

On 11:59 AM, Yann Dirson wrote:
>>> I'm sorry if I'm missing something, but how is this different from
>>> "edit"?
>>
>> Edit cherry-picks a commit, then exits to the shell. I needed to exit
>> to the shell without cherry-picking a commit.
> 
> Indeed, before "x false" was available, I had found out that "edit"
> without an argument fails with a harmless error and indeed achieves that
> "pause" mechanism which was really missing.
> 
> What about just fixing this so we can use "edit" ?  Do we really need
> another command here ?

FWIW: +1 for edit.
