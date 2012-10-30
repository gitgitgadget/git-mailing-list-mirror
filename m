From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: change symlink
Date: Tue, 30 Oct 2012 21:24:47 +0000
Message-ID: <CAH_OBidWxkhG3o4C4OPP4OxyQQfw_fF_h4C9KR9AnoOZ27=9TQ@mail.gmail.com>
References: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
 <m2mwz3odys.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJJN-0002dr-0t
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164Ab2J3VZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:25:10 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:53406 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab2J3VZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:25:09 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so589590lbo.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 14:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3gX84hK6bJ5Cz9Blrb0SGrUnHWpXvmzkyC2VahZHKlE=;
        b=rxzpcz5bvaGVWpEcS8oz2B0IX1rTRGx9LMkF0hL1Dd1ZQOZeYja4lW1C/9R9hEbIMg
         hFiGD6yZFA8cYfL45XZZNsbzRGPMgS8NURptvdi5xZUjZUbetV1uDwQdS1B3InnY1Ss2
         dnSCFjn++eZ5T+3KgP1FxCgyQfjJtnKqzR897uLBE5L151xjPMPHYj9hImrkFCe5x7+N
         sQSBJF/s/kh7laYAZ4uTioI0/bU9LV06iKcmLQmMPf7AKulSYbRl+rVO7OA2zGqmAOAP
         sZZ56u7Ivbdfe9jT7ny3oLFYe0QhsSm0Da4NYPiHXpPmXy7rNhfRsdsApGuAb/1L5NYC
         F6iw==
Received: by 10.152.103.38 with SMTP id ft6mr31188124lab.40.1351632308066;
 Tue, 30 Oct 2012 14:25:08 -0700 (PDT)
Received: by 10.114.63.42 with HTTP; Tue, 30 Oct 2012 14:24:47 -0700 (PDT)
In-Reply-To: <m2mwz3odys.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208740>

On Tue, Oct 30, 2012 at 9:19 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> shawn wilson <ag4ve.us@gmail.com> writes:

>>  % git status
>> # On branch master
>> # Changes not staged for commit:
>> #   (use "git add/rm <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>> #
>> #       deleted:    t2
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>
> I'd expected t2/one/test be reported as untracked.
>

that's fine - i can do 'git list-files --others' but should t2 be
reported as 'deleted'?
