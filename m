Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55891F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeDSRcg (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:32:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51065 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752804AbeDSRcf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 13:32:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4296E4511;
        Thu, 19 Apr 2018 13:32:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=XOPqgl6aTvcmM
        34phj24P5w1Fh4=; b=wuCxckN3JXBaLSooLcKm/LT7EdNI/tBn+6db0PLiJAfLH
        W3+T2AkCFHkw0zaiCoZWq5Bbr6Qkxg+GzNq4FU70/NYUJrSD8Jri1Ua2obIhAVzk
        zxPz7kdOs4f63TyHFvkb4etW1ArOwQ1Stwc15IeSxiHszZZz1G4hxReWHaHEUU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=CHn/noI
        qH8reeUUFCf2kCdknLrzIbaj2NGPxJOKVVT/haajog+2EiRqZnk0aSkcN44TZqXR
        5hmqTXt7aluaEaZGcLBlZo4nyiC/6rAnk/u7add0SHA1Eq1mCPqgLD/D/4g1EOHn
        EEndgXW+pz0Qjs6mt2LzXYqd0fc2OYl+o+zM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CBBEE4510;
        Thu, 19 Apr 2018 13:32:32 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 285EFE450F;
        Thu, 19 Apr 2018 13:32:32 -0400 (EDT)
Date:   Thu, 19 Apr 2018 13:32:30 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] doc/clone: update caption for GIT URLS cross-reference
Message-ID: <20180419173230.GZ29831@zaya.teonanacatl.net>
References: <alpine.LFD.2.21.1804160538100.3564@localhost.localdomain>
 <87y3hn5drx.fsf@linux-m68k.org>
 <alpine.LFD.2.21.1804160918120.6924@localhost.localdomain>
 <CA+P7+xrDsPXA6Bq77gYwWtc16Dz4drg+CHA80=vBNB9-NhxHVg@mail.gmail.com>
 <xmqqefjewxr4.fsf@gitster-ct.c.googlers.com>
 <alpine.LFD.2.21.1804170831190.6019@localhost.localdomain>
 <CA+P7+xrebnWe_6P0uGu2yEmXZ0+qjpykjrv39Nhd2hUPzO_96g@mail.gmail.com>
 <xmqqd0yxl6n9.fsf@gitster-ct.c.googlers.com>
 <20180418205635.GU29831@zaya.teonanacatl.net>
 <CAN0heSrrpvRXGi1hzUuRqXcQCOJQcBcLWAWQKXrivx6tkxAsBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAN0heSrrpvRXGi1hzUuRqXcQCOJQcBcLWAWQKXrivx6tkxAsBw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: A402F304-43F7-11E8-8CD1-67830C78B957-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of the <repository> argument directs readers to "See the
URLS section below".  When generating HTML this becomes a link to the
"GIT URLS" section.  When reading the man page in a terminal, the
caption is slightly misleading.  Use "GIT URLS" as the caption to avoid
any confusion.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Martin =C5gren wrote:
> On 18 April 2018 at 22:56, Todd Zullinger <tmz@pobox.com> wrote:
>> Subject: [PATCH] doc/clone: update caption for GIT URLS cross-referenc=
e
>>
>> The description of the <repository> argument directs readers to "See t=
he
>> URLS section below".  When generating HTML this becomes a link to the
>> "GIT URLS" section.  When reading the man page in a terminal, the
>> caption is slightly misleading.  Use "GIT URLS" as the caption to avoi=
d
>> an confusion.
>=20
> s/an/any/?

Indeed, thanks.

>> The man page produced by asciidoc doesn't include hyperlinks.  The
>> description of the <repository> argument simply
>=20
> Abandoned first attempt at log message? ;-)

That or it was when a squirrel ran by my window. ;)

Thanks for catching both of these mistakes.

 Documentation/git-clone.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 42ca7b5095..b844b9957c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -260,7 +260,7 @@ or `--mirror` is given)
=20
 <repository>::
 	The (possibly remote) repository to clone from.  See the
-	<<URLS,URLS>> section below for more information on specifying
+	<<URLS,GIT URLS>> section below for more information on specifying
 	repositories.
=20
 <directory>::
--=20
2.17.0

--=20
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Whenever you find yourself on the side of the majority, it is time to
pause and reflect.
    -- Mark Twain

