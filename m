From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: rebase -i reword converts to pick on pre-commit non-zero exit
Date: Wed, 01 Feb 2012 15:28:46 -0600
Message-ID: <4F29AE8E.6070109@gmail.com>
References: <jgcaoh$d9q$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 22:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rshjl-0000ex-Dc
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 22:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab2BAV3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 16:29:00 -0500
Received: from plane.gmane.org ([80.91.229.3]:45035 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757470Ab2BAV25 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 16:28:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rshjc-0000ax-BZ
	for git@vger.kernel.org; Wed, 01 Feb 2012 22:28:56 +0100
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 22:28:56 +0100
Received: from nkreitzinger by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 22:28:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.26) Gecko/20120129 Thunderbird/3.1.18
In-Reply-To: <jgcaoh$d9q$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189540>

On 2/1/2012 3:27 PM, Neal Kreitzinger wrote:
> When interactive rebase does the reword command it runs the pre-commit hook
> for that commit (a).  If the pre-commit hook gives a non-zero exit then
> interactive rebase picks commit (a) and continues to the next commit (b) in
> the rebase-to-do-list.  Instead of picking commit (a) when the pre-commit
> hook exits non-zero on the reword command, shouldn't interactive rebase
> learn to edit commit (a) and tell the user that because the pre-commit hook
> exited non-zero they need to either remedy the pre-commit hook violations
> and run git commit --amend or run git commit --amend --no-verify to bypass
> the pre-commit hook?  Otherwise, you have to run another rebase after the
> rejected rewords and edit those commits to accomplish the rewords.
>
git 1.7.1

v/r,
neal
