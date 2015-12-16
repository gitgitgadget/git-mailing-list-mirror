From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: Help debugging git-svn
Date: Wed, 16 Dec 2015 06:36:34 -0600
Message-ID: <CAOc6eta=ZGyWFuBPAYe_4xWSH79RRmPcP5thCHYd8SsKScwW6g@mail.gmail.com>
References: <CAOc6etaOKSN0KyB9v2caiQbaQBEGrHxi3NmFy3aJkFxczGdqHA@mail.gmail.com>
	<20151216074158.GB28518@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 13:36:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9BJv-0003EK-8j
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 13:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933847AbbLPMgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 07:36:35 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34858 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972AbbLPMge (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 07:36:34 -0500
Received: by mail-pf0-f169.google.com with SMTP id v86so11668689pfa.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 04:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G+S+IDEbBx/VKkbsfMzETB5xCuMPC4+RxH+YP9nRhFM=;
        b=ODzSnMVbxVFr0nVoaoVr+Uy9/qzHLuvAAmsA3ji+bqzgT6dGu/qXpPhuQB6k2jte8N
         bAxVDODc/I/KesQOL7qiACn0bzFfwUSU1USSpZBGvrAjHJqZQYgmOZh9/9URWbhqTzce
         pal05fbrA58CVguBJer4wGF/xT4DagoYAf+G0K08HcyZtLS1LR80F6kcXHzMryfCw8fG
         lYXYEUhfqfMUV47j1QXggFKrottPu+E+ZCRila3jeBNwQVRxv7coreyA4lLZhSAp6g4i
         Y2P3LOtdKkHF3y3L1lh+Dzngwu8o4GXt6loPTxjK1MHGduM9asORN6JOUNKgYfbopn0p
         6kpA==
X-Received: by 10.98.16.70 with SMTP id y67mr4890080pfi.77.1450269394191; Wed,
 16 Dec 2015 04:36:34 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Wed, 16 Dec 2015 04:36:34 -0800 (PST)
In-Reply-To: <20151216074158.GB28518@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282556>

On Wed, Dec 16, 2015 at 1:41 AM, Eric Wong <normalperson@yhbt.net> wrote:
>
> Any chance you can reproduce this on a Linux system?
> I do not use non-Free systems and have no debugging experience
> there at all.
>

My wish.... But it's a big resounding "no".

>> With my very flawed knowledge of perl I have seen that the process is
>> getting to Ra.pm around here:
>
> It could also be a bug in the SVN bindings or the port of
> Perl.  Which versions are you running?

I'm working on git for windows 2.6.3. I think I could use cygwin, just
in case (I used it before).

>
>
> I've also been wondering about the motivation of SVN developers to do a
> good job on maintaining their Perl bindings (given git-svn is likely the
> main user of them).
> We've certainly had problems in the past with SVN breaking and
> causing git-svn to segfault around 2011-2012; but it's been a while...
