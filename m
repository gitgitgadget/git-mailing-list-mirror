From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4.skipSubmitEdit
Date: Fri, 9 Sep 2011 10:05:09 +0000 (UTC)
Message-ID: <loom.20110909T115356-849@post.gmane.org>
References: <1315514452.10046.0.camel@uncle-pecos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 12:05:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1xxr-0001YN-W8
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 12:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933253Ab1IIKF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 06:05:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:41060 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933080Ab1IIKFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 06:05:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R1xxc-0001Qu-IN
	for git@vger.kernel.org; Fri, 09 Sep 2011 12:05:24 +0200
Received: from 111.216.54.77.rev.vodafone.pt ([77.54.216.111])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 12:05:24 +0200
Received: from vitor.hda by 111.216.54.77.rev.vodafone.pt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 12:05:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 77.54.216.111 (Mozilla/5.0 (Linux; U; Android 3.2; en-gb; Transformer TF101 Build/HTJ85B) AppleWebKit/534.13 (KHTML, like Gecko) Version/4.0 Safari/534.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181041>

L. A. Linden Levy <alevy <at> mobitv.com> writes:

> 
> Hi All,
> 
> I have been using git-p4 for a while and it has allowed me to completely
> change the way I develop and still be able to use perforce which my
> company has for its main VCS. One thing that was driving me nuts was
> that "git p4 submit" cycles through all of my individual commits and
> asks me if I want to change them. The way I develop I often am checking
> in 20 to 50 different small commits each with a descriptive git comment.
> I felt like I was doing double duty by having emacs open on every commit
> into perforce. So I modified git-p4 to have an option to skip the
> editor. This option coupled with git-p4.skipSubmitEditCheck will make
> the submission non-interactive for "git p4 submit".

Hi Loren,

This option was already included in a recent commit. The name that was
used is "skipSubmitEditCheck". Please make sure you are using the most
recent version of the script.

But don't let this discourage you from submitting patches. Just makesure
you clone git's repository and apply your patch over "maint" or "master"
branches. For more details on how to submit patches you can read
Documentation/SubmittingPatches.

Vitor
