From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [ANNOUNCE] codeBeamer MR - Easy ACL for Git
Date: Fri, 20 Nov 2009 10:26:32 +0530
Message-ID: <2e24e5b90911192056t706071ble163a53741017ef@mail.gmail.com>
References: <4B03B153.1020302@intland.com>
	 <20091118120936.GL17748@machine.or.cz> <4B054D0A.5030802@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Intland Software <marketing@intland.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 05:56:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBLXz-0007b5-NH
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 05:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbZKTE41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 23:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754504AbZKTE40
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 23:56:26 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:39877 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbZKTE40 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 23:56:26 -0500
Received: by pzk1 with SMTP id 1so2145855pzk.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 20:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SYCGvRc+KVglNVG9ov/CNgwNd7LXwjSSltBcfVFqzQA=;
        b=a60Hzet/Nxw994JeFFN/9m1DLFIzYYZfZA3IM7SwhSPHT7VK0aUK5Fjqd8q9L1shnp
         3Z6+FEFUC7We0AyI6UN2L7wEaGEGISCtNy19LXVJygLUaUXq4VnID+7TMuVVgCUuUn8A
         gDs7VBkewWzlR9M5U6ikdh5WQKTMQchRK3FVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DauJSdxdkBlrpkDdBu71VTQajKT9iKfmzmdT8ZIu3XXcHqCm7A0kb75mSI8pLO4Sj+
         nBGcr/xegZJXv+daXEjvyHqzI0P4Hd+oVKtWADoIk0qH6bWGm5dIPPA5P5YASX2fCuhd
         AX9SneTLBi8tVy3sy3xHERD7ODj4n7n1iJbdc=
Received: by 10.115.67.10 with SMTP id u10mr1274402wak.203.1258692992477; Thu, 
	19 Nov 2009 20:56:32 -0800 (PST)
In-Reply-To: <4B054D0A.5030802@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133305>

On Thu, Nov 19, 2009 at 7:20 PM, Intland Software <marketing@intland.com> wrote:
> Petr Baudis wrote:
>>
>> I think a lot of people wonder now, how does this compare to existing
>> solutions; from your announcement I thought it's something like
>> Gitosis/Gitolite, but in fact it seems more similar to Gitorious or
>> GitHub (if it was publicly available, of course); perhaps it would be
>
> All right, some quick comparisons with codeBeamer Managed Repository (MR).
>
> * MR against Gitosis

I think you meant "versus" :-)

> In terms of access control, MR has the concept of "role", and it makes our
> security model more fine grained. Permissions can be set by role. One user
> account can have multiple roles. Roles are project-dependent. When you add a
> group to a project, you can assign multiple roles to the group (which is
> equivalent with assigning those roles to each group member one by one).
> On the other hand, MR has a much broader scope than Gitosis. MR helps you to
> manage your repos, to track your tasks/bugs/issues, to follow commit
> activities, to browse repos in the web, can be extended using its APIs, etc.
> (And you don't have to install and maintain Git extensions for this.)

> * MR against Gitolite
> Pretty much the same applies here as well.

Conceptually, gitolite can do the roles stuff you mentioned,
if I understood it correctly.  Of course, gitolite's access
config is in plain text.

The web-based control, issue tracking, etc., are all on a
different plane from what gitosis/gitolite aim to be.  So
much so that I might even disagree with Pasky on the need to
mention these two products in your website.  Here's one
perspective (in round figures):

gitolite:   1600 lines of shell+perl, 1600 lines of doc
gitosis:    3300 lines of python
MR:         150 MB binary download

I don't honestly see any way to even *begin* to compare :-)

You should stick to gitorious, github, and -- here's a new
one for you -- indefero.

-- 
Sitaram
