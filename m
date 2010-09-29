From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Re: [GITK PATCH] gitk: add menuitem for file checkout from
 selected or parent commit
Date: Wed, 29 Sep 2010 15:48:03 +0000
Message-ID: <AANLkTinn-_Npv4+wGRkS6Sonf1VRV-cEMtHBEtyQeq8O@mail.gmail.com>
References: <20100928200344.GA12843@book.hvoigt.net>
	<AANLkTi=GmR3kV-ChSNybcaw4c=Dwt5G98e31WVuzJcfC@mail.gmail.com>
	<20100929152259.GA13887@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Michele Ballabio <barra_cuda@katamail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 17:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0ytD-0003pQ-CH
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 17:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903Ab0I2PsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 11:48:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56187 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab0I2PsF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 11:48:05 -0400
Received: by iwn5 with SMTP id 5so1173412iwn.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 08:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R05Als+Oj6rYClKnQ3uKh4efnt1E7qEL8CxCpOJY29I=;
        b=YkM1/bpb/KAvIBFQxKuNAHi3lqY7jjthJ0SOOd+EE3Unq2l67HKUvHwgRGinySNqRR
         XPhUNHumtSTFF0cjQ25QExs0am97GbT5N82FPLNaNs95uxbZg0DVly1Fv2wEJT614Gq1
         zwqVwGn6rezLr80qKMOMhTyixuoQAaKBER2So=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UWMdykU/7vMM8MczpHpOB/YyMtFudRS1uJe9nFjENIqTBB2s3fh/1c7d4O7vtO+znk
         5IRaMfC5dnnfEDb4CLN+3sJNwPLXVeUdgO0Zodgr4+KxjKOgVw6zGSbmToU3mG2K+8UX
         q5T6XCHml987IJnwllnAxBRfK30RE27QXWBtQ=
Received: by 10.231.147.131 with SMTP id l3mr2008350ibv.74.1285775283723; Wed,
 29 Sep 2010 08:48:03 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 29 Sep 2010 08:48:03 -0700 (PDT)
In-Reply-To: <20100929152259.GA13887@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157581>

On Wed, Sep 29, 2010 at 15:23, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Tue, Sep 28, 2010 at 09:09:43PM +0000, =C4=98var Arnfj=C3=B6r=C5=A1=
 Bjarmason wrote:
>> On Tue, Sep 28, 2010 at 20:03, Heiko Voigt <hvoigt@hvoigt.net> wrote=
:
>> > This is useful if a user wants to checkout a file from a certain
>> > commit. This is equivalent to
>>
>> It looks like the existing msgid/msgstr pairs have line number
>> comments. Why not add that for the new strings? Presumably it might
>> inflate the patch a lot though, as old strings get displaced.
>
> I was wondering what these numbers were for. Now it makes sense. I am
> not against doing it but I would need a script to update the existing
> ones. Is there something like that? Otherwise I would just add the li=
ne
> number for the two new msgs.

You should update PO files with the msgmerge(1) program, the ab/i18n
branch has docs on how to do that in po/README.

But as Michele points out you probably shouldn't update these, some
projects do, but it probably makes more sense to leave these updates
up to translators.
