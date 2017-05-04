Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3323D207F8
	for <e@80x24.org>; Thu,  4 May 2017 07:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbdEDHsh (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 03:48:37 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:36000 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752431AbdEDHsg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 03:48:36 -0400
Received: by mail-io0-f179.google.com with SMTP id p80so11885041iop.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 00:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5plzYZ42iAXjbU3uBzV2kgWkqAVHB6lYXgzV5hEO/KM=;
        b=aclRrAj5TVQHTkv3bFKrWlfjR5Q3ivJDiSW2IUvf5tK/Aw0NuefBU5kd9q+f62ackf
         hmf+4rn4+fMSUZ4x6puNOC66/zSRrMIAW0qDE+RXlfoOacjerUpNMza4PEbGWWKs4yVR
         HaBhEPgY7kGGyoLBRFe7BtFL1CX6db8Tz/dtTH16bDN4XVwuOEsYwfR5CPjTpPqGRqVj
         Drw7EkdXel1LW9qeRpP1HORmm4TZFIq6Zsn+1d61tLZmefRpfvDLbrcgbg1/ZetEqLNr
         q3izqECjn+13iOTf4ggV1W8wl1n8OkERjzu+ZOHVgMOwRMEIP/GsCztFqBgeFw/LyirF
         4VLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5plzYZ42iAXjbU3uBzV2kgWkqAVHB6lYXgzV5hEO/KM=;
        b=NDq1X5VHdVTEiYUflHW4nw1z0F/joxoSPMuKfAQN9V1pvawEkQVWUZqT/M/E+zBwCN
         FhroAz/81I8P821n3ZJi0ZNyiVdVgH3XO9iHdX0+Kgue+OCAELR6fvJgI8mB64VuRkh0
         uXUyBuMlvz076jwPwW3pXsUR2PIlTbNKUGDwJBKG5SNJxJ1DCm7w47LfY37gfPzCWJjT
         dM87DDAnydJC/tU3s6HYY3A8TBPsIZd+B1ahoqVpASWCnxOGh9Exguoa0sgZQc5vOHUr
         N7NWnHGv9KNYiQLYD21neylMttNNzo1GocrixyfgKTbTLfQFFC6bWgxMXb3ITttMjrHI
         U3pg==
X-Gm-Message-State: AN3rC/55TPzOnltmQcLWq/JnC0mr5a8TpQQwTY6FEk1renIPmVDIerSP
        CCz0ZEIFr7GmCoUtbDlv0AyqGRloqw==
X-Received: by 10.107.138.9 with SMTP id m9mr37151610iod.80.1493884115248;
 Thu, 04 May 2017 00:48:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 4 May 2017 00:48:14 -0700 (PDT)
In-Reply-To: <xmqqk25xct1w.fsf@gitster.mtv.corp.google.com>
References: <20170429122632.7122-1-zxq_yx_007@163.com> <xmqqo9vdiboz.fsf@gitster.mtv.corp.google.com>
 <743D62FA-65B9-4DCC-978E-DAF442AE0B0D@163.com> <CACBZZX6fursxEaBGr9raz+x8qBm0WZrmHCkMbtpajRzOM3B6qA@mail.gmail.com>
 <xmqqk25xct1w.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 4 May 2017 09:48:14 +0200
Message-ID: <CACBZZX4zgNXBxCUP3tWrB6KAvVftxQX65tF8L8YJaqm4VrVqcQ@mail.gmail.com>
Subject: Re: [PATCH] send-email: new option to walkaround email server limits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>,
        Git Mailing List <git@vger.kernel.org>,
        viktorin@rehivetech.com, mst@kernel.org, pbonzini@redhat.com,
        mina86@mina86.com, Ramkumar Ramachandra <artagnon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 4, 2017 at 3:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> It makes sense to have a configurable delay for git-send-email
>> unrelated to this option, I'd use a facility like that.
>>
>> A lot of mail clients just sort based on date/msgid or whatever not
>> date/subject, so the rapid-fire output of send-email often arrives out
>> of order because it's all sent at the same second. I'd use some option
>> where I could send a series as "all" and have it sleep(N) in between
>> sending mails.
>
> Hmph.  When sending many messages, send-email first grabs the
> current time, counts backwards N seconds for N message series,
> and uses that timestamp that is N seconds in the past for the first
> message, incrementing the timestamp by 1 second per each subsequent
> ones.
>
> I found that this trick is sufficient to cause receiving MUAs sort
> messages based on date, as the Date: field will have the timestamps
> that increases by 1 second in between messages in a batch.
>
> There might be MUAs that do not use the value of the Date: field
> when told to sort by date (perhaps they use the timestamp of the
> message file they received at the final hop to them?), but it is
> hopeless to help such MUAs unless the mail path guarantees the order
> at the originator, which is not how "store and forward" e-mails
> work.

As Ramkumar points out many MUAs don't sort by Date because of mail
delays / inaccurate sender clocks. Fun fact: You happen to work for a
company making one such MUA :)

E.g. just to name one example in my GMail view (it's full of this sort
of thing) Stefan Beller's recent cache.h series starts in the order
01/03/02 (and continues out of order).

The Date headers on the messages themselves are incremented by 1
second as you note, but on those first 3x the Recieved chain ends in
this for all 3:

    Received: by 10.28.48.210 with SMTP id w201csp570755wmw;
            Tue, 2 May 2017 15:24:50 -0700 (PDT)

I.e. all Received on the same second, showing that the Date header is
ignored by GMail, just from observing it GMail's sort function seems
to be (pseudocode):

    a['Received'] <=3D> b['Reiceved'] || a['GMailInternalID'] <=3D>
b['GMailInternalID']

Not:

    a['Received'] <=3D> b['Reiceved'] || a['MessageID'] <=3D>
b['MessageID'] || a['GMailInternalID'] <=3D> b['GMailInternalID']

Or:

    a['Received'] <=3D> b['Reiceved'] || a['Subject'] <=3D> b['Subject']
|| a['MessageID'] <=3D> b['MessageID'] || a['GMailInternalID'] <=3D>
b['GMailInternalID']

Or:

    a['Received'] <=3D> b['Reiceved'] || a['Date'] <=3D> b['Date'] ....

Anyway, you get the idea, but all of these would cause it to show
git-send-email list traffic in order, since while the Received field
is the same both Date & MessageID is different & sortable (actually
not quite, but that's another matter).

When I send my own patches with git-send-email I tend to sit there
hitting "y" in succession instead of doing "a" because I like being
able to browse my patches in order, which I guess tells you something
about my tolerance for tedium before submitting a patch to sleep().

If you look at GMail's web view you can effectively also see how close
someone is to Google's servers by how out of order their patches are,
e.g. your patches, Stefan's etc. & other Google employees working in
SV are pretty much entirely shuffled, whereas Michael Haggerty's are
pretty much in order because his mailpath involves a transatlantic &
trans-US-costal route before being delivered.
