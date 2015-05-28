From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] glossary: add "remote", "submodule", "superproject"
Date: Thu, 28 May 2015 10:52:17 -0700
Message-ID: <CAGZ79kb7M9L-xkMEG1GhAhYVWPR3env2fLiWt4fpbB=e6+jUhA@mail.gmail.com>
References: <CAGZ79kauSsZK3_X+zTwL8TKuZiHNMGvMZfoCemW9-K7RWgrgCA@mail.gmail.com>
	<1432777801-6073-1-git-send-email-sbeller@google.com>
	<xmqqk2vsirbe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 19:52:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1yi-0002wJ-1K
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbbE1RwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:52:20 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36751 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbbE1RwS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:52:18 -0400
Received: by qkx62 with SMTP id 62so30727464qkx.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wUile2dGDLDqnwojyALVXQawyP5eHPgVMIcSJ7tI3/Q=;
        b=kU9igYOFarGUzbE32tbRnHsbHylS/gCJgHZJABftb2YSykAts0TlchyFe8AIzfQ2AP
         slo938e4ftNgyawwQMqCYI1g6Z63gw6ygPa7nDYJt7Yso4BknPwyOdPtvmBkuTU87KIh
         /iho5LXWPJo3dL7Dgk5xPYe2T2/gK+IagYgOUFP79CMi/tbT0seGsGSW+UNqTgFzimle
         MLHz0BUI8IGynpIN+2gUYPgi/9PdsPvPOMCjKC1k5ykdhDRnGueoMRR7m7k15zK1Ik4w
         A3St35cChl5lBMPSCphaUif/88My74DE6nSLRa8zcjuHTiLSKlv4Dz20SlOG62lU9Jfo
         Wi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wUile2dGDLDqnwojyALVXQawyP5eHPgVMIcSJ7tI3/Q=;
        b=gas8IPff4ZP/LCEyGngLjtx5nPDI7L+Jr+2Cveh2P/+bu8mO8ClqMh3J08QIe9F5DC
         cAlgybjkeO3NFPP0yRxJF1d8cZ1E98hRbaim79mIo4ee5ZaKKy18ZuXnALJLQ3pE3M5w
         mozUhDxRHHOKxt0ddyYYWVKZmk1dZ1Yezb3idM0jYcQa7TVQtV3qUgL44WcaoXxzuPRx
         jhGDC66gjjUnJpig9o+ePmXkqy4dpxSQCc+RNbhotpfUime/XoDrm4ydP7J8WQFhfqCN
         gsaDCwDtU+GqiEVop/MpnxappOhuWNXzuoNAIRofSHwzZ1mkgfKjRmli91Rybb3pKxXb
         FFMw==
X-Gm-Message-State: ALoCoQnZZ0gAfbTVq0+pHamkYAFO7G9c8/prgAXahcaR4MpFE4AaNRLo0YysNs17wVjPLziOeCLa
X-Received: by 10.140.96.202 with SMTP id k68mr4681175qge.102.1432835537453;
 Thu, 28 May 2015 10:52:17 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Thu, 28 May 2015 10:52:17 -0700 (PDT)
In-Reply-To: <xmqqk2vsirbe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270171>

On Thu, May 28, 2015 at 9:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Noticed-by: Philip Oakley <philipoakley@iee.org>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/glossary-content.txt | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>
> The updates in this version relative to the previous one looks very
> good, at least to me.  A bit more comments.
>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index bf383c2..23ab692 100644
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
> The last sentence sounds a tiny bit strange, in that I have to do a
> bit more than just see the explanation of these commands in order to
> communicate with remotes.

Maybe s/see/use/ here?

>
> But it probably is just me.
>
>> @@ -515,6 +520,18 @@ The most notable example is `HEAD`.
>>       is created by giving the `--depth` option to linkgit:git-clone[1], and
>>       its history can be later deepened with linkgit:git-fetch[1].
>>
>> +[[def_submodule]]submodule::
>> +     A <<def_repository,repository>> that holds the history of a
>> +     separate project inside another repository (the latter of
>> +     which is called <<def_superproject, superproject>>). The
>> +     containing superproject knows about the names of (but does
>> +     not hold copies of) commit objects of the contained submodules.
>
> I agree with one point you mentioned in one of your messages, which
> is that a submodule is not aware that it is used as part of a larger
> project.  That makes me wonder if the last sentence sits better in
> the description of the superproject, rather than the description of
> the submodule.

Moved in the upcoming reroll.

>
>> +[[def_superproject]]superproject::
>> +     A <<def_repository,repository>> that references other repositories
>> +     inside itself as <<def_submodule,submodules>>.
>
> Perhaps "repositories of other projects"?  Does "inside" make it
> clear enough that we are talking about the relationship between
> working trees of the superproject and submodules?


    A <<def_repository,repository>> that references repositories
    of other projects in its working tree as <<def_submodule,submodules>>.

>
>> +     The superproject
>> +     tracks only the remote and the name of the submodule.
>
> I am not sure what this sentence means [*1*], and I do not know if
> (a corrected version of) such a description is necessary here.

When looking at submodules and subtrees I feel they behave similar
to symbolic and hard links. If you delete the remote of the submodule
you need to take care when dealing with the superproject, similar
to repairing a dangling symlink. ("Is it gone or just moved? Where
do I point it now?")

My intend here was to show that submodules are fragile like symlinks are.

Usually a repository (or a file in that analogy) is quite self contained,
if you have a copy of the repository, you can do lots of operation on it
like reading, changing(writing), moving. If there is a broken (git/sym-)link
reading in full becomes a hassle, as parts are missing.

I am not sure if the discussion belongs into the glossary though.
But where would you start looking for information if you want to decided
whether to use submodules or subtrees?

>
> Thanks.
>
> [Footnote]
>
> *1* The superproject records a bit more than "remote and name" in
> .gitmodules, and of course it records the history of the paths that
> the submodule is bound to over time, with specific commits from the
> submodule in its history.
>
