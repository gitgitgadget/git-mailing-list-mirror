From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Wed, 28 Nov 2012 08:42:47 +0100
Message-ID: <CAMP44s07c55zAtNXvPwtQFeQwEQKFfq9YOhFynqguc-HpA3EMg@mail.gmail.com>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
	<7v4nkdxawx.fsf@alter.siamese.dyndns.org>
	<CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
	<7vehjelizc.fsf@alter.siamese.dyndns.org>
	<CAMP44s0swzsg1MkQHkPUtwZi71xaad3y4uY542jYvXAf8Ha5nQ@mail.gmail.com>
	<7vsj7ujxr2.fsf@alter.siamese.dyndns.org>
	<CAMP44s3t54zYFha_qsDrg0JDZ52q8=WTs7q0rJ9qZL8kVCVWKA@mail.gmail.com>
	<7vpq2yihaq.fsf@alter.siamese.dyndns.org>
	<CAMP44s23FfxQG6v+dfRGWHzxpWZ5BSGpAm=8Q8Bmj04tDwmwKw@mail.gmail.com>
	<7vhaoai533.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 08:43:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdcIV-0008SS-TJ
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 08:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab2K1Hmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 02:42:49 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33673 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab2K1Hms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 02:42:48 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so9865230vcm.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 23:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/ss9XlzFpSt9EJu0AIWgaGC5tD6oNmmTrOLJ8lfnZWE=;
        b=vM6O0LoHe1O2X+zl8gCWdJUJyvgYJZBYxpJIMyk/XWTMEwTSrDKHwADf+Kpm2EXG/0
         MLjrkkasi5I/g9llrPD1AEth/CO1ZkDfM2jBWuAh3tiFABpUe1QyAWQAwKYvWjOHG7J5
         HXClo2qwznUV77y4j/lIQEXMhph9OA8ZSGCnjY3mAbmC++5tWFUfNqx0gc4fADdCuDza
         9gjpJlzbQUE5sgseOf6QlFUn29qnRLkiQ59HMH87DpoGGVGNOyLZTqZKhGIO7qI9r06o
         lhxNMwy8CNmoyzZ5ofw8n33Sck++o/7j3XInXbPV0LlL49xb6j/rb1c1fV3/44E3m7W8
         MUgg==
Received: by 10.58.67.199 with SMTP id p7mr28772608vet.40.1354088567792; Tue,
 27 Nov 2012 23:42:47 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Tue, 27 Nov 2012 23:42:47 -0800 (PST)
In-Reply-To: <7vhaoai533.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210715>

On Wed, Nov 28, 2012 at 8:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> People who have been bitten by bugs from *your* tree or versions in
>>> 'next' do not count.  When I said "no existing users", I was talking
>>> about the end users who need rock solid stable "releases" because
>>> tagged versions are the only ones they use.
>>
>> If users you call "fringe" have noticed these compatibility issues,
>> chances are your "existing users" are going to catch them as well.
>
> There seems to be some misunderstanding.
>
> I have never called them "fringe"; they are "early adopters" who are
> expected to be capable of "git pull" to pick up fixes from
> between-releases trees (or "git am" patches from the list) and
> rebuild their Git.
>
> We cannot expect that from the real end users (who do not exist yet,
> luckily) who only follow tagged releases.  Hitting them with bugs we
> need to fix after the release is not "letting them notice and
> report", but just "irresponsibly hurting the end users".  "Letting
> them notice and report" is what "early adopter" population who run
> 'next' are for.  Quality expectations between these two populations
> are quite different.

Perhaps, but I still don't agree with the statement that the people
bitten by those bugs don't count. If those bugs are not fixed, they
will bite the "normal" population.

>> ... That being said,
>> I don't use remote-bzr really, and I don't know how many people have
>> been using it, so I have no idea how ready it really is. ...
>> ... Either way it's doubtful there will be a v4
>
> OK; thanks for clarification.  If you are not using it actively, it
> probably is a better idea to proceed with more caution, as low rate
> of update necessity does not directly relate to maturity of the
> tool.  I'd feel better to cook it longer in 'next' to recruit early
> adopters so that we can hear positive feedbacks (or negative ones
> that can result in fixes to whatever is still uncovered, if any).

Perhaps, on the other hand it's not like any of their existing
functionality will break. Chances are they will be happy to have
anything that somehow works, even if it has bugs. In fact, the current
remote-bzr, even if it hasn't received so much testing, is probably
already more stable than other tools:

As an example there is this bug:
http://bugs.launchpad.net/bzr/+bug/541626

Which has been affecting users of 'bzr fast-export' for years (most of
bzr<->git bridges use this tool), and nobody does anything about it,
even though the developers thought the problem was in bzr itself (and
that it was actually fixed, despite the reports to the contrary). I
fixed the problem and added a reliable test case to reproduce the
issue in bzr's test suite itself, only to receive no feedback.

I think there are very few users of bazaar, and if you read the source
code you would be happy that's the case, so I'm not sure letting it
cook in 'next' is going to achieve much, most of them are going to see
it only when it hits master. Most likely the few bazaar users are
accustomed to different quality standards, and this tool doesn't even
have known bugs.

>> I'm confident about remote-hg though.
>
> Meaning unlike remote-bzr, at least you are using it more actively
> (or you know people who are), right?  I've queued the two patches
> (out of four) from you today, so we can merge it to 'master' before
> 1.8.1-rc0.

I'm not using it actively, it seems some people are, but that's not
why I'm confident; it's because of the extensive automatic testing
that compares the output with hg-git (which is widely used).

Cheers.

-- 
Felipe Contreras
