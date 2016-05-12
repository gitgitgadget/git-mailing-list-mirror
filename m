From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] Documentation: clarify signature verification v2
Date: Thu, 12 May 2016 13:38:17 +0530
Message-ID: <CAFZEwPM27g-FZBa6ggJKmYvjAfp=YWnC90j73dpgpkjJC=F3Nw@mail.gmail.com>
References: <20160512065022.GA32387@hashbang.sh>
	<CAFZEwPOJg=njvhtK7ZQf_-3DUVjMpFBEV_0m1NHAE1UL7eM5ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"Michael J. Gruber" <git@drmicha.warpmail.net>,
	"Brian M. Carlson" <sandals@crustytoothpaste.ath.cx>,
	Junio C Hamano <gitster@pobox.com>
To: Fox in the shell <KellerFuchs@hashbang.sh>
X-From: git-owner@vger.kernel.org Thu May 12 10:08:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0lfX-0002u9-V7
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 10:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbcELIIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 04:08:21 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33864 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbcELIIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 04:08:18 -0400
Received: by mail-yw0-f194.google.com with SMTP id i22so6770472ywc.1
        for <git@vger.kernel.org>; Thu, 12 May 2016 01:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JBBodbdWYSv5LrCmaecdAoX3wTrXBPtY5x2Z3rPk/Fg=;
        b=y6tb2CgcEEQcZVUlTzgLFzbr5Q6t9/Tx0YX2ntaiM32ontJ/HF2XjWFAb7DkI8W0Eq
         7R2w7/qz/cN6D/4N9f9k5Emz8kDHTQozyCXUW25vYJRt8CW0fZ/0nXqpY0j3FGpZJiMU
         EmLdR27z+0txn4LhUEKBxuSamaC84D3GxP1udK4PXBEuTCoLG5PGl2AwPiur3IogwXnh
         N2LJycgqP1t63K86SM6mj7nJpokD3B56k+bfi7y+Ar2u8MSTodbcyVaHVeLJOmR+FiSk
         D5Sad9IxJESPBjHq7nadOvvoXqb3kw0d0NBEOagG03U6k41y2SfcwG2LsKfqCJJqAo67
         6fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JBBodbdWYSv5LrCmaecdAoX3wTrXBPtY5x2Z3rPk/Fg=;
        b=WV/JbAaX+MtcN7DDnAEUtboeE8NYJbpSFscr7S9XEp247OfR/lLF9fet9fHAfH6DrX
         6iB6peG00H9PM8U6vDhYPyJXLn86iot9NAjUwuUSBMsdtyZLgaVsr1jdMB6als5X7G6d
         yJiDqWr+XzKdEeiupVL+LR9IndqmuTdEgjOaflFMbzZ63zsVeQSseLEiLJs5kw6Ssn7g
         lOpcykhTL9CzBQ65YIlGpeEZCiXBqr6YB11eT2kicUAnrzEOroXJrlnEXM4XlXYgLPj3
         i9P0UGNJlb3yIsPLk9qrqAWiQeW3LnhiiSlSd15BzzPQOgw/9KhG1gwMro8MwfuIA7Zm
         49BA==
X-Gm-Message-State: AOPr4FVrXdxkmvm3nuYG0zYN7DdZBAWpklCO8lVPe96qcDMPSUIZPNmcA4+Sczkh/QlBgbX9WmB/BvlSNG8/MA==
X-Received: by 10.13.222.1 with SMTP id h1mr4355586ywe.171.1463040497377; Thu,
 12 May 2016 01:08:17 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Thu, 12 May 2016 01:08:17 -0700 (PDT)
In-Reply-To: <CAFZEwPOJg=njvhtK7ZQf_-3DUVjMpFBEV_0m1NHAE1UL7eM5ng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294402>

