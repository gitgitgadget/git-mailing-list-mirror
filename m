Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1637C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBQWEf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 17 Feb 2023 17:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQWEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 17:04:34 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1C85DE31
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 14:04:33 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31HM45Db2896199
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 22:04:05 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Emily Shaffer'" <nasamuffin@google.com>
Cc:     "'Git List'" <git@vger.kernel.org>,
        "'Jonathan Nieder'" <jrn@google.com>,
        "'Jose Lopes'" <jabolopes@google.com>,
        "'Aleksandr Mikhailov'" <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com> <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
In-Reply-To: <Y+/v15TyCbSYzlVg@tapette.crustytoothpaste.net>
Subject: RE: Proposal/Discussion: Turning parts of Git into libraries
Date:   Fri, 17 Feb 2023 17:04:19 -0500
Organization: Nexbridge Inc.
Message-ID: <00b401d9431b$cc3c4460$64b4cd20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG8LXqmDy16wlKS+NWZyvs9ueIudgI5zTgqrvwM64A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, February 17, 2023 4:22 PM, brian m. carlson wrote:
>On 2023-02-17 at 21:12:23, Emily Shaffer wrote:
>> Hi folks,
>
>Hey,
>
>> I'm looking forward to the discussion!
>
>While I'm not personally interested in the VFS work, I think it's a great idea to turn
>more of the code into libraries (or at least make it more library-like), and so I'm fully
>in support of this approach.  When I send patches in the future, I'll try to make sure
>that they're friendly to this goal.

I am uncertain about this, from a licensing standpoint. Typically, when one links in a library from one project, the license from that project may inherit into your own project. AFAIK, GPLv3 has this implied provision - I do not think it is explicit, but the implication seems to be there. Making git libraries has the potential to cause git's license rights to be incorporated into other products. I am suggesting that we would need to tread carefully in this area. Using someone else's DLL is not so bad, as the code is not bound together, but may also cause ambiguities depending on whether the licenses are conflicting or not. I am not suggesting that this is a bad idea, just one that should be handled carefully.

--Randall

