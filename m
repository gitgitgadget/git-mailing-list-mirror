From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] branch: say "Reset to" in reflog entries for 'git branch 
	-f' operations
Date: Fri, 9 Apr 2010 20:18:54 +0800
Message-ID: <w2nbe6fef0d1004090518hee66e33esd93e767580837b55@mail.gmail.com>
References: <1270799112-4308-1-git-send-email-rctay89@gmail.com>
	 <4BBF159A.1000206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 09 14:19:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0DAs-0006Ce-0g
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 14:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab0DIMS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 08:18:56 -0400
Received: from mail-yw0-f194.google.com ([209.85.211.194]:57495 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0DIMS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 08:18:56 -0400
X-Greylist: delayed 10983 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2010 08:18:55 EDT
Received: by ywh32 with SMTP id 32so438305ywh.33
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=4R4v5JeHmztQHaWoch3jQe3WVVG0O4E0+TKjArxM2Ec=;
        b=sQBwp0QOCtqQx/t40cYDEK47IJz0bAUrEW3CSTAOhkmLTotCzzFeaJeRboovsRdoPC
         Rxa7oXzE3zL0AAPdgXqbB5YEnJwLOOdQB0SFwxG2i69oWQyfiGIP6lmuOqkQILwUBzJQ
         xa7AZPuGPqBQ5ksR9rrAPDfxRMQjfqPTP8B+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kjdyhTrXgeIGGDsHcjeGlnD82pO5eAm67coR+mzLXkWfx5GVVUccpG+ftz0nYjeSUf
         67tuQTPOQn5PuuDpzF7Mo6Ay+U4vMfjX39Bx0DIASZ46Sp3hXEeTAFYlpZDLWRNuDb78
         BaY/xM8xqB0EkWchw6UvnpcIxTnEQyogmDc6U=
Received: by 10.231.10.65 with HTTP; Fri, 9 Apr 2010 05:18:54 -0700 (PDT)
In-Reply-To: <4BBF159A.1000206@drmicha.warpmail.net>
Received: by 10.100.243.14 with SMTP id q14mr2433024anh.231.1270815534971; 
	Fri, 09 Apr 2010 05:18:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144428>

Hi,

On Fri, Apr 9, 2010 at 7:55 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> I know the patch is not large, but one really has to read it after
> wondering: Huh? What is branch -f doing now before the patch? To me it
> sounded as if it didn't write to the reflog at all. So, how about
>
> elsewhere, it would make sense to say "Reset to" here as well rather
> than "Rest from".

Sounds good.

> But I also have a functional question: Is "start_from" really the ref
> *to* which the branch is reset? I hope reset does it right.

(I think you mean "start_name" instead of "start_from".)

Well, "start_name" determines where the branch/ref points to. I don't
think any branch can "start", except that it can diverge.

But that's outside the scope of this patch.

-- 
Cheers,
Ray Chuan
