From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 13:32:49 +0000
Message-ID: <AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
	<AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tait <git.git@t41t.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Sep 24 15:33:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz8PD-00084U-Jl
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 15:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756306Ab0IXNdX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 09:33:23 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33938 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab0IXNdW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 09:33:22 -0400
Received: by gwj17 with SMTP id 17so950413gwj.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e0tfQB1E9Y/OGvvIsO0TbYxZx2wg8G32/5U4nqo/0Yo=;
        b=BkP1BcPk1Zxx+SpJCPJKmLSrt1zEb+dvccIq+/x2Ws6xL0s5ZtVmEiM9dJJOjCcFbe
         l7m5vmBMaNjhxjbiEUrVg8H3+e9RRM6twBZx3TmCr/OHrhiAJ8TmqyAFtVwC/uElVsAw
         /p4mCp/GtWHC6iahhOxr3BNDEDmCeE/95iNyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UNAr7srhrV7sdas1SU8NmPvilPAEL1KATJ7eE449BHvGcWdAqkq0SJh0ZYO1zWpbiV
         vnKThcI8bQheIkB0+Z9FCSBnHhCoosZykR4OjvWPznbIeh12ape/lhFYGM5BqhGJ77cx
         Jr//QssmKfYhFuj9tmFL9PwGuBSpRkN/EosjI=
Received: by 10.151.148.15 with SMTP id a15mr4618579ybo.123.1285335199713;
 Fri, 24 Sep 2010 06:33:19 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 06:32:49 -0700 (PDT)
In-Reply-To: <AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156986>

On Fri, Sep 24, 2010 at 13:08, Tor Arntsen <tor@spacetec.no> wrote:
> On Fri, Sep 24, 2010 at 14:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>
>> However, I'd like to shift the discussion a bit: Do we want to suppo=
rt
>> the 5.6 line *at all* anymore? I don't think so. As you point out
>> yourself you can just compile 5.8 or later on these machines.
>
> 5.8 as minimum is probably for the best. It's not that just you can
> compile a newer version (5.8), more importantly, Perl 5.8 is availabl=
e
> as a package from those semi-official 3party repositories for most
> systems (at least the *nix systems I have access to)

Do those repositories also have 5.10 and 5.12?

> except for those like Irix 6.2 where it's hopeless anyway (perl
> 5.0). But I only have access to irix/aix/solaris/tru64 in addition
> to Linux.

Hrm, 6.2 is old, but 5.12 is known to compile on 6.5 at least. What
are the issues with 6.2? Perhaps they could be solved if someone with
such a machine contributed a smoker for the perl core.

Perl is very portable with people willing to port it, the main
limitation is usually that porters don't have access to obscure
systems, not that there isn't interest.
