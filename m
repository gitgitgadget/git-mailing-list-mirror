From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: how to add files/folder from work-tree
Date: Wed, 20 Jul 2011 15:46:44 +0530
Message-ID: <20110720154644.67974a7f@shiva.selfip.org>
References: <20110719120048.3dd56eb6@shiva.selfip.org>
	<4E2537F8.6000506@gmail.com>
	<20110719133633.0797713d@shiva.selfip.org>
	<4E253C94.7000709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 12:16:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjTpd-0003do-Jq
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 12:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab1GTKQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 06:16:39 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:52087
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750936Ab1GTKQi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 06:16:38 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 0CB321808001;
	Wed, 20 Jul 2011 12:16:35 +0200 (CEST)
In-Reply-To: <4E253C94.7000709@gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177531>

On Tue, 19 Jul 2011 20:13:08 +1200
Chris Packham <judge.packham@gmail.com> wrote:

> Oops managed to drop the Cc for the mailing list from my initial response.
> 
> On 19/07/11 20:06, J. Bakshi wrote:
> > On Tue, 19 Jul 2011 19:53:28 +1200
> > Chris Packham <judge.packham@gmail.com> wrote:
> > 
> >> On 19/07/11 18:30, J. Bakshi wrote:
> >>> Hello,
> >>>
> >>> I am using a git repo which has detached work tree. I like to add the files, folders located at the work tree ( it is a site under htdocs) at the git repo. Is it possible to do it within the work-tree or I need a separate working space from where I need to do all these operation ?
> >>>
> >>> Thanks
> >>>  
> >>> --
> >>
> >> I'm not sure I fully understand your question but what I _think_ you
> >> want to do is specify the path to the repository with the GIT_DIR
> >> environment variable. Like this
> >>
> >>  cd /place/where/files/are
> >>  GIT_DIR=/place/were/repo/is/.git git add <file>
> >>
> > 
> > 
> > I have set a git repo with attached work-tree with hook as below
> > 
> > git -bare init  /home/git/test.git
> > cd /home/git/test.git
> > git config core.worktree /var/www/test
> > 
> > vim /home/git/test.git/hooks/post-receive
> > 
> > #!/bin/sh
> > git checkout -f
> > 
> > Now the /var/www/test has already some files/folder. How can I add those to the repo within from its work-tree ?
> > 
> > Thanks
> 
> I think my initial response is correct. Try the following
> 
>   cd /var/www/test
>   git --git-dir=/home/git/test.git add <files>

But this response as

````
fatal: This operation must be run in a work tree
`````````
