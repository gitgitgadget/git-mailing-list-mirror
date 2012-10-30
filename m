From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: change symlink
Date: Tue, 30 Oct 2012 21:42:44 +0000
Message-ID: <CAH_OBifch3uuXYHQ1R9vS6xFu8LuY3mUfiPsHcs3F=HMvnBzyg@mail.gmail.com>
References: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
 <m2mwz3odys.fsf@igel.home> <CAH_OBidWxkhG3o4C4OPP4OxyQQfw_fF_h4C9KR9AnoOZ27=9TQ@mail.gmail.com>
 <m2fw4vod81.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:43:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJam-0000YC-7E
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934776Ab2J3VnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:43:07 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:53313 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934759Ab2J3VnG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:43:06 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so588257lag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UdfyLt0IKh1GJQjCTjivggP1QTOubSDiGtL928S1DoQ=;
        b=jFiKmbn4GTY3d9q7Z20Ofvzfqm68uwd3hXbkG217ehj2eTdsmEcmlXDwzdn9KnH/3y
         jdeJ2lIg+L5MXOhhMPo9GdI4oDeHen5RfeYMogE1e2djw5PiEc7+pfBQZDYuelMwwvSd
         sgU208rpzEOgLBEVF9Ya7mikOFc95TuEjM6d5V3CwcC8iuk5cGzzOo8S2WG+LxdR83Tf
         W4RfMGkF2Q5AqQ1EfLzMwEGhW+2bNb01WHRccO5F2XVonOkmOMW64A7KF6WESrSf5RTp
         HITzuAk+CqW3PQKC5uUXtk0KCMUjtu5S7uYQE70Os8VJiHPCBF9cII/X6e6shti9WNYM
         JTVA==
Received: by 10.112.37.138 with SMTP id y10mr2476430lbj.121.1351633384683;
 Tue, 30 Oct 2012 14:43:04 -0700 (PDT)
Received: by 10.114.63.42 with HTTP; Tue, 30 Oct 2012 14:42:44 -0700 (PDT)
In-Reply-To: <m2fw4vod81.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208750>

On Tue, Oct 30, 2012 at 9:35 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> shawn wilson <ag4ve.us@gmail.com> writes:
>
>> but should t2 be reported as 'deleted'?
>
> Sure, that's what you did.
>

if i do the same to a file (same repo):

touch test2
git add test2
git commit test2 -m "test2"

rm test
ln -s test2 test

git status

# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       deleted:    t2
#       typechange: test
#
no changes added to commit (use "git add" and/or "git commit -a")


why is this different?
