From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] glossary: add "remote" and "submodule"
Date: Wed, 27 May 2015 15:59:41 -0700
Message-ID: <CAGZ79kbz6d8j1p5d-pO2cpou76ivhkCQPq4cpGxozc-9cnACPQ@mail.gmail.com>
References: <1432761209-4120-1-git-send-email-sbeller@google.com>
	<xmqq617dk621.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 00:59:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxkId-0005Nt-UU
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbbE0W7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:59:43 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34049 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbbE0W7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:59:42 -0400
Received: by qcbhb1 with SMTP id hb1so10656074qcb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 15:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LeLZ+bBWKd8DYeRclA1ElLVSIwr73fDcn8s5TYtssPc=;
        b=Cpu6MRaTkrmBwceZmzzJvd9SW8fkA5MCbpMml7AUNInU8BvSglXM1xjk+a3ysMW8Dl
         tEGISjbEXeHu9Uqphj0ePKW8SewTBSMWjlUZEsCZzIs+aodxs+WZFKwfzBX+P7GQzT4d
         uMCJxFuw1bO4DnwC8m821bu1oxKcUF5umF96DKu40osOrR1PF4Ecq2D2cMPZi47Cksve
         TEt015sT3e5NbD1fO6tVFbvK8fFyg3ckNjOBLKiBYgQS7lELXGdu3H1PWp4/QsA3a5T9
         /PcRzq+LiuIiPRpxdkZDTOZQAjZKZh3I13+AF57AG4JagQnSPdZdobaTZrrFiRDQL9/M
         j6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LeLZ+bBWKd8DYeRclA1ElLVSIwr73fDcn8s5TYtssPc=;
        b=m/IZT1rxUjrJjBfPD+aM8gq/PJWJrY4nEg7N+MHomu031bwXX/zhIBL0H5HbEv514D
         yTH2q9U/LExO60tfM1wj0P+cdUFSXnhHMq2qF1JsNd3qGtYrHRMCCWxvr/4oVC8We8RB
         xmWLMEy7jMyyzqTmsb2pbWyyUEda5VoBqpvlefviHFboVyzRXcky7MvN9Gpmcqy7Iuim
         DVKZpHXx7HkxGu8dbGYtFw3pC5uVrBdkIAivrHNLZWiRnWkUpFK+ty3IvbBI/uYGuCi3
         CGgTqFc1SXO9M4EQ7aSb8nska6VOhNlYKnwXmN8/mAStOfGOAWQsqdY3nmsIkh74WBy1
         hsrA==
X-Gm-Message-State: ALoCoQmz2oMXd4VJ3xipchpPwui/c3g2JaoomNfg4kUBBel0zj/IE7zgwj8id8UYGIPgKpLNoluU
X-Received: by 10.55.42.82 with SMTP id q79mr25328977qkh.84.1432767581701;
 Wed, 27 May 2015 15:59:41 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 15:59:41 -0700 (PDT)
In-Reply-To: <xmqq617dk621.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270116>

On Wed, May 27, 2015 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Noticed-by: Philip Oakley <philipoakley@iee.org>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/glossary-content.txt | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index bf383c2..e303135 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -469,6 +469,11 @@ The most notable example is `HEAD`.
>>       <<def_push,push>> to describe the mapping between remote
>>       <<def_ref,ref>> and local ref.
>>
>> +[[def_remote]]remote repository::
>> +     A <<def_repository,repository>> which is used to track the same
>> +     project but resides somewhere else. To communicate with remotes,
>> +     see <<def_fetch,fetch>> or <<def_push,push>>.
>> +
>
> OK.
>
>> @@ -515,6 +520,11 @@ The most notable example is `HEAD`.
>>       is created by giving the `--depth` option to linkgit:git-clone[1], and
>>       its history can be later deepened with linkgit:git-fetch[1].
>>
>> +[[def_submodule]]submodule::
>> +     A <<def_repository,repository>> inside another repository. The two
>> +     repositories have different history, though the outer repository
>> +     knows the commit of the inner repository.
>
> I'd stress that they are not just different histories (as the
> 'master' and the 'maint' branches of my project has different
> histories) but they are separate projects.  Perhaps like this?

This is a very subtle distinction IMHO, as both master and maint
"are the same project". Looking from enough distance, it's just the
git project without the fine detail of what makes these 2 histories different.
I tried coming up with a short paragraph, which may explain my choice
of words. But correctness trumps brevity indeed.

>
>        A repository that holds the history of a separate project
>        inside another repository (the latter of which is called
>        superproject).

This is better than what I proposed, but confusing. When naming
a project a submodule, my mental standpoint is the superproject.
("This project has the submodule foo and bar"). But In your description
the superproject is called "another repository".

>        The containing superproject knows about the
>        names of (but does not hold copies of) commit objects of the
>        contained submodules.

That makes sense to point out here. Though should we also introduce
"superproject" now?

>
> It is not like that it is strange or unintuitive that the
> superproject knows about some commits in its submodule.  "X, though
> Y" however makes it sound as if Y is true "despite X".  I do not
> think there is any "despite" here.
