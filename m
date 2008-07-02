From: Paul Gardiner <lists@glidos.net>
Subject: Re: How do I stop git enumerating my working directory
Date: Wed, 02 Jul 2008 15:47:43 +0100
Message-ID: <486B950F.2040801@glidos.net>
References: <486A53CC.4020803@glidos.net> <c9e534200807011002q45ffca7bq8d91cd9b62335796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Glenn Griffin <ggriffin.kernel@gmail.com>, git@vger.kernel.org,
	lists@glidos.net
X-From: git-owner@vger.kernel.org Wed Jul 02 16:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3fP-00072c-3S
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 16:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbYGBOtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 10:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754688AbYGBOtq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 10:49:46 -0400
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:57759
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753330AbYGBOtp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jul 2008 10:49:45 -0400
X-Trace: 105980277/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$PIPEX-ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: lists@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvwAAMUxa0hRVjni/2dsb2JhbAAIsnmBfg
X-IronPort-AV: E=Sophos;i="4.27,737,1204502400"; 
   d="scan'208";a="105980277"
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 02 Jul 2008 15:47:44 +0100
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <c9e534200807011002q45ffca7bq8d91cd9b62335796@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87147>

Glenn Griffin wrote:
> On Tue, Jul 1, 2008 at 8:57 AM, Paul Gardiner <lists@glidos.net> wrote:
>> Hi,
>>
>> I'm a recent convert to git. I've been swapping over my projects
>> from cvs to git. The latest candidate for conversion is the
>> config files for my Linux server. I've been using cvs to record
>> all the config changes, and - mostly-automatically - to setup
>> new servers. Git will do a far better job, I think, but
>> I think I'm going to run into a problem: the root directory
>> of the server will be the working directory. Only relatively
>> few files will be under version control. How do I stop git
>> enumerating the whole drive whenever I do things like git-diff?
> 
> I'm doing a similar thing in my home directory where the vast majority of files
> are not being tracked, but only a select few are.  I've found that git
> automatically handles this case much better than other SCM's like subversion
> because of it's concept of the index.  Most of git's commands wont enumerate
> your directory they will first read the index to see what files it's interested
> in, and then do an lstat on those files to see which if any have changed.
> git-diff in particular should do this to my knowledge.  git-status is one of
> the few commands that will actually enumerate your directory to tell you which
> files are untracked, so long as you use status with care you will probably find
> you don't need to do anything special or even setup
> a .gitignore.
> 
> Like I said, that's my experience your's may vary.

Brilliant! I've now tried it and it does just as you say. I don't
need git-status so it's just fine. Thanks for the advice.

P.
