From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t4151 missing quotes
Date: Mon, 9 May 2016 17:35:11 -0400
Message-ID: <CAPig+cSRUqSQZ1G73X6szfXjJEwopaO20H_k2vrmmy1qpEftLQ@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
	<CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
	<xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
	<CAPig+cS4Bj4N8d1a29z8=f30owOec1pB=yF32ZUPmDH2Tu2kXA@mail.gmail.com>
	<xmqqmvnzt0yx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 23:35:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azspk-0002SX-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 23:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbcEIVfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 17:35:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33979 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbcEIVfM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 17:35:12 -0400
Received: by mail-io0-f195.google.com with SMTP id d62so19885236iof.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Uki9sT4mDOStGZL8/4L+DXIRgN3tjwbhANsM/mbK1XM=;
        b=gVHoVAzG1PPUG2E/fZmfCQB5wfSGAxl7SMddgyGQHj6z2yAcyVzmvI1sDX6xbc1o2z
         +bVI7gdrQdp18cCxsrL8Mm8SCoPQF5hw+KcA6B4wXlvPipZiEZiMIF9XG/oSWkmNA8Jo
         uIPR1INoRN32n4LJZJ06BhkRLrooU0liqSvQ9lYMtewuQKOfAI2e6RVVfQvRaqqhS+e4
         pRx/2EVef8XUh9E3tlbtUjrVhHzgUKzpHFuIjtBccvxor2SWYREDWOsZcEFb6rhEFQ5u
         ZjhCptndMYniiVRM3BlUSQ/ybZyFrfeuxVJ0n2ff6QJjS47SXDC9l2jtxearF0mnCwrC
         nrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Uki9sT4mDOStGZL8/4L+DXIRgN3tjwbhANsM/mbK1XM=;
        b=fjhD5+xdlvMjMro5Ebz4OA3aiM1XMV8tTbibKkNHYJxt6VYiWOCMcabdGCuUnCAeKy
         lloGc6g5BdSC9elK45n3an9YMHarDTe3Q+ibMJdscYaZ81qnJ3adbw/4Tc6w0xJ4odvx
         fop2Psz1KOhZsC0h3/qdJsizY6E4xTKBcqlhnvnZsF3i5FHAI8sMkzY4U2sFCKlj3i5Q
         BdYSZH3kjfiZ18Hn5rnITNsGHX6TtKKvhNpb3npEyV8BOzK8eBHJrNeBN1PBSdPWcEtq
         T+RpjzzGmWhtDbktndTWsPPZAbR2iS3hWdPIzF6ijUns23BnF1WVo/2mgzH8mX8Au1RP
         rnHA==
X-Gm-Message-State: AOPr4FXJJDda/wDNpkogUHlpSBFR7N2YlsFleXpmu4ogFJCVcwn+ndg2/0Jnzs64QUrhDIE1f22hHCADIfacJg==
X-Received: by 10.107.132.66 with SMTP id g63mr42939379iod.34.1462829711170;
 Mon, 09 May 2016 14:35:11 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 14:35:11 -0700 (PDT)
In-Reply-To: <xmqqmvnzt0yx.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: OSXGZoHV14DbTD22qQRgFaA5mJE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294073>

On Mon, May 9, 2016 at 4:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Mon, May 9, 2016 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Something like this follows Documentation/SubmittingPatches [...]
>>>
>>> -- >8 --
>>> From: Armin Kunaschik <megabreit@googlemail.com>
>>> Subject: t4151: make sure argument to 'test -z' is given
>>>
>>> 88d50724 (am --skip: revert changes introduced by failed 3way merge,
>>> 2015-06-06), unlike all the other patches in the series, forgot to
>>> quote the output from "$(git ls-files -u)" when using it as the
>>> argument to "test -z", leading to a syntax error.
>>
>> To make it clear that this was not a syntax error in the typical case,
>> it might make sense to say:
>>
>>     ...potentially leading to a syntax error if some earlier tests failed.
>
> Hmph, do we have a broken &&-chain?

I don't know. Unfortunately, Armin didn't provide much information in
his initial email, saying only "skipping through some failed tests",
which doesn't necessarily indicate if those tests failed or if he
somehow manually skipped them.

> If an earlier test fails and leaves an unmerged path, "ls-files -u"
> would give some output, so "test -z" would get one or more non-empty
> strings; if we feed multiple, this would fail.  But we would not have
> even run "test -z" as long as we properly &&-chain these tests.
>
> I think the real issue is when the earlier step succeeds and does
> not leave any unmerged path.  In that case, we would run "test -z"
> without anything else on the command line, which would lead to an
> syntax error.
>
>     Side Note: /usr/bin/test and test (built into bash and dash)
>     seem not to care about the lack of string in "test -z <string>"
>     and "test -n <string>".  It appears to me that they just take
>     "-z" and "-n" without "<string>" as a special case of "test
>     <string>" that is fed "-z" or "-n" as <string>.  Apparently, the
>     platform Armin is working on doesn't.

I also tested on Mac OS X and BSD, and they happily accept bare "test
-n", as well (though, I don't doubt that there are old shells which
complain).

> Perhaps
>
>     ... leading to a syntax error on some platforms whose "test"
>     does not interpret "test -z" (no other arguments) as testing if
>     a string "-z" is the null string (which GNU test and test that
>     is built into bash and dash seem to do).
>
> would be an improvement?

Yes, that sounds good.
