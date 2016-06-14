From: ZhenTian <loooseleaves@gmail.com>
Subject: Re: I lost my commit signature
Date: Tue, 14 Jun 2016 16:39:38 +0800
Message-ID: <CAGrdoOqfcacG488u-MA7UiapgvJEGNX2QaRq8BMmycEWg-BGWg@mail.gmail.com>
References: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
 <20160614075824.GB12563@sigill.intra.peff.net> <CAGrdoOp=dDkiTr+Sb-uZWx66b4hoZCYAiRjfgYqoE8H4-kXJvg@mail.gmail.com>
 <20160614081854.GA13457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 10:39:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCjsv-0007ar-In
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 10:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbcFNIjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2016 04:39:41 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34529 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcFNIjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 04:39:39 -0400
Received: by mail-yw0-f180.google.com with SMTP id c72so148334720ywb.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O8yw5Q7RNvYli/w+M+3joo234+KXhjgjXkw0I9ljm1Y=;
        b=mWtUNnjSSYY0Vuh2dcmBImyrHByQ1jkcv/ozszggjqyKouiW07dSTEX9ForZ//rcun
         XZcKVji03M+s9Z/gLmqIyESBCHqpU4Th9pz4SXSGEIU87UQxGdff2KX2d2bOGbDnRmic
         /StmGf/y/PQ6ae4FMLXCrmDpk4BRM4zZODLPMty6kwurmYl8DfmnQj+ULj7jBwXNoU4C
         nL3M2sp6HXJYbA/cvZYhoE+P+z55wkeLMmdjhHNZ2qWypkTh2A33/mFRVGpktRBbXFag
         2RAmuVgJjCcWnBSXaEAenyF9+Ckt9s1XEPFMFQTE8nd4zJxwwgEyOue1v5ZulhRhKhnJ
         nTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O8yw5Q7RNvYli/w+M+3joo234+KXhjgjXkw0I9ljm1Y=;
        b=INlIDWqwmKgRc9VxoOlotCTh9Exb7LDaYOGbPa50o8IkzzooeLLperF5jNDHOzv6Zd
         V9QvyF4vFeiOIboU2kIAuqV5vmIwu8/xC108fDHFKGdQ4+nv1fa6idoCLYA7/0PgZwTw
         j/KwZB6Ze778FRdUXt46lElWzj21vSRopOghMCRExrXgiKif0DtseYhOfpI0BR9+oaFU
         i6B/iYXx5d8oMzSiBLyHkkvdywlZQvWy/KcnO/qISJWQq1gZUFWU3k1Rb9ejAanE+cpz
         bBOQ9orn21N8xjJS8A2z77379XQusDp+sqnxr+Nkv3bFkjpCvBaVwHEDUjWehC57pPv+
         mW+Q==
X-Gm-Message-State: ALyK8tK4UhI5KXmt90b14RduHvLtiYCKHBs1AcCRJDkzGJcNKmkkC0t+BfekDtyvqBhdfnY4RVKh4wBaZGByFw==
X-Received: by 10.129.158.16 with SMTP id v16mr1216369ywg.282.1465893578588;
 Tue, 14 Jun 2016 01:39:38 -0700 (PDT)
Received: by 10.129.85.203 with HTTP; Tue, 14 Jun 2016 01:39:38 -0700 (PDT)
In-Reply-To: <20160614081854.GA13457@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297275>

Hi Peff,

I want to set gpg -v to pgp.program, but if I set it, it can't call gpg=
:
```
error: cannot run gpg -v: No such file or directory
error: could not run gpg.
fatal: failed to write commit object
```

I have tried set gpg.program value to `gpg|/tmp/log`, `/usr/bin/gpg
-v`, `gpg -v`, `"/usr/bin/gpg -v"`

only after I set to `gpg` or `/usr/bin/gpg` without any argument, it wi=
ll work.
Sincerely,
=E7=94=B0=E9=9C=87


On Tue, Jun 14, 2016 at 4:18 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 14, 2016 at 04:09:52PM +0800, ZhenTian wrote:
>
>> I have tested sign my work in another project, it works fine, I have
>> committed five times, all commits are signed.
>>
>> I can't find encoded signature block in the output of "git cat-file
>> commit HEAD", only these:
>> ```
>> tree 17a572e349ce2fda47470951b5011b9c2f6533b7
>> parent 2c35701725d34325520acb9b45daf42f64adc536
>> author TianZhen <tianzhen@honovation.com> 1465887785 +0800
>> committer TianZhen <tianzhen@honovation.com> 1465887791 +0800
>>
>> feat: mobile support free freight hint, closed #1417
>> ```
>>
>> Some of my commits are signed, for example I have committed four tim=
es
>> today, only first commit is signed. Is it possible some issue with
>> gpg-agent? I can't find it via `ps -Af | grep gpg`.
>
> Possibly. If you set gpg.program "gpg -v", does it help? You could al=
so
> try setting it to "gpg | /tmp/log" to see what gpg is passing back to
> git.
>
> -Peff
