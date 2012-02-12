From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Makefile: Change the default compiler from "gcc" to "cc"
Date: Sun, 12 Feb 2012 01:05:43 +0100
Message-ID: <CACBZZX4BTiTCWQGXJ2Ny+G5UH3MCwy2sgwBPEVLbDSPYOoiOWw@mail.gmail.com>
References: <1324424447-7164-1-git-send-email-avarab@gmail.com> <7vr4zyiyih.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 01:06:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMxH-000678-GR
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 01:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab2BLAGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 19:06:06 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:45807 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755124Ab2BLAGF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 19:06:05 -0500
Received: by lbom4 with SMTP id m4so1853775lbo.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 16:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3W1FhZmpccnjZPs3zewooQC6ucz+jklRsLx2+HfN8dk=;
        b=NvypZSYu+amWhTe/fsjZeJ9QvKy2jAafF7evmRbkqlnkT9VKY7m8s/VqdAcUQwVLzr
         w+TqKPRepK0QGPBrGfVmssAuBF4eXmHFt9ltF49RzTudv471affm1gwSW8s8rxlgWfs4
         zo3Lchb/P7XrYVDeaiPkc5/+Cb8yBDrBvFOtU=
Received: by 10.152.130.98 with SMTP id od2mr7913636lab.3.1329005163129; Sat,
 11 Feb 2012 16:06:03 -0800 (PST)
Received: by 10.112.1.230 with HTTP; Sat, 11 Feb 2012 16:05:43 -0800 (PST)
In-Reply-To: <7vr4zyiyih.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190548>

On Wed, Dec 21, 2011 at 01:01, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> However unlike Linux Git is written in ANSI C and supports a multitu=
de
>> of compilers, including Clang, Sun Studio, xlc etc. On my Linux box
>> "cc" is a symlink to clang, and on a Solaris box I have access to "c=
c"
>> is Sun Studio's CC.
>>
>> Both of these are perfectly capable of compiling Git, and it's
>> annoying to have to specify CC=3Dcc on the command-line when compili=
ng
>> Git when that's the default behavior of most other portable programs=
=2E
>
> Would this affect folks in BSD land negatively?

I see my mail back it December didn't include a reply to that for some
reason.

Anyway like Linus said probably not, also the BSD's I use have cc as a
symlink to whatever the default compiler is, which is usually gcc.

I've recently been hacking git on Solaris again and keep getting bit
by this, I'd like to propose it for inclusion again, the patch still
applies.
