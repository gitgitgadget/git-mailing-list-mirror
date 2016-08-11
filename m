Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137971F859
	for <e@80x24.org>; Thu, 11 Aug 2016 07:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbcHKH7b (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 03:59:31 -0400
Received: from mail-yb0-f180.google.com ([209.85.213.180]:33271 "EHLO
	mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297AbcHKH73 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 03:59:29 -0400
Received: by mail-yb0-f180.google.com with SMTP id e125so21814781ybc.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 00:59:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X6zttjc3cHBKZVwLoqetvZeJ4HBlBQ5/FppHfwwbiec=;
        b=uyb3whuiZJ8EZbwZeM5C1gS1xoJEwZwJn00nurBzwZbkSjbMw3RdIKkLsyYO8DahOT
         nRB3uQvKGiysG4MaN6VhScScTW6RdyUa/xGAYzeXYYx84F0axkGao5Ru3FDea7lXf7Ke
         XEOSOMg5FI81klD3hb7I0uW+gi7AEofo1NmyYyeIeeNp4t921cPdG8z55aDZ0mS25m2L
         tWjb1GxN65lsxB5u0Wzm1oHxk8FZsqLb6tY5VYtZJ/VV8xVLW2N6wsDcJIPXh3QzN51K
         HgkfYgW7/DnobeHY69QWArRvRv+Y2JW7nU2BIZuEUs5ArUbqeTcb6N5mUGBj5HHARKaF
         oQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X6zttjc3cHBKZVwLoqetvZeJ4HBlBQ5/FppHfwwbiec=;
        b=AZAl4TwD5wNrxgLluDTBQxIPyULtFZ9npJY7cDRfE3KaYCE3Qev6PZ2hrKhjzOkIOZ
         WmOpTxYdR/1G7GWYn0CDpw+icmzXzOR+bMeVa9ZtFCLxJHWE0rnIOyVSpRe5SMiDMwQR
         LrF5LZ4klRFhDWiyMSKLEBo5Su0eGN3rxCEmShzLad/1HGSn73CV0p7XwpWA83SZBq9h
         tBewjvgcEOADCdHlmCQo5oNQnMFQpspDV+XaV99LVlQhS1hv4xHlvjt3X4rSrFAcMsK/
         xxYPY08mGdIqEblo7uXxeOoyh6Myl4WtXG/pCosYL/AVST4f/O4VDAAn3BtRBxSBVEQm
         /mSQ==
X-Gm-Message-State: AEkoous0Fc2nF6mrQHX/6EoPmzkKZHD92qlaQvy8YQTx9RLL0qAAvr73qQnJxAgSihDV8ngeNrOhkVZHNWGEXw==
X-Received: by 10.37.65.138 with SMTP id o132mr5345826yba.136.1470902368962;
 Thu, 11 Aug 2016 00:59:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Thu, 11 Aug 2016 00:59:08 -0700 (PDT)
In-Reply-To: <CA+P7+xpyCQLsEHE-Hqqob5mQisW=aw1gC+5f6Qq3q01etjX2Ng@mail.gmail.com>
References: <D8F2D8316A4C4E198C6847C1165A8811@PhilipOakley> <CA+P7+xpyCQLsEHE-Hqqob5mQisW=aw1gC+5f6Qq3q01etjX2Ng@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Thu, 11 Aug 2016 00:59:08 -0700
Message-ID: <CA+P7+xrBegRdS-HXi2SfO0Uu6N=gUVVp_F29GCb1rQn9cnxnHQ@mail.gmail.com>
Subject: Re: Can cc's be included in patches sent by send-email
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 12:58 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Aug 11, 2016 at 12:32 AM, Philip Oakley <philipoakley@iee.org> wrote:
>> While 'git send-email' can have multiple --cc="addressee" options on the
>> command line, is it possible for the "cc:addressee<a@b.c>" to actually be
>> included in the patches that are to be sent, so that different patches can
>> have different addressee?
>>
>> The fortmat-patch can include appropriate from lines, so it feels as if the
>> sender should be able to add cc: lines at the same place. Maybe its just
>> part of th docs I've missed.
>>
>
> Yes, just put them in the body as tags below the signed-off-by. It
> should be on by default unless you change supresscc or signedoffbycc
> configuration.
>
> Thanks,
> Jake
>

See --suppress-cc or --signed-off-by-cc help in git help send-email.

Thanks,
Jake
