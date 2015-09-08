From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bash completion lacks options
Date: Tue, 08 Sep 2015 11:38:38 -0700
Message-ID: <xmqqzj0w7o41.fsf@gitster.mtv.corp.google.com>
References: <20150907150757.GA6720@aepfle.de>
	<CACBZZX4aZo_hn07Pho2GtBVNWm7WHLbV6xSi_r-BjW97QWNqEg@mail.gmail.com>
	<55EDAEF3.7000503@aepfle.de>
	<CACBZZX44qsZZovvJFwP9foqhWaD1ZmL3u+F3hYv2iVq0CKnO6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Olaf Hering <olaf@aepfle.de>, Git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 20:39:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZNnC-0001yU-OC
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 20:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbbIHSiv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2015 14:38:51 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36035 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbbIHSiu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 14:38:50 -0400
Received: by padhk3 with SMTP id hk3so46135871pad.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 11:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=012iF74Vxpu9AvEAbpLR0RRMdTc+gAEIAtA1shI85dk=;
        b=ycbkqWMCDe6q33Quze3cZ5YqjwCHg/9SkZWgPEF+pQ4/2RlyP4FpxAMNoUOeQ1i2GP
         EbIJcos/b0Tawg7pW0EF1GyAAEGohfChRlSDokEqlUH0NX3nXOFTTSb8vb2BikcSiZiZ
         hfp4AJuWivKfMDvQUgyvUm8gDoBFoIfw6h7XxxMvO1DIB/uH3VBlYWKg9tL3Po5f4pem
         9ECEZ934qIwLVpMeZPJGc1zAbUrKeVFB+WHaZZYVlQqyXPY94K8aCl81IYIWlrZyQ2Jl
         8IyHUBxLxeeHBK17FrI8z6xk0HhW8uDZLe0tQ1mt1JlGylfD/m3aYEGHRRKMxoWh1H/W
         3GPw==
X-Received: by 10.68.135.161 with SMTP id pt1mr60912105pbb.47.1441737530061;
        Tue, 08 Sep 2015 11:38:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id ht7sm4263147pdb.1.2015.09.08.11.38.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 11:38:49 -0700 (PDT)
In-Reply-To: <CACBZZX44qsZZovvJFwP9foqhWaD1ZmL3u+F3hYv2iVq0CKnO6g@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 8 Sep
 2015 13:28:53
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277517>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Sep 7, 2015 at 5:36 PM, Olaf Hering <olaf@aepfle.de> wrote:
>> Am 07.09.2015 um 17:34 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n:
>>> On Mon, Sep 7, 2015 at 5:07 PM, Olaf Hering <olaf@aepfle.de> wrote:
>>
>>>> https://github.com/libguestfs/libguestfs/commit/0306c98d319d189281=
af3c15101c8d343e400f13
>>>
>>> This is an interesting approach, but wouldn't help with git-send-em=
ail
>>> in particular, it's a Perl script, so there's no ELF section to par=
se.
>>
>> format-patch is a ELF binary, a link to git itself as I notice
>> just now.
>
> Yes, format-patch is written in C, but you mentioned send-email, whic=
h
> is a Perl script.

I think Olaf means that send-email has a mode where it can drive format=
-patch
directly from the command line.

This is a slightly related tangent, but I've been wondering if it
makes sense to discourage, deprecate and eventually remove that mode
of operation.  It appears it is the biggest single source of poorly
proof-read series, when compared to "format-patch to a directory
with --cover option and then give them a final scan before running
send-email on them" workflow.
