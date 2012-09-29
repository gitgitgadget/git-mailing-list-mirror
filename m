From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] submodule: make 'show' an alias for 'summary'
Date: Sat, 29 Sep 2012 20:37:33 +0530
Message-ID: <CALkWK0nCahg7165_JuJSj7u0UfYRGZgFjJ6O-o=HCwdsPwU-xg@mail.gmail.com>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com> <50670A94.2070504@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 17:08:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THyeC-00019i-2T
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 17:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738Ab2I2PHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 11:07:55 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:54308 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660Ab2I2PHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 11:07:54 -0400
Received: by qchd3 with SMTP id d3so2656439qch.19
        for <git@vger.kernel.org>; Sat, 29 Sep 2012 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2gfMhkH0niI4heZtptlkBo1eSYIvAyWVZYgkpIskFy8=;
        b=MVfMlJ8elGnLEL7kSuCrqj+nHIDyP0/qpwdyYGCWDqiRLfxl1s//rSQB4kafbbKSxq
         oKrQjYI/CTh+eaabFX8p8UEL4lPj0yaL9ZOS8+IzcdnIYnOmjjidzdoN2UudpO7zDVgt
         PAe00zaE5B8jOxeOV1uJTPOOuTCMPq8dxxDKWVcgBnj+EbNn2ari0SSZZ4aj/l9z4jjK
         sKxFGq5W1ruq/aOpLsnz5TvJMvS2LTq9uFAFp9Owd89rhP+gvkxahC8liRyUdMM0sA3S
         U0rGQUzyrhI1Y5zvVScacCMyxpEYtcy0z/V2bDJimFMqhji8eNCnmIbdCObMBl69xsnz
         IzZA==
Received: by 10.229.134.206 with SMTP id k14mr6731804qct.25.1348931273820;
 Sat, 29 Sep 2012 08:07:53 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Sat, 29 Sep 2012 08:07:33 -0700 (PDT)
In-Reply-To: <50670A94.2070504@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206653>

Hi Jens,

Jens Lehmann wrote:
> Am 29.09.2012 15:43, schrieb Ramkumar Ramachandra:
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  Like 'git remote show', 'git stash show'.
>
> I understand the analogy to "git stash show" (as that also displays
> a diff similar to what " git submodule summary" does). But "git
> remote show" just displays a list of configured remotes, which is
> something different. And the other command with a "show" option is
> "git notes show", which causes it to display a note. So I think we
> are pretty inconsistent here and I see no advantage of adding such
> an alias for "git submodule summary". What am I missing?

I used submodules for the first time, and expected 'git submodule
show' to work.  It may not be 100% consistent with the other commands,
but I think the 'summary' is a good match.  Either way, I don't feel
strongly about the patch, so feel free to drop it if you think it's
inappropriate.

Ram
