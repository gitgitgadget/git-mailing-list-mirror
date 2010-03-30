From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 30 Mar 2010 19:15:12 +0800
Message-ID: <41f08ee11003300415y28608806je3e98b33367a6f3d@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <201003282120.40536.trast@student.ethz.ch>
	 <41f08ee11003282114m34aa0f61w536b996dce6cecab@mail.gmail.com>
	 <201003292042.01549.trast@student.ethz.ch>
	 <41f08ee11003291952r467601b1o970ce3be802d8521@mail.gmail.com>
	 <m3vdcei3bb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 13:15:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwZPv-00006n-24
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 13:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277Ab0C3LPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 07:15:16 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:37923 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230Ab0C3LPO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 07:15:14 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3669489qwh.37
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 04:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JoWg2dPn3Z8I2koBILnMRoRif0QZalfaMXk1G5Zrzyg=;
        b=sI0L8zy/1roeJiYv/UDYSYGF0Xt/kYR0t83HzQheJkZHYZJ9RwPMzuVeaJHgHVXC70
         oGpnMSeFmbyf6Z+tLTfzfEeHuPLQdEOxYETPwKtsItq50rAk7EuGtlGiGz+KmrIjNw6t
         8kofNIB0eS3v5TScPcIDP5tLbB3nH3I5dhHuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e5sXWgjAfRmRb1quWCe1UYJjYQhAEq2dNALNwOM9PDjOB/KcmZsV8Rm87Rg/yva3bn
         0TeCjQwGYLmA2tZ1C5W4hU/bPQdO4qsXotfR7giTA1z2TfJqY6paSmZMjW90h8S5uV+h
         4wDvmLPJwzA0nKu7WLgniVr4chjlof000SBQ8=
Received: by 10.229.84.72 with HTTP; Tue, 30 Mar 2010 04:15:12 -0700 (PDT)
In-Reply-To: <m3vdcei3bb.fsf@localhost.localdomain>
Received: by 10.229.88.193 with SMTP id b1mr1604453qcm.27.1269947712895; Tue, 
	30 Mar 2010 04:15:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143564>

Hi Jakub,

On Tue, Mar 30, 2010 at 5:10 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> By the way, it would be good to find an example with "evil merge",
> which means that the change to given line(s) is in the merge commit
> itself. =A0Correctly simplifying history in such case might be
> non-trivial.

It is a little time consuming to find such a change in the history. I
think we can come up some ones at the start of the project manually
and put them into the testcases. :)

> Another example that it would be good to have is "history split"
> example, which means the case where some lines were consolidated
> (e.g. after refactoring), and some of lines in "preimage" come
> from different lines of history.
>
> This would help with writing tests for this feature (compare tests
> for blame), although they are not in my opinion necessary for the
> proposal itself.
>
> I hope that all this cases would fall naturally from the
> implementation.
> [...]
>> > Push the code somewhere public as you go, even between feature
>> > completions. =A0Post RFCs once you have workable features so peopl=
e can
>> > comment. =A0Generally try to be visible.
>> >
>> > Bonus points if you can think of something visible to do during th=
e
>> > period where you look at code,
>>
>> Yeah, really is a good point. And I have tried to play around on
>> github.com and try to set up a http://github.com/byang/my_git for th=
is
>> purpose. :)
>
> my_git is not very descriptive... well, unless you would do your work
> on GSoC2010/line-level-history-browser branch, or something like that=
=2E
>
> It might be good idea to have repo.or.cz as an additional repository,
> as a fork of git.git repo, and with SoC / GSoC labels. =A0See
> http://repo.or.cz/w/git.git/forks?t=3Dsoc

Ah, a repo at  http://github.com/byang/gsoc-line-browser is created
and a mirror at http://repo.or.cz/w/gsoc-line-browser.git, I think
this is enough. :-)

Thanks!
Bo
