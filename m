From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Wed, 11 Nov 2009 15:08:40 +0100
Message-ID: <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
References: <1257945756.26362.79.camel@heerbeest>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Nov 11 15:09:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Dsu-0004Oz-O9
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 15:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbZKKOJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 09:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbZKKOJG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 09:09:06 -0500
Received: from office.neopsis.com ([78.46.209.98]:46558 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbZKKOJG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 09:09:06 -0500
Received: from [10.9.5.55] ([147.88.200.144])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Wed, 11 Nov 2009 15:09:05 +0100
In-Reply-To: <1257945756.26362.79.camel@heerbeest>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132655>


On Nov 11, 2009, at 2:22 PM, Jan Nieuwenhuizen wrote:

> Hi,
>
> git pull -r*) URL says:
>
>    If you often merge with the same branch, you may want to
>    configure the following variables in your configuration
>    file:
>
>        branch.master.remote = <nickname>
>        branch.master.merge = <remote-ref>
>        remote.<nickname>.url = <url>
>        remote.<nickname>.fetch = <refspec>

These are meant to be used with git-config(1):
git config branch.master.remote <nickname>

Or if you want to manually edit the config file, add this:

[branch "master"]
     remote = <nickname>

etc.

>
> and after cut-and-pasting that into .git/config, replacing
> <foo> with values, I get
>
>    $ git pull -r http://github.com/../../master
>    fatal: bad config file line 17 in .git/config
>
> where line 17 is [without any indentation]
>
>    branch.master.remote = eddy
>
> This is with git version version 1.6.3.3
>
> Greetings,
> Jan.  -- who just finds out the uninstall target is missing?!?
> 	 See attached.

Next time please send patches inline, it's easier to review them that  
way.

>
> *) I've been wondering why GIT lacks a "update", ie
>   pull-without-merge command.  You almost never want
>   to git pull /without/ -r?

As 'pull == fetch + merge' (pull -r == fetch + rebase), pull without  
merge would be fetch.

tom