On Thu, May 12, 2016 at 1:34 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Thu, May 12, 2016 at 12:20 PM, Fox in the shell
> <KellerFuchs@hashbang.sh> wrote:
>>
>> Hi,
>>
>> Here is a second attempt at this patch.
>> Sorry for the delay, life somewhat got in the way.
>>
>
> Its okay! We understand that things might take a little more time than expected!
>
>> --
>> Clarify which commits need to be signed.
>>
>> Uniformise the vocabulary used wrt. key/signature validity with OpenPGP:
>> - a signature is valid if made by a key with a valid uid;
>> - in the default trust-model, a uid is valid if signed by a trusted key;
>> - a key is trusted if the (local) user set a trust level for it.
>>
>> Thanks to Junio C Hamano <gitster@pobox.com> for reviewing
>>   the first attempt at this patch.
>> ---
>
> Its good to provide links to the previous version[1] of the patch.
> Please go through the Documentation/SubmittingPatches once.
> Seems like Junio was waiting for someone to point this out[2].
>
> A couple of notes of how to submit the patches:
>  * You have cc'ied the reviewers. Good!
>
>  * Include the version no (v2) inside the [PATCH] like [PATCH v2]
>
>  * The next version should be as a reply to the previous one.
>     Hint: use --in-reply-to with git-send-email
>
>  * git-am is used to pick up these patches and it gets the subject
>    of the email and strips of [PATCH ...] and then uses the other stuff
>    in the commit message headline.
>
>  * The rest of the commit message are the words before ---.
>     So currently git-am will pick up your paragraph as commit message:
>
>           "Hi,
>
>             Here is a second attempt at this patch.
>             Sorry for the delay, life somewhat got in the way."
>
>     which is quite undesirable as a commit message.
>
>  * Comments are put after ---. So your paragraph
>       "Clarify which commits need to be signed.
>
>         Uniformise the vocabulary used wrt. key/signature validity with OpenPGP
>          - a signature is valid if made by a key with a valid uid;
>          - in the default trust-model, a uid is valid if signed by a
> trusted key;
>          - a key is trusted if the (local) user set a trust level for it.
>
>            Thanks to Junio C Hamano <gitster@pobox.com> for reviewing
>            the first attempt at this patch."
>
>     is actually treated as a comment.
>
>  * Also your signoff is missing.
>
>  * If you want to credit someone then its better to use syntax like:
>       "Helped-by: Junio C Hamano <gitster@pobox.com>"
>
>  * It also seems like you probably wanted to add the
>    "Reviewed-by:" tag. Please note only the reviewers can
>    add that tag.
>
>>  Documentation/merge-options.txt  | 7 +++++--
>>  Documentation/pretty-formats.txt | 4 ++--
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
>> index f08e9b8..30808a0 100644
>> --- a/Documentation/merge-options.txt
>> +++ b/Documentation/merge-options.txt
>> @@ -89,8 +89,11 @@ option can be used to override --squash.
>>
>>  --verify-signatures::
>>  --no-verify-signatures::
>> -       Verify that the commits being merged have good and trusted GPG signatures
>> -       and abort the merge in case they do not.
>> +       Verify that the tip commit of the side branch being merged is
>> +       signed with a valid key, i.e. a key that has a valid uid: in the
>> +       default trust model, this means the signing key has been signed by
>> +       a trusted key.  If the tip commit of the side branch is not signed
>> +       with a valid key, the merge is aborted.
>>
>>  --summary::
>>  --no-summary::
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
>> index 671cebd..29b19b9 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -143,8 +143,8 @@ ifndef::git-rev-list[]
>>  - '%N': commit notes
>>  endif::git-rev-list[]
>>  - '%GG': raw verification message from GPG for a signed commit
>> -- '%G?': show "G" for a Good signature, "B" for a Bad signature, "U" for a good,
>> -  untrusted signature and "N" for no signature
>> +- '%G?': show "G" for a good (valid) signature, "B" for a bad signature,
>> +  "U" for a good signature with unknown validity and "N" for no signature
>>  - '%GS': show the name of the signer for a signed commit
>>  - '%GK': show the key used to sign a signed commit
>>  - '%gD': reflog selector, e.g., `refs/stash@{1}`
>> --
>> 2.1.4
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/291123
> [2]: http://article.gmane.org/gmane.comp.version-control.git/291185

Forgot to mention. It would be preferable to use your real name in the signoff.
