From: Semen Vadishev <semen.vadishev@tmatesoft.com>
Subject: Re: [ANN] SubGit Early Access Program Build #789
Date: Wed, 23 Nov 2011 18:19:32 +0100
Organization: TMate Software
Message-ID: <4ECD2B24.5050802@tmatesoft.com>
References: <4ECBF4EF.7070705@tmatesoft.com> <4ECCB6C6.8040200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jgit-dev <jgit-dev@eclipse.org>,
	EGit developer discussion <egit-dev@eclipse.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 23 18:19:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTGU1-0007G2-Ic
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 18:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab1KWRTh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 12:19:37 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50827 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1KWRTg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 12:19:36 -0500
Received: by bke11 with SMTP id 11so1838643bke.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 09:19:34 -0800 (PST)
Received: by 10.204.154.151 with SMTP id o23mr24867990bkw.62.1322068774815;
        Wed, 23 Nov 2011 09:19:34 -0800 (PST)
Received: from vs.local ([109.80.120.205])
        by mx.google.com with ESMTPS id b2sm10657877fao.1.2011.11.23.09.19.33
        (version=SSLv3 cipher=OTHER);
        Wed, 23 Nov 2011 09:19:33 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4ECCB6C6.8040200@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185856>

Hello Andreas,


> How does it handle merges?
The short answer is

1. git to svn: SubGit sets svn:mergeinfo accordingly to
the history of merged parent(s).

2. git to svn: SubGit checks whether modified svn:mergeinfo includes=20
the history of a certain branch, if so it adds this branch as a merge=20
parent.

=46or more details please refer to
http://subgit.com/documentation/spec/merge.pdf =E2=80=94 it's a part of=
 SubGit
specification related to the merge-tracking stuff.


Semen Vadishev,
TMate Software,
http://subgit.com/ - Two Way Ticket to The Dark Side


On 23 November 2011 10:03, Andreas Ericsson wrote:
> On 11/22/2011 08:15 PM, Semen Vadishev wrote:
>> Hello All,
>>
>> Let me introduce our new project: SubGit (http://subgit.com/).
>>
>> SubGit is a tool for smooth migration from Subversion to Git. As wel=
l as
>> from Git to Subversion. Without git-svn insanity.
>>
>> It works like this:
>>
>> - Install SubGit into your repository on the server side
>>
>> - Let initial translation complete (time depends on the size of repo=
sitory)
>>
>> - SubGit installs hooks into repository, so it translates every svn
>> revision and git commit
>>
>> - Committers may now use either Git or Subversion (or both) with the
>> tools of their choice
>>
> How does it handle merges?
>
