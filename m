From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [git-multimail] License unknown (#1)
Date: Tue, 12 Feb 2013 15:28:07 +0000
Message-ID: <201302121528.07961.andyparkins@gmail.com>
References: <mhagger/git-multimail/issues/1@github.com> <mhagger/git-multimail/issues/1/12754195@github.com> <5105778A.1040401@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	"mhagger/git-multimail" 
	<reply+i-10159725-60cb2c338c594bd09d77fe2f8d628aa55114a3f6-119718@reply.github.com>,
	Michiel Holtkamp <notifications@github.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 12 16:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Hmf-0003YO-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 16:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031Ab3BLP2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 10:28:13 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:58821 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758571Ab3BLP2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 10:28:12 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so4714312wie.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 07:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=PeS7hKL6H/8iHgkrC/CbHd2qNXw9SYJEePe8XZGmsmU=;
        b=l+HawX8aVQomdH57oPMgKjhYGQdmgwxA12/4z3mwGUcPuKCWMgAK7AW48987zmJlmg
         w2V6JVb6Yx5lPgvR6Lw5rNz4nkHlzNrFJrEBBvrHlEQ2ssQqFcz+WckDqZdwYX3blS/N
         K5jbJ2hnbMwiHCw4oGE/Dyge0UP2Q2HTmd7ZnWBJ3QHJ7r5BAphDdcM6Rnot7m8uiD0K
         dZV42TPn/JMw1DveBiK1rovgDvLh8uAGkkpZK4IPINuKlV6YIoB8ZMp/5vdxsHgaudFM
         +j6sn03/wAgeXvBNUb4qDOCSjxWufTh2JPKgRrCk2F/swTnflAAUG1VPM4e58V4B2ZFI
         IxEA==
X-Received: by 10.180.93.234 with SMTP id cx10mr4029916wib.34.1360682890729;
        Tue, 12 Feb 2013 07:28:10 -0800 (PST)
Received: from momentum.localnet ([91.84.15.31])
        by mx.google.com with ESMTPS id e12sm40343568wiw.5.2013.02.12.07.28.09
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 07:28:09 -0800 (PST)
User-Agent: KMail/1.13.7 (Linux/3.2.0-3-686-pae; KDE/4.8.4; i686; ; )
In-Reply-To: <5105778A.1040401@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216159>

On Sunday 27 January 2013 18:52:58 Michael Haggerty wrote:
> I have a question about the license of contrib/hooks/post-commit-email.
>  I had assumed that since it is in the git project, which is GPLv2, and
> since it contains no contrary information, it would by implication also
> fall under GPLv2.  But the file itself contains no explicit license
> information, and it is not clear to me that the "signed-off-by" line
> implies a particular license, either.  (The signed-off-by *does* seem to
> imply that the source code is under some kind of open source license,
> but not which one.)

Keeping up with the git mailing list got a bit much, but my original filters 
to sort messages from it into a (now hidden) folder where still in place.  
Michael contacted me independently, which was enough of a prod to see this.

My apologies to everyone; I've been lax supporting the script -- I never 
really expected it to be as widely used as it has been, I was always expecting 
someone would come along and replace it so I'm pleased that Michael has done 
so (although it's a little disheartening to read of it being called "hacky", 
when I tried very hard to make it as clear and modular as I could).

> If somebody can explain what license the code is under and how they come
> to that conclusion, I would be very grateful.
> 
> And if Andy Parkins (the original author) is listening, please indicate
> whether you had any intent *other* than GPLv2.

I intended it to be under the same license as Git.  I had read in one of the 
patch submission files (which I can't seem to find now) that all submissions 
were considered part of git.

> For anybody who is interested, the file was first committed in
> 4557e0de5b and has been modified by several authors since then.

I haven't looked at it for a long time.  I can't speak for the other authors, 
but for any part of it that is still mine -- anyone is free to do anything 
they wish with it.

> Given the pretty clear open-sourciness of the script, I don't think this
> has to be made into a big issue.  But it would be nice to state the
> license explicitly for future users' information.

If an explicit declaration is needed, I am happy to give it.  Let me know what 
form this should take and I'll supply it.



Andy

-- 
Dr Andy Parkins
andyparkins@gmail.com
