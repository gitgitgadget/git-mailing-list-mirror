From: Mark Lodato <lodatom@gmail.com>
Subject: Re: Commit annotations (editable commit messages)
Date: Fri, 12 Feb 2010 20:01:00 -0500
Message-ID: <ca433831002121701u7c4e47ddn2f8bc19c45b2bd03@mail.gmail.com>
References: <op.u71cw50km02fvl@cybershadow.mshome.net> <32541b131002121455s46bfe15aie484e9be484259c6@mail.gmail.com> 
	<op.u71e00v4m02fvl@cybershadow.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Vladimir Panteleev <thecybershadow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 02:01:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng6O0-0003Au-W5
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 02:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab0BMBBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 20:01:23 -0500
Received: from mail-yw0-f179.google.com ([209.85.211.179]:49144 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab0BMBBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 20:01:22 -0500
Received: by ywh9 with SMTP id 9so3059424ywh.19
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 17:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=D/BK22OQx3dnz4ZcGJsNji/DhLrVRMu210MvIk/RsuM=;
        b=LAt6HKkMQtflYlDlB+u0nYAfqSIVVMlJ1ANNSapmQEPSsA+n+ku0QWq3T6d2tMibQ3
         /p4E0eF0yy2buqbrTfn0HKvhuMmZWc9IRe3gO8iess6SIcrLcnElNUIq8B+ByeIWlwJT
         uolIKc5zY2tGxN1SapYLAQlVvGEr/6SyzlmPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Tgbhu+xNPJCnFO/jbDrTuGjmvdo1CknEcgsQnxuq6MGYx8wIVaT2iT4xFMEqn1yfc/
         iH/N1IxFHtmccbEnA9Efvi78JR5i+yexY06/PtJF4OMNghgoP2iJnYsvxQD2Py56dad/
         SkG/bZncwoKUto62XvuOOJBbHl6EoQkgxHcHg=
Received: by 10.90.11.12 with SMTP id 12mr2190280agk.18.1266022881345; Fri, 12 
	Feb 2010 17:01:21 -0800 (PST)
In-Reply-To: <op.u71e00v4m02fvl@cybershadow.mshome.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139767>

2010/2/12 Vladimir Panteleev <thecybershadow@gmail.com>:
>> It sounds like you want to read about a new feature called git-notes:
>> http://www.kernel.org/pub/software/scm/git/docs/git-notes.html
>
> Wow, thanks! Looks like I'm behind the times. (Currently stuck with
> msysGit/1.6.5)

Yes, what you described sounds *exactly* like git-notes :)

> The documentation looks pretty scant. Does anyone know how close were my
> suggestions to the actual implemented behavior (esp. regarding rebasing)?

1, 2, 3, and 4 are all implemented, as far as I know.  However, I
don't think notes copy during a rebase.  My gut feeling is that you
probably shouldn't be rebasing so much that this is an issue.  I'm
guessing that you should copy the note to the new commit ID after the
rebase.

I have also found the documentation lacking.  It helped a bit to see
the history.  It's pretty compact in the logs.  Here are two commands
to isolate the commits:

git log --reverse fed8a7de3592~..df27f6280545
gitk fed8a7de3592..df27f6280545

--
Mark
