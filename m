From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] git(1): remove a defunct link to "list of authors"
Date: Mon, 10 Dec 2012 19:04:40 +0700
Message-ID: <CACsJy8Dg1a0siDbiHtk4m1RhjLt-XKiS8kOO7qPKjwRczLF9vA@mail.gmail.com>
References: <7vobi5hhn9.fsf@alter.siamese.dyndns.org> <7vk3sthhfy.fsf@alter.siamese.dyndns.org>
 <CACsJy8A7AYpZs7mTc+B-F7BBLPdACim=gHCg8sK1Aci8YSEB4Q@mail.gmail.com> <7vboe2ct9p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 13:05:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti270-0005dt-Ky
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 13:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab2LJMFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 07:05:11 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37051 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab2LJMFK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 07:05:10 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2298305oag.19
        for <git@vger.kernel.org>; Mon, 10 Dec 2012 04:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1bFhDiuTB7kCD3rFAIadzcdqaQbVVLdf0oyEkUtYkBs=;
        b=Ic5wGKurd07iu3V5RY0rbT8Q3llIJ9A2BcvzhUfAjURsknyyZnrqWf/+3FBweP7EWi
         LqWoV8EH1ZDffqDunrZDc5sYkPtZ9GhUnsW/+fum7/oJClOfveAHP2gKCXKpAwT+ohd3
         F1CAdl//QvB4YwNnJG60QyBtSO0DWDsDjrPa+RzhYLZoQfzep8jZ4NpMNxCQecq9HzGb
         Ripv8nBJS59dyEzEQAFc6QPophp50ybpd3p1VhbpxBdCaoIQVX0NO5vRWwF3FLTyQoyP
         U8DHZUG+cQ5mC7zkMPjfyPWyZcYhoEJllVoI1ftsX1luGGMf9ygcFhdFUCImKcOANX6h
         AB5A==
Received: by 10.60.170.10 with SMTP id ai10mr7580325oec.72.1355141110213; Mon,
 10 Dec 2012 04:05:10 -0800 (PST)
Received: by 10.182.23.11 with HTTP; Mon, 10 Dec 2012 04:04:40 -0800 (PST)
In-Reply-To: <7vboe2ct9p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211255>

On Mon, Dec 10, 2012 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Sat, Dec 8, 2012 at 12:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>  * If somebody has a working replacement URL, we could use that
>>>>    instead, of course.  Takers?
>>>
>>> A possible alternative could be https://www.ohloh.net/p/git/contributors/summary
>>
>> Nice charts!
>
> Yup.
>
> Their numbers seem to be just 'any commit by the author, with
> mailmap applied', and I am of two minds with it.  Counting without
> "shortlog --no-merges", depending on the management style of the
> project, tends to credit the integrator too much.  Even though
> vetting the patches and choosing when to merge the topics is a
> significant contribution, it isn't *that* big compared to the work
> done by the contributor who took initiative to scratch that itch.
>
> With or without "--no-merges", the big picture you can get out of
> "git shortlog -s -n --since=1.year" does not change very much, but
> the headline numbers give a wrong impression.

These numbers are approximate anyway. Commit counts or the number of
changed lines do not accurately reflect the effort in many cases. And
about merges, in this particular case of Git where the maintainer imo
has done an excellent job as a guard, I'd say it's the credit for
reviewing, not simply merging.

But not using the link is fine too. We can wait for Jeff's patch to be merged.

> And of course, application of the mailmap is very important, if you
> want to get meaningful numbers out of shortlog over a longer period.
-- 
Duy
