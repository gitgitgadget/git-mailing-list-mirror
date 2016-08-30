Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B8C1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 18:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756178AbcH3So2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:44:28 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33948 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755833AbcH3So1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:44:27 -0400
Received: by mail-yw0-f182.google.com with SMTP id z8so16922056ywa.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sVJC82C791BVC2dJIj2xTKaWWMTsidTrrLkpwOnSYD4=;
        b=ping5tMx0UnK0+YMkEBAb/Dc/eqFRPlTX6dZoNRPcibq7bsh+VPiLKqatTESPY1RMO
         24Irdq5HTJCvxs3wYTM0PQdxFPW2Xi2hH/tndBQDr+47PPlR++rJaz/nddF6vvaCHl0v
         mRRauz83HWyLl+jPfLYWol2D1d1Ilbp+rKNMfsBk8j8tg7n7bTMNYdibKyrtg0HPzyzU
         jwfFHvZYHCnMF4bM5VPEi1+j0C7njDqTMB4zqbZ0dNd9CbTRSw9KgNm+fgJQv6NOy4V/
         jcLe/ASyQJpq7KUiLqGJKFpgMrIUwOJ/woQY+nti89pZk5sb6A/DksQxFGeXYaJAP1Bx
         foOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sVJC82C791BVC2dJIj2xTKaWWMTsidTrrLkpwOnSYD4=;
        b=Y1JvGZSuYemdX+SnDSsa7Drhwl9AdT5lBPbsSP7T7JGg++aq4RxOjqrQrqVF0htVG8
         PtEbUlsjEFcm2ZFG+L8oZw9skKevxQLIEDNm0f1iCWnp8Jt7JmTt+Y7Sze//00AZJgZ+
         /s2VjhCR1ri961F5Nh0EKMb3Q1byIIrSJCK05m44zf4LqNZzmxpx+8GRrxd2TJ3R5oEQ
         Dh5lgbf20L1i6xJyOTAreEZPDzsPaFPBymwQRUq9a9HWDd8DswZaYGdGYlmvySpRI4YL
         Kmjwa0QQcYVQtAK/Hjsi3CKRZvpvDCxV+ALhyHVBxs2cBvpLPztQ+B6JTRd6pz/bncmY
         GT6A==
X-Gm-Message-State: AE9vXwMkVDbd24+QOX58MOLp0rM5dnWSZ7B0YjNPTnvyIOQexRmflMd52is1DO14NO672tOvRoRnnJ5QwfD5Ww==
X-Received: by 10.129.50.147 with SMTP id y141mr4670164ywy.305.1472582666452;
 Tue, 30 Aug 2016 11:44:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Tue, 30 Aug 2016 11:44:25 -0700 (PDT)
In-Reply-To: <CAFZEwPP-c00aNvDKoQFiCf_-tqrP3tAwwU6KAnswfMkjyoP3QQ@mail.gmail.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6ce-3b204354-849b-40fd-93ff-2ebcf77df91c-000000@eu-west-1.amazonses.com>
 <xmqq37lsmw15.fsf@gitster.mtv.corp.google.com> <CAFZEwPP-c00aNvDKoQFiCf_-tqrP3tAwwU6KAnswfMkjyoP3QQ@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 31 Aug 2016 00:14:25 +0530
Message-ID: <CAFZEwPOt6aXA+URVzH8_=U+D=sMN=+Brp+15T=RWA=+D09fP9Q@mail.gmail.com>
Subject: Re: [PATCH v14 14/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary=001a1140901cbc98cd053b4e5e91
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a1140901cbc98cd053b4e5e91
Content-Type: text/plain; charset=UTF-8

Hey Junio,

On Tue, Aug 30, 2016 at 11:55 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>
>>> @@ -729,7 +735,7 @@ static struct commit **get_bad_and_good_commits(int *rev_nr)
>>>       return rev;
>>>  }
>>>
>>> -static void handle_bad_merge_base(void)
>>> +static int handle_bad_merge_base(void)
>>>  {
>>>       if (is_expected_rev(current_bad_oid)) {
>>>               char *bad_hex = oid_to_hex(current_bad_oid);
>>> @@ -750,17 +756,18 @@ static void handle_bad_merge_base(void)
>>>                               "between %s and [%s].\n"),
>>>                               bad_hex, term_bad, term_good, bad_hex, good_hex);
>>>               }
>>> -             exit(3);
>>> +             return 3;
>>>       }
>>>
>>>       fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
>>>               "git bisect cannot work properly in this case.\n"
>>>               "Maybe you mistook %s and %s revs?\n"),
>>>               term_good, term_bad, term_good, term_bad);
>>> -     exit(1);
>>> +     bisect_clean_state();
>>> +     return 1;
>>
>> What is the logic behind this function sometimes clean the state,
>> and some other times do not, when it makes an error-return?  We see
>> above that "return 3" codepath leaves the state behind.
>>
>> Either you forgot a necessary clean_state in "return 3" codepath,
>> or you forgot to document why the distinction exists in the in-code
>> comment for the function.  I cannot tell which, but I am leaning
>> towards guessing that it is the former.
>
> This is a very tricky one. I have purposely not included this after a
> lot of testing. I have hand tested with the original git and with this
> branch. The reason why anyone wouldn't be able to catch this is
> because its not covered in the test suite. I am including a patch with
> this as an attachment (because I am behind a proxy right now but don't
> worry I will include this as a commit in the next series). The
> original behaviour of git does not clean the bisect state when this
> situation occurs. On another note which you might have missed that
> bisect_clean_state() is purposely put before return 1 which is covered
> by the test suite. You can try removing it and see that there is a
> broken tes. tI was thinking of including the tests after the whole
> conversion but now I think including this before will make the
> conversion more easier for review.

The patch which I included as an attachment before will fail for
different reasons if you apply it on master branch. To test it on
master branch use the current attachment. Again sorry I couldn't
include this in the email itself.

Regards,
Pranit Bauva

--001a1140901cbc98cd053b4e5e91
Content-Type: application/octet-stream; name=out3
Content-Disposition: attachment; filename=out3
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ishtkx311

ZGlmZiAtLWdpdCBhL3QvdDYwMzAtYmlzZWN0LXBvcmNlbGFpbi5zaCBiL3QvdDYwMzAtYmlzZWN0
LXBvcmNlbGFpbi5zaAppbmRleCA1ZTUzNzBmLi5mYTNmNWI2IDEwMDc1NQotLS0gYS90L3Q2MDMw
LWJpc2VjdC1wb3JjZWxhaW4uc2gKKysrIGIvdC90NjAzMC1iaXNlY3QtcG9yY2VsYWluLnNoCkBA
IC04OTQsNCArODk0LDEwIEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2Jpc2VjdCBzdGFydCB0YWtl
cyBvcHRpb25zIGFuZCByZXZzIGluIGFueSBvcmRlcicgJwogCXRlc3RfY21wIGV4cGVjdGVkIGFj
dHVhbAogJwogCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdjJyAnCisJZ2l0IGJpc2VjdCBzdGFydCAk
U0lERTcgJFNJREVfSEFTSDcgJiYKKwl0ZXN0X211c3RfZmFpbCBnaXQgYmlzZWN0IGJhZCA+b3V0
IDI+b3V0ICYmCisJdGVzdCAtZSAuZ2l0L0JJU0VDVF9TVEFSVAorJworCiB0ZXN0X2RvbmUK
--001a1140901cbc98cd053b4e5e91--
