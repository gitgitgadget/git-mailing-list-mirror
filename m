Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16DBC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 23:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCWXor convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 23 Mar 2023 19:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjCWXoq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 19:44:46 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCF0AD11
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 16:44:40 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 32NNhwt12923786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 23:43:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Emily Shaffer'" <nasamuffin@google.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Jonathan Nieder'" <jrn@google.com>,
        "'Jose Lopes'" <jabolopes@google.com>,
        "'Aleksandr Mikhailov'" <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com> <CAMP44s2AMrXCN6f6v-W0sqb++TVfHf7Q1miJE7iZjZOVwFQa0Q@mail.gmail.com>
In-Reply-To: <CAMP44s2AMrXCN6f6v-W0sqb++TVfHf7Q1miJE7iZjZOVwFQa0Q@mail.gmail.com>
Subject: RE: Proposal/Discussion: Turning parts of Git into libraries
Date:   Thu, 23 Mar 2023 19:44:31 -0400
Organization: Nexbridge Inc.
Message-ID: <000001d95de1$6de529a0$49af7ce0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG8LXqmDy16wlKS+NWZyvs9ueIudgH4ewGurzOj6FA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, March 23, 2023 7:37 PM, Felipe Contreras wrote:
>On Fri, Feb 17, 2023 at 3:45 PM Emily Shaffer <nasamuffin@google.com> wrote:
>
>> As I mentioned in standup this week[1], my colleagues and I at Google
>> have become very interested in converting parts of Git into libraries
>> usable by external programs. In other words, for some modules which
>> already have clear boundaries inside of Git - like config.[ch],
>> strbuf.[ch], etc. - we want to remove some implicit dependencies, like
>> references to globals, and make explicit other dependencies, like
>> references to other modules within Git. Eventually, we'd like both for
>> an external program to use Git libraries within its own process, and
>> for Git to be given an alternative implementation of a library it uses
>> internally (like a plugin at runtime).
>
>This is obviously the way it should have been done from the beginning, but
>unfortunately at this point the Git project has too much inertia and too many vested
>interests from multi-billion dollar corporations to change.
>
>I wonder if a single person who isn't paid to work on Git commented on this thread.

Raises hand.

