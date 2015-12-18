From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Sat, 19 Dec 2015 00:24:10 +0100
Message-ID: <CAP8UFD16HbwN71ugTKek_CdT65571M1meisaBajjSFgoZePg8g@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
	<xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
	<CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
	<CACsJy8B2tFqhfKPE17cPpp1uDYPa4OTB9zLHPY0j2QF9zuxAtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 00:24:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA4Nk-0001bX-PM
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 00:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbbLRXYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2015 18:24:13 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36587 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbLRXYM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Dec 2015 18:24:12 -0500
Received: by mail-lb0-f178.google.com with SMTP id yq9so52241344lbb.3
        for <git@vger.kernel.org>; Fri, 18 Dec 2015 15:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KCnnGpwIurZSLyRTBP4HQVZ1KnCOFuBscIAuMbb8JKg=;
        b=KGZIAgmcdkKX+m4JL4O76ohfIKmQIDiYHo6SZra0AFB6/nygPVQDfhC5dITGwulxwD
         0+r1hSdp8eBpAZz6i/kS0mSScUgavQlJsDWNdY/5u3cmNlJ8WAtuLmt/Dk94nQf/FEwh
         w8W50b9rWZKomZkmW/hxnf2F4vycYncrAWayBkax4kwruUXX16cR0cWm4TY1kYRaDdK2
         vdD82ZmLpYS4jjXHo/DE6PPV5Sq/eOOWei1OLHc1AWAYRNQmPJWh6GCshUWG2Zfn+WkI
         dDd4F/2SpaB/oHDp4U7jVoKJYJ8gwiGZyoWq7B0MSt8WqQTJR7fwu7HenlAviBS22PJD
         YR9g==
X-Received: by 10.112.150.102 with SMTP id uh6mr2409451lbb.16.1450481050570;
 Fri, 18 Dec 2015 15:24:10 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Fri, 18 Dec 2015 15:24:10 -0800 (PST)
In-Reply-To: <CACsJy8B2tFqhfKPE17cPpp1uDYPa4OTB9zLHPY0j2QF9zuxAtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282720>

On Thu, Dec 17, 2015 at 1:36 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Dec 16, 2015 at 4:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Tue, Dec 15, 2015 at 8:40 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> I still have a problem with the approach from "design cleanliness"
>>> point of view[...]
>>>
>>> In any case I think we already have agreed to disagree on this
>>> point, so there is no use discussing it any longer from my side.  I
>>> am not closing the door to this series, but I am not convinced,
>>> either.  At least not yet.
>>
>> In general the fantastic thing about the git configuration facility =
is
>> that it provides both systems administrators and normal users with
>> what they want. It's possible to configure things system-wide and
>> override those on a user or repository basis.
>>
>> Of course hindsight is 20/20, but I think that given what's been
>> covered in this thread it's been established that it's categorically
>> better that if we introduce features like these that they be
>> configured through the normal configuration facility rather than the
>> configuration being sticky to the index.
>
> A minor note for implementers. We need to check that config is loaded
> first. read-cache.c, being part of the core, does not bother itself
> with config loading. And I think so far it has not used any config
> vars. If a command forgets (*) to load the config, the cache may be
> deleted (if we do it the safe way).
>
> (*) is there any command deliberately avoid loading config? git-clone
> and git-init are special, but for this particular case it's probably
> fine.

Thanks for this note.

Looking at the current patch, the global variable in which the value
of the core.untrackedCache config var is stored is
"use_untracked_cache".
It is used in the following places:

- wt_status_collect_untracked() in wt-status.c which is called only by
"git status" and "git commit" after the config has been loaded.

- cmd_update_index() in builtin/update-index.c which loads the config
before using it

- validate_untracked_cache() in dir.c where it is used in:

       if (use_untracked_cache !=3D 1 && !ident_in_untracked(dir->untra=
cked)) {
                warning(_("Untracked cache is disabled on this system."=
));
                return NULL;
        }

but this "if" and its contents are removed by patch 10/10 in v2.

So at the end of this patch series, there is no risk of
use_untracked_cache not being properly setup.
