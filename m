From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: Re: [RFC/GSOC] Git Beginner | Warnings for potentially destructive
 commands
Date: Tue, 29 Mar 2016 11:43:09 +0530
Message-ID: <56FA1CF5.8070102@gmail.com>
References: <56F51089.2050703@gmail.com>
 <xmqqd1qi4fvi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:13:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akmu1-0006Jr-6O
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 08:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbcC2GNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 02:13:17 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34971 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779AbcC2GNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 02:13:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id u190so1026971pfb.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2016 23:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Wlh/FWtMd4mNVzuktgQ7sba0m5WZHue35TxGeuwbdJw=;
        b=ACweDaB0iKTe8P3Scy4JCj/y5bdvutZTfqCkU0OjyEEztPY/f2YpEuT4TmBiVG2A4a
         M+vJdK97+qHZhMWA4CwIvyuvhXZI9KAGNcwc6bwnkYYAUDSqzzKVYRVV70OxT6WnUJwW
         7sTMD9SWiRuVMbkdd+iJDRZybaTDAOiT60tfQI1i02DSB/JcKlSH4I3iGB7r7nQjl2MW
         mCeSGpCuWAoGzYPQ6WSoLC4F8GRZ5bGbPOvvf6xs+aLDzu6gGN893gLK6f0J/OywpSvk
         0yIVNanNM7rMPtUJP8neu4u1EzD8mWb37yClI5r5njF9m8kQ0Z2MjqbD28z9ps25J/6i
         No1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Wlh/FWtMd4mNVzuktgQ7sba0m5WZHue35TxGeuwbdJw=;
        b=FiPkZ+D3z9TWqdWLURVI6VYuZtkYbw9RN51xQPORGfgKdQARZyTNWOyY7KRrJoHUjs
         D/BO2DvIFxQ7rJy99SB+ognHOMuDmAvx9HSXaX6QetEbhtY6P4uGuhk4JRvATA5xrxVj
         ZyyZe6B3A2+HC1c8QQdfY0jhqQDMYIavae9LZ3zYFtVoaxkeuMQIuH+XPMUPXr+I3Dh3
         JDUofeIee9PQP0BHGlpLJYq1usvJR7dxHTQVLirYEboVpNGplex/EkFpsaZuknVTx+t2
         wk6vHF98LAYgZkfbvtezvyY765pNsYCjlEaAJ8KDak11FrMfEPs8bS4u2sugiTaWO4Tj
         Oofg==
X-Gm-Message-State: AD7BkJLVFH+qTtzGxchJ+ro9OGD8rW8FcKy4z0bah9y+6lPabN2OdXs+9SgVBcKUVVbSqQ==
X-Received: by 10.98.93.1 with SMTP id r1mr725188pfb.57.1459231994993;
        Mon, 28 Mar 2016 23:13:14 -0700 (PDT)
Received: from [192.168.1.10] ([122.162.3.234])
        by smtp.gmail.com with ESMTPSA id zp5sm9055322pac.9.2016.03.28.23.13.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2016 23:13:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqd1qi4fvi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290105>

On Friday 25 March 2016 11:08 PM, Junio C Hamano wrote:
> Sidhant Sharma <tigerkid001@gmail.com> writes:
>
>> $ ggit rebase
>>
>> [WARNING] You are about to rebase your commits in <topic-branch> onto the
>> $BASE_BRANCH, which will essentially replay the work done in $TOPIC_BRANCH
>> since last merge onto $BASE_BRANCH.
>> For instance,
>> Current state:
>>
>>     o---o---A---B  $BASE_BRANCH
>>          \
>>           X---Y  $TOPIC_BRANCH
>>
>> State after rebasing:
>>
>>     o---o---A---B---X'---Y'  $BASE_BRANCH
>>          \
>>           X---Y  $TOPIC_BRANCH
>>
>> where X' and Y' are the commits making changes identical to those made by X and
>> Y respectively.
> The topology may be correct, but the branch labels are both wrong,
> no?  The tip of the base branch will stay at B, and the tip of the
> topic will point at Y'.
Thanks for pointing that out, will correct that.
>> Rebasing is not usually problematic except in cases when you are rebasing
>> commits that do not exist in your repository.
> This cannot be correct, as you fundamentally cannot work on (not
> limited to rebasing) commits that do not exist in your repository.
>
Actually I meant to refer to the commits that exist outside the local
repo (eg. on the remote), like it says in the 'The Perils of Rebasing'
section of the Git Branching and Rebasing documentation [1]. I'll rephrase
it to make it clearer.
>> $ ggit reset --hard
>>
>> Resetting to <destination-commit-hash>
>> [WARNING] You are about to hard reset the current HEAD (master) by <n> commit(s).
> If I were on B and did "git reset --hard Y", i.e.
>
>      o---o---A---B  $CURRENT_BRANCH
>           \
>            X---Y  $CURRENT_BRANCH_AFTER_RESETTING
>
> does the phrasing "about to reset by <n> commit(s):" make any sense?
>
>> This will take you back to commit <destination-commit-hash>, and discard all
>> changes make thereafter. For instance,
>> Current state:
>>
>>     o---o---A---B---C---D---E  $CURRENT_BRANCH
>>
>> After resetting 3 commits:
>>
>>     o---o---A---B  $CURRENT_BRANCH
> The above two examples make me wonder if these should be static
> text.  "ggit rebase" and "ggit reset" have full information of the
> concrete branch names, commit object names and the actual topology
> of the history, so it should be able to give a description more
> tailored to the user's situation.  Instead of giving a fictional
> drawing with "For instance, Current state:", it should be able to
> draw the actual before-and-after picture based on where the end-user
> actually is.  I see _some_ attempts (e.g. with "<n>", mention of
> "(master)" and $BASE_BRANCH, you may have meant that they will be
> replaced with actual values), but I suspect that telling some truth
> (i.e. use of the real branch names) while showing pictures that do
> not match the reality (i.e. if the topology and the description are
> done as fixed text) would only confuse the users.


On Sunday 27 March 2016 01:06 PM, Jacob Keller wrote:
> On Sat, Mar 26, 2016 at 8:12 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> If possible, I would suggest aiming for generating the actual topology
>>> that the user is seeing, customized so that it gives relevenat
>>> information, rather than static examples.
>> Using the real topology in a useful way is actually pretty hard. It's
>> quite easy to throw the output of "git log --graph --oneline ..." to the
>> user, but as soon as the rebase deals with more than a handfull of
>> commits, we'd want to simplify the history to show something
>> understandable to the user (which by definition should be a beginner if
>> he uses ggit), like replacing long sequences of commits with "..." or
>> so. That is hard to get right.
>>
> Yes, in which case we should go Junio's route of not using anything
> from the real topology.
>

I now understand why using the actual names with a hypothetical
topology would only confuse the user. I'll update the diagrams
with hypothetical names.
Also, other than these commands, what others should I include in
the list? I think we may also have warnings for the following:
* git checkout -- <path>
* git rm --cached
* git stash drop [<stash>]
* git stash clear
* All plumbing commands?
Comments?

Thanks and regards,
Sidhant Sharma

[1]: https://git-scm.com/book/en/v2/Git-Branching-Rebasing#The-Perils-of-Rebasing
