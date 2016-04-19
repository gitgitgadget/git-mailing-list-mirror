From: Jan Durovec <jan.durovec@gmail.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 23:25:05 +0200
Message-ID: <CABEqOBx4vCUpYTGYM9VF6QHxGGgQSG5APSHymtbV7uVxAbU+ow@mail.gmail.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
	<CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
	<xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:25:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asd91-0001bP-I8
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 23:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009AbcDSVZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 17:25:09 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36166 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbcDSVZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 17:25:07 -0400
Received: by mail-qk0-f196.google.com with SMTP id l68so1412491qkf.3
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 14:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=6onsu8hctBwLxjtn4VIuKlXHB5F6qoB+Z1WCU9aQIoA=;
        b=lbvEUoWJpBqdNEd6qg8BK4O/V4QrTR1SrOy8Y7IRI2xzub8w+XGUEuWxr/KvazuYFu
         ZRfe9cIK/WCIMMNOhJTaUDEcNgAxMSPhSwAvwkwJ+hPYjAOFkHZW+Qndpp5Z4qWFmTKD
         1NlgmuamwtZWG276pF/IGe2NtGyh3eQNaVgBNxeHvSAYATayWLH5rRQhSbt5MHZHyfdb
         AJsTu7AEyHsiwfv9eoLC6dab5GoInYSAIXzBwOU9S6z3mt6K94T4w2Gt/j3Jl4x6sS+D
         tXCIQY/ecn/FLApdCVXNMSviZCNQXqRHzEb8rysoX+QTbCWWhpJlZYoQMssovCoJywGj
         7HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=6onsu8hctBwLxjtn4VIuKlXHB5F6qoB+Z1WCU9aQIoA=;
        b=FMXOvaswl8Ba7GADRKzqw2CKZMzk3Jl/NJL9VHIWfm+3aiJxYh9nQBqpxUvZu8PtzG
         VuMfpDyoGC5mFPxUWPFp9Brfo8oOAV/dkXIlx3lcuibm1XzCMABc9lif7pTNitY1rdTS
         v83huz1pvW2o0cdDQV+FuXVBBIxzqUrPQCBct0xgg2Vl9QZy6WFCk2PdM2h+PXI+FGNL
         IvSgHJBK8e/WgvIgpsoswS7ouy48PH2QSdhrw/mF8N75EmnuSsnfepl7cqHJxH59xf6e
         C9rNXQ7IxrUrBPKFyDOReeFdcVM5OYfoSI44rTvhh/9Y3xAqKco/GLyVE2BOsIecrdkI
         kNnw==
X-Gm-Message-State: AOPr4FUEuqJ2Eap2c8izPTtTq1oWaUzkYsRNTeRvU0PD1X4F6dXenaMlxT5rieiMpVEzrBKtVf/F3KbdLRILHQ==
X-Received: by 10.55.117.10 with SMTP id q10mr6756258qkc.103.1461101105519;
 Tue, 19 Apr 2016 14:25:05 -0700 (PDT)
Received: by 10.55.49.10 with HTTP; Tue, 19 Apr 2016 14:25:05 -0700 (PDT)
In-Reply-To: <xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291929>

There's a comment on PR itself (in addition to individual commits) so
theoretically it could.

It seems that for [PATCH ... n/m] e-mails the commit messages are used,
so there's no reason why the PR comment couldn't be used for a cover
letter.

In this case the PR comment was the same as for one of the commits.
Maybe submitGit tried to be smart there? Or maybe it just really
doesn't support it (yet?).

On Tue, Apr 19, 2016 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jan Durovec <jan.durovec@gmail.com> writes:
>
>> On Tue, Apr 19, 2016 at 8:50 PM, Jan Durovec <jan.durovec@gmail.com> wrote:
>>>> Any submitGit users?  I think it lets you throw multiple-patch
>>>> series just fine.  In this case, you'd prepare a two patch series on
>>>> a branch, 1/2 being the clean-up and 2/2 being the new feature, and
>>>> if you give that branch to submitGit as a whole it should do the
>>>> right thing, I'd imagine.
>>>
>>> Hm... I'll see what it does with a pull request that has 2 commits.
>>
>> Huh... seems that it works :)
>>
>> v3 sent in 2 parts
>
> Thanks.
>
> For a series this small it does not matter, but anything longer it
> would be easier to review with a cover letter (i.e. [PATCH 0/N]).  I
> do not know if submitGit lets us do that, though.
