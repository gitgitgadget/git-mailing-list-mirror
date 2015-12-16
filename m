From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Wed, 16 Dec 2015 02:10:06 +0100
Message-ID: <CACBZZX4joSbCTGQqN=u6FjG2V1-7T+0P+KDwZYi14a-9OQV=LQ@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
 <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
 <xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com> <xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
 <xmqq6100ke7v.fsf@gitster.mtv.corp.google.com> <xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
 <CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
 <xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com> <CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
 <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 02:11:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a90cT-0003wQ-9E
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 02:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbbLPBK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Dec 2015 20:10:27 -0500
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36486 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932632AbbLPBK0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Dec 2015 20:10:26 -0500
Received: by mail-qg0-f53.google.com with SMTP id 103so22766335qgi.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 17:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=iW3LO/ozBLVpUvRyZ3zVqYZmtGdWJLcHVQGrVCg9Mrs=;
        b=ijdgRQ0M+tDDYBfFt+tUJpmPX+Zt6gxhcpPFutcSCFkI7TCCcCUkp+3NMk5lTBIaO3
         JFukw6V/Rf2SN1li4ZtNSdRK/C5+zPS+b9re9yAKn5rAvrm4Tnr2CaNoRPv2hZA0BoeU
         QY7RejRBlhpaeP/hicx0nzgCcxFAsSNZan0aEBo/2HPcw2DkaXX7VrTeaSAx0wyTT3GV
         GyssaVtIk3FVhi/gV1THm0yg0WWSGhstKmFvPH2R1uEQ5Ym5oPWDBns2o5QmK4/OFCJb
         MdXHOk1oHi367S4NzbRQU0OxG/Gd+LbxfuvxZej4dVTvlGYoiWeu2r5L3NnWfO0ir79M
         yycQ==
X-Received: by 10.140.135.9 with SMTP id 9mr51215651qhh.3.1450228226003; Tue,
 15 Dec 2015 17:10:26 -0800 (PST)
Received: by 10.55.108.197 with HTTP; Tue, 15 Dec 2015 17:10:06 -0800 (PST)
In-Reply-To: <xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282527>

On Wed, Dec 16, 2015 at 12:03 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Of course hindsight is 20/20, but I think that given what's been
>> covered in this thread it's been established that it's categorically
>> better that if we introduce features like these that they be
>> configured through the normal configuration facility rather than the
>> configuration being sticky to the index.
>
> I doubt that any such thing has been established at all in this
> thread.  It may be true that you and perhaps Christian loudly
> repeated it, but loudly repeating something and establishing
> something as a fact are slightly different.
>
> The thing is, I do not necessarily view this as "configuration".
> The way I see the feature is that you say "--untracked" when you
> want the states of untracked paths be kept track of in the index.

You probably know this, but the --untracked-cache has no bearing on
what we actually keep track of, it's just an optimization for how
efficiently we execute "git status" commands without the "-uno"
option. We still produce the same output.

> just like you say "git add Makefile" when you want the state of
> 'Makefile' be kept track of in the index.  Either the index keeps
> track of it, or it doesn't, based solely on user's request, and the
> bit to tell us which is the case is already in the index, exactly
> because that is part of the data that is kept track of in the index.

What I mean by "[we've] established that it's categorically better [to
do this via git-config]" is that we can still do all that stuff, we
can just also do more stuff now.

>> Since the change in performance really isn't noticeable except on
>> really large repositories, which are more likely to have someone
>> involved watching the changelog on upgrades I think that's OK.
>
> Especially it is dubious to me that the trade-off you are making
> with this design is a good one.  In order to avoid paying a one-time
> cost to run "update-index --untracked-cache" at sites that _do_ want
> to use that feature (and after that, if you teach "git init" and
> "git clone" to pay attention to the "give you the default"
> configuration to run it for you, so that your users won't have to),

It's not unreasonable to avoid the cost of running "update-index
--untracked-cache", it's the difference between just adjusting
/etc/gitconfig and continually having to traverse the entire /
filesystem if you want to enable this feature on a system-wide basis.
It should be easy to enable any Git feature via the configuration
facility either on a --system, or --global or --local basis.

> you are forcing all codepaths that makes any write to the index (not
> just "init"-time) to make an extra check with the configuration all
> the time for everybody, because you made the presence of the
> untracked cache data in the index not usable as a sign that the user
> wants to use that feature.

Maybe I'm misunderstanding Christian's patches but don't we already
parse the git configuration on any commands that update the index
anyway? See git_default_core_config().
We already parse the git configuration to run "git status".

> If the feature is something only those
> with really large repositories care about, is it a good trade-off to
> make everybody pay the runtime cost and make code more complex and
> fragile?  I am not yet convinced.

I was arguing that only users with really large repositories would
notice if we turned this off because the enabling facility had changed
from per-index to config. But it doesn't follow that the expense of
checking the git configuration which we're parsing anyway for the
index-related commands makes things more complex & fragile.
