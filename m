Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89288203F3
	for <e@80x24.org>; Tue, 25 Jul 2017 05:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750771AbdGYFP0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 01:15:26 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36646 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbdGYFPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 01:15:25 -0400
Received: by mail-pf0-f178.google.com with SMTP id z129so15232199pfb.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h8bHz3B+z/vssfYxjibNepGK3hJ81yq6NbOIO9VHuc0=;
        b=M57iECt5FXnOfuYJSRgsEmZ0AYa/tHm4NPlbcQvqLsk1KLMP6x0NjxxtsT5ySqBFZn
         C2m4Mdi36fDdmrQPcVh/fz4RFjglxyfbxwxnGbQv7NVyfQZxE33scUinn42P8LlVhBeJ
         aMM24mW7sDhb9PpjaZ+FEafWl0ACt04k6D+Kv2EKbvgSsALEljrqNbdw3Le6A/I/ONQt
         cFt0r1ksxoyrdLArPr8dPxZlQOWWqK5HAJSRq6hcdKMP74GEBE1Zjys7OqjMFwyWmVH1
         jr9xmuJZO5HIyinST2/koGbDJH39h+dedleXARjNsBbgJnGbF8cfJaCH+0jAH19R9BpJ
         bKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h8bHz3B+z/vssfYxjibNepGK3hJ81yq6NbOIO9VHuc0=;
        b=m/0oKF9c3Z3V782s6inW1hfFBjtryVN9UU+jHQK2seOYkW917+4WKwD8UECP/r+26Y
         Zcz3rtGzKXYxZo23zF8/TCuVUjtNZrVJxUU2p8IPuxPNk+CB4ajSGiNCAicDO7NO7iY6
         Wg8RZO16q3QnsIwdCL3q7WsvAPcuGeh1uZA8rRMkHAjri/Xn8k0gsRNPgV+QXDbxqMXB
         XGYCd5GqR+URYbHVP+BYb61+WX1iD0Szf+h7pk+oV47bdsUcDFzjISsIOy+qptgqW2Zo
         NqOIIGq2i2qxj+0YoFS1LTsTmzQCRzkpKFVzW8fV9fwI0BIqUu9fZTn7WEERvLKm/zCU
         K9Ng==
X-Gm-Message-State: AIVw110ZxB1HmTv2y78VBHA6JJZqCbN+9B2AXJmbtjb2WEhgK7tSx/j5
        LQm+K3HotCCgc0dyLV2Wx9P+2AphcDcJ
X-Received: by 10.84.236.74 with SMTP id h10mr4455556pln.176.1500959419026;
 Mon, 24 Jul 2017 22:10:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Mon, 24 Jul 2017 22:10:18 -0700 (PDT)
In-Reply-To: <C48DBB77-7289-4F8B-B46D-32757B5903CF@o2.pl>
References: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
 <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
 <FE86ED74-D646-4CA8-B931-26BC12B030CB@o2.pl> <xmqqk22ye2rh.fsf@gitster.mtv.corp.google.com>
 <xmqqr2x5d0s9.fsf@gitster.mtv.corp.google.com> <C48DBB77-7289-4F8B-B46D-32757B5903CF@o2.pl>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Jul 2017 22:10:18 -0700
Message-ID: <CAGZ79kbgzHZ85ODquMsVPQX2zbMBi0fOq2nB7FX56Zope8irDQ@mail.gmail.com>
Subject: Re: [PATCH v3] merge: add a --signoff flag.
To:     lukaszgryglicki <lukaszgryglicki@o2.pl>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 10:00 PM, lukaszgryglicki <lukaszgryglicki@o2.pl> w=
rote:
> I can't reach Him, every time I send an email it is returned "no such add=
ress".
> Can You please ask Him to take a look?

Junio referred to
https://public-inbox.org/git/87fueferd4.fsf@gmail.com/
His actual email address is in the cc list.



>> On 24 Jul 2017, at 22:42, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> lukaszgryglicki <lukaszgryglicki@o2.pl> writes:
>>>
>>>> Hi, what is the state of this patch?
>>>
>>> I was expecting you to respond to =C3=86var's <87tw2sbnyl.fsf@gmail.com=
>
>>> to explain how your new version addresses his concerns, or him to
>>> respond to your new patch to say that it addresses his concerns
>>> adequately.  I think neither has happened, so the topic is still in
>>> limbo, I guess...
>>
>> Sorry, =C3=86var's message I meant was <87fueferd4.fsf@gmail.com>.
>
