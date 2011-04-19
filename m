From: Andreas Ericsson <ae@op5.se>
Subject: Re: rebasing branch with reverted patches
Date: Tue, 19 Apr 2011 11:15:38 +0200
Message-ID: <4DAD52BA.5000206@op5.se>
References: <BANLkTim5mf6okFN8V5V+B=Ns1JORD47a5A@mail.gmail.com>	<4DAD4B0F.9030908@drmicha.warpmail.net> <BANLkTimbSes-B8zK2a2t1Jp1v+29HdNvqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 11:15:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC72C-0002VI-J9
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 11:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab1DSJPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 05:15:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53145 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab1DSJPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 05:15:43 -0400
Received: by bwz15 with SMTP id 15so4363219bwz.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 02:15:41 -0700 (PDT)
Received: by 10.204.126.144 with SMTP id c16mr4854886bks.6.1303204541199;
        Tue, 19 Apr 2011 02:15:41 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id t1sm3704311bkx.7.2011.04.19.02.15.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 02:15:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <BANLkTimbSes-B8zK2a2t1Jp1v+29HdNvqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171785>

On 04/19/2011 11:09 AM, Francis Moreau wrote:
> On Tue, Apr 19, 2011 at 10:42 AM, Michael J Gruber
> <git@drmicha.warpmail.net>  wrote:
>> Francis Moreau venit, vidit, dixit 19.04.2011 09:32:
>>> Hello,
>>>
>>> I'm wondering if it would be a good idea for git rebase to allow not
>>> rebasing reverted patch which are part of the rebased branch.
>>>
>>> For example I'm currently rebasing my branch 'devel' onto master. This
>>> branch have several commits and specially one called A and another one
>>> called A' which reverts A.
>>>
>>> When rebasing 'devel' branch, rebase could try to drop both A and A'.
>>>
>>> What do you think ?
>>>
>>> BTW is there a way to do this currently ?
>>
>> You can do this with "rebase -i" by removing A and A' from the commit
>> list (or squashing them or dealing with them in whatever way you like).
> 
> Of course, but my point was to make this automatically...
> 

That would be akin to removing in-code comments of why it's a bad idea
to implement a particular solution in a particular way, and it also
removes the capability of reverting the revert (ie, re-doing the change)
at a later time when stability can be sacrificed temporarily.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
