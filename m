From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Thu, 20 May 2010 12:37:39 +0100
Message-ID: <ht36u4$lo4$1@dough.gmane.org>
References: <ht3194$1vc$1@dough.gmane.org> <4BF50A92.3060209@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 13:37:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF44a-0001Pv-Tg
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 13:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564Ab0ETLhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 07:37:52 -0400
Received: from lo.gmane.org ([80.91.229.12]:48601 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab0ETLhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 07:37:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OF44R-0001LP-Vd
	for git@vger.kernel.org; Thu, 20 May 2010 13:37:47 +0200
Received: from 194.70.53.228 ([194.70.53.228])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 13:37:47 +0200
Received: from andyparkins by 194.70.53.228 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 13:37:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 194.70.53.228
User-Agent: KNode/4.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147383>

Stefan Naewe wrote:

>> circumstances it is exactly right; however, I'd like to be able to turn
>> off dirty
>> detection in submodules.  Is this already possible, and I've just missed
>> the configuration option?
> 
> Maybe:
> 
>    git config status.submodulesummary false

Hey! Thanks for the reply. Exactly the right option... except it doesn't work :-(

$ git --version
git version 1.7.1
$ git config status.submodulesummary
false
$ git status -uno
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#   (commit or discard the untracked or modified content in submodules)
#
#       modified:   ffmpeg (modified content)
#
no changes added to commit (use "git add" and/or "git commit -a")




Andy

-- 
Dr Andy Parkins
andyparkins@gmail.com
