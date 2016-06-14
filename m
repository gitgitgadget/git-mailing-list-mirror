From: ZhenTian <loooseleaves@gmail.com>
Subject: Re: I lost my commit signature
Date: Tue, 14 Jun 2016 16:09:52 +0800
Message-ID: <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 10:10:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCjQI-0000R4-8b
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 10:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbcFNIJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2016 04:09:59 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34138 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbcFNIJy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 04:09:54 -0400
Received: by mail-yw0-f173.google.com with SMTP id c72so147818765ywb.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 01:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FocnRilc5lQLmlNgjqlFJKl9rxZM+NoxMhBUxaURGbc=;
        b=HNRf/Vk0zLaKDxeCDnZRKGuNhAipTSdXp6LJ4ZEGLfj8vhKty7ZHZIERAkeJpAtj25
         RU8jFeP+7H9T8y/eEBpc8/l0RjKVLj/aeF1iCtOGM+6+ucdpaqGCIXqEL+jEQLquww2+
         EC082zCcbaOuFTn+lLMtFPwZjoK+CCY6CrRdpwV1gXcjX9iQ2CTDwYKJc3ISmJCnvT2h
         4ZKZkqTy+2ZTs7Q35CgdcM8s4D37KQ45SkwLIL2XXr98pyM5GSC3Yw55s7W9QbC+YJIc
         4mpCQerA5Cz6/E89gC+E8X5tqhyk8uOG7itUrWJ7tzo9OY8rvKxmFsyPJFDj/LYXZ6gL
         IdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FocnRilc5lQLmlNgjqlFJKl9rxZM+NoxMhBUxaURGbc=;
        b=DOeGjNGnma+FYv379S0MAu4eDtesT05VAJIBWLAFq+q9q5TSFhH64NELMfFs9fOvC3
         BPb2RhSBn+GkGqU8CkH6FCAo4Ptnp5Tqi3iEeaYeHTQDX0LQaf74F03fjWifw6n1iVIo
         LN4cQsTuvMWvoST1QkzXChl5bqJ9OFdOYfGG5cSQLUXhFSU/Xh5efZIADXF47mt35Uns
         rHYo3bJ8vO+EtyQabqtB08u4jiVwd+FZrGgZWQgb30O1bBUGOIQ5GGM1WW5GwWpnOpTq
         ss2luAIOKGq8LhHqlc03TSOOGnU50gLegd4e32jfetHdB3tnJD/FME49DAwFzRFoJCnD
         xxIQ==
X-Gm-Message-State: ALyK8tIsKzz3QDo2Lcoys31OY1z6RhJWOtOywqhxdsRTETi9j2doxbIxuaWBBDL/CspMztDKjBr6zhh///9pMg==
X-Received: by 10.13.222.134 with SMTP id h128mr1097883ywe.299.1465891792823;
 Tue, 14 Jun 2016 01:09:52 -0700 (PDT)
Received: by 10.129.85.203 with HTTP; Tue, 14 Jun 2016 01:09:52 -0700 (PDT)
In-Reply-To: <20160614075824.GB12563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297272>

Hi Peff,

I commit via this command: gcs -nm "feat: mobile support free freight
hint, closed #1417"

gcs is an alias in zsh, which is: git commit -S

I have tested sign my work in another project, it works fine, I have
committed five times, all commits are signed.

I can't find encoded signature block in the output of "git cat-file
commit HEAD", only these:
```
tree 17a572e349ce2fda47470951b5011b9c2f6533b7
parent 2c35701725d34325520acb9b45daf42f64adc536
author TianZhen <tianzhen@honovation.com> 1465887785 +0800
committer TianZhen <tianzhen@honovation.com> 1465887791 +0800

feat: mobile support free freight hint, closed #1417
```

Some of my commits are signed, for example I have committed four times
today, only first commit is signed. Is it possible some issue with
gpg-agent? I can't find it via `ps -Af | grep gpg`.

-Dawncold
Sincerely,
=E7=94=B0=E9=9C=87


On Tue, Jun 14, 2016 at 3:58 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 14, 2016 at 03:50:43PM +0800, ZhenTian wrote:
>
>> I commit with -S argument, and I got some output like this:
>>
>> You need a passphrase to unlock the secret key for
>> user: "Tian Zhen <tianzhen@honovation.com>"
>> 4096-bit RSA key, ID 2EF2AD6E, created 2016-05-21
>>
>> [master d107770] feat: mobile support free freight hint, closed #141=
7
>>  8 files changed, 58 insertions(+), 29 deletions(-)
>>  rewrite static/css/mobile.min.css (64%)
>>
>> but when I check git log with --show-signature, I can't find my sign=
=2E
>>
>> my git is 2.4.8, and OS is Ubuntu 14.04.4
>
> Here's a reproduction which should work (and does for me):
>
>   $ git init
>   $ echo content >file
>   $ git add file
>   $ git commit -m foo -S
>   You need a passphrase to unlock the secret key for
>   user: "Jeff King <peff@peff.net>"
>   4096-bit RSA key, ID F9430ED9, created 2016-02-03 (main key ID D7B3=
37A8)
>
>   [master (root-commit) 6b0b230] foo
>    1 file changed, 1 insertion(+)
>    create mode 100644 file
>
>   $ git log --show-signature
>   commit 6b0b230c79f8912bf8b21afc0d12d2cbf54cc74d (HEAD -> master)
>   gpg: Signature made Tue 14 Jun 2016 03:55:11 AM EDT using RSA key I=
D F9430ED9
>   gpg: Good signature from "Jeff King <peff@peff.net>"
>   gpg:                 aka "Jeff King <peff@github.com>"
>   Author: Jeff King <peff@peff.net>
>   Date:   Tue Jun 14 03:55:11 2016 -0400
>
>       foo
>
> Does something similar work for you? If so, then we need to figure ou=
t
> what happened in your original case. Can you show the exact commands =
you
> ran, and what they did output?
>
> If the simple case above doesn't work, then we need to figure out
> whether the commit doesn't get a signature, or whether "log
> --show-signature" is not working on your system. For the former, I'd =
try
> "git cat-file commit HEAD", which should show the encoded signature
> block. If it's there, then presumably something is not working in
> calling gpg.
>
> -Peff
