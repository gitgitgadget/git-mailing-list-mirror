From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clone: Simplify string handling in guess_dir_name()
Date: Thu, 09 Jul 2015 11:40:36 -0700
Message-ID: <xmqqsi8xuqcb.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuPkia6UYeN4jekfGzypV2MpyiMs2W+O=SSJR3hR=K3g0A@mail.gmail.com>
	<0000014e73d7c3d8-413991dd-3907-430c-ab99-a0a3d93dcab0-000000@eu-west-1.amazonses.com>
	<xmqq1tghw6jz.fsf@gitster.dls.corp.google.com>
	<CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 20:40:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDGkZ-0008LT-RF
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 20:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbbGISko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 14:40:44 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35280 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbbGISkn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 14:40:43 -0400
Received: by iecuq6 with SMTP id uq6so182455306iec.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 11:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oKUcGeDOWZiyPx4ypcZACb0nwy7pc9yxHt6VA3m57N0=;
        b=CrNpSCfzGQoWh02+o9nK7mTr3mcyNEcZ7JcpmvGU6MulvNnVILEnDuG8D3uBu9am05
         FwW0EoXHKk9LwxzoPt1jgLwTce/m7uE+J0lKnBCwFA6QaOZm13IF0pRvPIaylgGJ6f5j
         Cjo0tu1tUIwI9O2MV2iP2M3OPSPRVmZUxBM0pOp8e1l0d5VY0wxgR56nUAwFc7rORuul
         Lgn0vZWAZUpL8C0r+1o8D3if+d+M9SaDiFhZM6IyvAyUocCDKNUp8DkRfaxXOc4pS0gE
         iRuKqrt88rJ2+vceYCrrxmBQ4em4q2rNEFSqpQyNd+qzP9YzQjyaxSo5g2YlHF3ITExv
         eiDQ==
X-Received: by 10.107.156.140 with SMTP id f134mr3431020ioe.34.1436467242590;
        Thu, 09 Jul 2015 11:40:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id z195sm4727537iod.33.2015.07.09.11.40.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 11:40:39 -0700 (PDT)
In-Reply-To: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 9 Jul 2015 20:16:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273770>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Thu, Jul 9, 2015 at 8:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>> Content-Type: multipart/mixed;  boundary="----=_Part_8_836493213.1436462597065"
>>
>> Please don't.
>
> This seems to come from submitgit, I've filed an issue about it:
>
> https://github.com/rtyley/submitgit/issues/17
>
> What content type(s) would you accept? Only text/plain?

I could take anything, even chicken scratches on a piece of paper,
for a small change like this.

But let's make sure we see text/plain out of "submitgit", as the
whole point of it is to allow people generate the common denominator
format out of a commit pushed to GitHub.

Thanks for letting them know.
