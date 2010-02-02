From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: What does git reset do?
Date: Tue, 02 Feb 2010 00:37:10 -0800
Message-ID: <op.u7hrj8vb4oyyg1@localhost.localdomain>
References: <ron1-A2A2DE.23475601022010@news.gmane.org>
 <op.u7hpv8nd4oyyg1@localhost.localdomain>
 <ron1-2B8474.00242602022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: "Ron Garret" <ron1@flownet.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 09:37:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcEGM-0002AJ-AK
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 09:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab0BBIh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 03:37:29 -0500
Received: from spider.alvarezp.com ([66.150.225.106]:49562 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0BBIh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 03:37:28 -0500
Received: from localhost.localdomain (201.160.167.202.cable.dyn.cableonline.com.mx [201.160.167.202])
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id o128bGEj009561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 2 Feb 2010 00:37:18 -0800
In-Reply-To: <ron1-2B8474.00242602022010@news.gmane.org>
User-Agent: Opera Mail/10.10 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138702>

On Tue, 02 Feb 2010 00:24:26 -0800, Ron Garret <ron1@flownet.com> wrote:

> In article <op.u7hpv8nd4oyyg1@localhost.localdomain>,
>  "Octavio Alvarez" <alvarezp@alvarezp.ods.org> wrote:
>
>> > So... what does git reset do?
>>
>> Sets the current head (and branch, if not detached) to the specified
>> commit...
>
> Ah.  It's the "and branch" part that I was missing.  Thanks!
>
> Hm... maybe "detached head" is not as inappropriate a term as I first
> thought.  When you checkout a branch, HEAD really is "attached" to the
> branch insofar as the branch head gets "dragged along" on commits and
> resets.  (Have I got that right?)

99% right. I'm just not sure if there is such thing as "branch head".

You may compare the branch with a "moving tag", in which case the branch  
is just a pointer, so "branch head" would be redundant, and besides "HEAD"  
is an already used term. So you may say simply "branch" instead.

But it's easy intuitive to compare it with a bunch of related commits,  
each parent of another. And gitk also has a line that says "branch: _____,  
______, ______" for each commit.

In any case, it's just a matter of getting the terms to match the  
developers'.


-- 
--
Octavio.
