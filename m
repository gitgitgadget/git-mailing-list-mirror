From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: git push should automatically push to remote tracking branch
Date: Mon, 19 Oct 2009 01:11:21 +0200
Message-ID: <1B59440B-5929-4AB9-82C7-05188DC4F959@dbservice.com>
References: <ee22b09e0910181320j15a273e8vc510801c890b93a9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mohit Aron <mohit.aron@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:11:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzeur-0007qn-6i
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755505AbZJRXLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 19:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754231AbZJRXLr
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:11:47 -0400
Received: from office.neopsis.com ([78.46.209.98]:58844 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbZJRXLq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 19:11:46 -0400
Received: from [192.168.0.248] ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com;
	Mon, 19 Oct 2009 01:11:47 +0200
In-Reply-To: <ee22b09e0910181320j15a273e8vc510801c890b93a9@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130620>


On Oct 18, 2009, at 10:20 PM, Mohit Aron wrote:

> Hello,
>
> I've been using git for around a year now and I'm continuing to find
> the 'git push' API rather cumbersome. My workflow is as follows. I
> typically have a local branch track a remote branch and want to pull
> and push changes back and forth. The names of the local and remote
> branches are different. Even so, while 'git pull' is enough to pull
> changes, 'git push' is not. Instead, the pull requires a full refspec
> to be specified which gets real cumbersome and error prone.
>
> Say my local branch name is foo and it is tracking a remote release
> branch of a product. Say the remote's name is origin and corresponding
> branch there is 6.1. 'git pull' nicely fetches and merges changes
> submitted by others in the remote branch to my branch foo. However, to
> do a push, I need to call:
>
>       git push origin HEAD:6.1
>
> Since my local branch has been setup to track the remote branch, I
> shouldn't have to specify all this in the 'git push' command. It'll be
> great if 'git push' were to support a variant that automatically
> allows pushing to the remotely tracked branch. This is the typical
> workflow with other version control systems too.
>
> If anyone knows a simpler alternative I can use in Git, please let me
> know. Otherwise, it'll be great if such a feature could be added to
> Git in the future.

$ git config push.default tracking

tom
