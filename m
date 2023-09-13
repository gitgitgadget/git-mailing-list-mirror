Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA13CA5505
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 08:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbjIMILN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 04:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjIMILF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 04:11:05 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2251198E
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 01:11:00 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id E70952408D;
        Wed, 13 Sep 2023 04:10:57 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qgKxd-H1v-00; Wed, 13 Sep 2023 10:10:57 +0200
Date:   Wed, 13 Sep 2023 10:10:57 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 02/32] doc hash-function-transition: Augment
 compatObjectFormat with readCompatMap
Message-ID: <ZQFukZ4q2Ehen8Yn@ugly>
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
 <20230908231049.2035003-2-ebiederm@xmission.com>
 <ZP3UCQf+9D/J3wqT@tapette.crustytoothpaste.net>
 <xmqqy1hdi6hp.fsf@gitster.g>
 <87sf7kd5xg.fsf_-_@email.froward.int.ebiederm.org>
 <87ledcb7ec.fsf_-_@email.froward.int.ebiederm.org>
 <ZQAZ19gyvt8ab7f6@ugly>
 <87msxr8uc1.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87msxr8uc1.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2023 at 07:11:26AM -0500, Eric W. Biederman wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> On Mon, Sep 11, 2023 at 06:46:19PM -0500, Eric W. Biederman wrote:
>>>+The difference between compatObjectFormat and readCompatMap would be that
>>>+compatObjectFormat would ask git to read existing maps, but would not ask
>>>+git to write or create them.
>>> 
>> the argument makes sense, but the asymmetry in the naming bugs me. in particular
>> "[read]compatMap" seems too non-descript.
>
>I am open to suggestions for better names.
>
isn't readCompatObjectFormat an obvious choice?
(and for symmetry, the other then would be writeCompatObjectFormat, i 
guess.)

regards
