From: "Octavio Alvarez" <alvarezp@alvarezp.ods.org>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 12:32:59 -0800
Message-ID: <op.u7a909hf4oyyg1@alvarezp-ws>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 8bit
To: Ron1 <ron1@flownet.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 21:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Naxbm-0005po-KL
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab0A2UiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 15:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493Ab0A2UiV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:38:21 -0500
Received: from spider.alvarezp.com ([66.150.225.106]:41220 "EHLO
	spider.alvarezp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786Ab0A2UiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:38:21 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2010 15:38:20 EST
Received: from alvarezp-ws (host-193-99-in-prt.caliente.com.mx [201.139.193.99] (may be forged))
	(authenticated bits=0)
	by spider.alvarezp.com (8.13.8/8.13.8/Debian-3) with ESMTP id o0TKX2BQ015698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Jan 2010 12:33:04 -0800
In-Reply-To: <ron1-2E17EF.12204629012010@news.gmane.org>
User-Agent: Opera Mail/10.20 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138351>

On Fri, 29 Jan 2010 12:20:46 -0800, Ron1 <ron1@flownet.com> wrote:

> [ron@mickey]$ git checkout master
> Already on 'master'
> [ron@mickey]$ git checkout master^
> Note: moving to 'master^' which isn't a local branch
> If you want to create a new branch from this checkout, you may do so
> (now or later) by using -b with the checkout command again. Example:
>   git checkout -b <new_branch_name>
> HEAD is now at 7be05e0... test
> [ron@mickey]$ git branch
> * (no branch)
>   master
> [ron@mickey]$
>
> Huh?!?
>
> This is a test repository which has never been pulled from nor pushed to
> anywhere.  So how is it possible that I have a non-local branch?

"Is a non-local branch" is not the same as "is not a local branch".

Think "branches" as tags that advance when you commit over them.

If you do gitk --all, only those commits with a green tag are
"branches".

It means that if you switch to master^ and commit, your commit will
be applied but not tracked (since there is not any branch to advance).

You would need to do git checkout -b 'new_branch', and then commit.
Now, new_branch will advance with your new commit.
