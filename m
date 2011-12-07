From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Undo a commit that is already pushed to central server and merged
 to several branches
Date: Wed, 7 Dec 2011 21:31:03 +0530
Message-ID: <CALkWK0msjfebnE=q_ykx3+iVkeT2aa1A2BmtrHCw2wGaZzOC8w@mail.gmail.com>
References: <4EDF74EC.6090504@fechner.net> <CALkWK0k46HnWTHx3iYuWFUegTgZhAMShx9MT2E83QCmxrvZOxg@mail.gmail.com>
 <4EDF87A6.4000703@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Wed Dec 07 17:01:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYJw2-0000YR-B2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 17:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418Ab1LGQBZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 11:01:25 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47450 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349Ab1LGQBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 11:01:25 -0500
Received: by qcqz2 with SMTP id z2so470505qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dPOcDvQS7bdSmtJbevddwXVoHWSTww2ByyK3y+LCPtk=;
        b=GiA0CEF4hzQxqfrGa7mbiHR3g7q3zzt2OBvXq5INaysJcVkKJWD5kP9ehwHrReBy5E
         XFQo9X4o69/O7AQAqI4A/PeKFC3NOql5xFpCiJ3Pm2C9ojxCNTTnubPQtli8eEX79zy6
         kDBU6C92bMcBwUbNQm6pp4+NMCj2UO5KvYOac=
Received: by 10.229.227.84 with SMTP id iz20mr4184132qcb.164.1323273684703;
 Wed, 07 Dec 2011 08:01:24 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Wed, 7 Dec 2011 08:01:03 -0800 (PST)
In-Reply-To: <4EDF87A6.4000703@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186468>

Hi Matthias,

Matthias Fechner wrote:
> Am 07.12.11 15:42, schrieb Ramkumar Ramachandra:
>
>> Assuming that you actually want to rewrite the history, the situatio=
n
>> calls for a git-reset(1). =C2=A0Just "git reset --hard HEAD~1" on ea=
ch of
>> your branches (Caution: first understand what it does!) and you'll
>
>
> that will not work, because in the master branch I already have aroun=
d 15
> commits after the bogus commit and I want to keep these commits.
>
> And in some other branches there are tons of commits (over 100) after=
 the
> bogus commit with the merge and I only want to remove that bogus comm=
it but
> keep all other commits after the bogus commit (all commits are not re=
lated
> to the bogus one, they are all in different files).

I see.  I won't attempt to repeat what Junio and Linus have explained
in this document then [1].

Cheers.

[1]: http://schacon.github.com/git/howto/revert-a-faulty-merge.txt

-- Ram
