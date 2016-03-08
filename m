From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Is there a --stat or --numstat like option that'll allow me to
 have my cake and eat it too?
Date: Tue, 8 Mar 2016 21:58:59 +0100
Message-ID: <CACBZZX4xU3qzRB=H3R3PZwZdBNc_pUm2rff3KG965J_J5WgFVQ@mail.gmail.com>
References: <CACBZZX7o+VA1RVvja3xtBQf+rr2bWoByas4D5GKZ_VfQr7H19w@mail.gmail.com>
 <20160308205124.GA25849@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 21:59:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adOiy-00052G-Fl
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 21:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbcCHU7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2016 15:59:21 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33557 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbcCHU7T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2016 15:59:19 -0500
Received: by mail-qk0-f170.google.com with SMTP id s5so11718863qkd.0
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N/88hIDz/iINLpiwZeTa1i7Jcb/N8o7D968tiWJAr7M=;
        b=DfeWMgNTGHS9o7b9IUf2mZ2AK/3qbBDcNAn4FkOZSyrQxHkZ1pCt3A7Zy146UulX7/
         0ahULl9wfDUplwEYuvcYT+NHcT00kDRVS7lJa3AcxLn2qNiT5Z4V7DJx3ju5yZGubafP
         xaMwX+6p2XwcsSd6BjT5scA82T7boKyb8COv4dcsAkWJufkjJAhk2tkM/pIVmZcROR73
         NN0lljnVepU2IAyVtbH5qxiMXy1mcOWR/TSGUmunmO70sZJOa2EVU5QtLo6NWchyOpwq
         K5PREiLtlXKqBc8LFw+t1WiEQbZK4t+rYeSlYrf5QxmhVtIgPV8dD9lfU3RwTerwWZog
         N24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N/88hIDz/iINLpiwZeTa1i7Jcb/N8o7D968tiWJAr7M=;
        b=jIyB2W9rv3aXCjNYNbO03wxVe/QOSzJmJHDgI6W565wJKySCjZiApnJzq4fGbcYNxC
         pnqrXOBuDEqKbaDop1xmq19tlVDqydvGEb/7GPaqCxWO7Cu4yZKukSWsk+Le1Wio1CPF
         wrXVrjOXTmb1oahCSsb1y/3TO1yuXWMX389hIketPupg9g29FxVJLedii+NFcb4KhFs0
         ac4j4gqtBet/iYnmaEprpSMAZOesQ6OeKIxkdnMSH0MduZxvIIsAjG81hoSJ2YzCJWy5
         4JCcG0/pnTDAwqff52/HWtuqEpxmj2JVg1TSjR+DDZnSqLX+uvNxEnW8/VT6UU7SXZ4P
         89Bg==
X-Gm-Message-State: AD7BkJJyKXLiaeODlUWrp3C0ELDcf10mjrDFldDgmmKtt13jk4shhfj2GvELv38b4q4LIuuKspTL782+kpROrw==
X-Received: by 10.55.72.12 with SMTP id v12mr38890021qka.100.1457470758610;
 Tue, 08 Mar 2016 12:59:18 -0800 (PST)
Received: by 10.55.77.82 with HTTP; Tue, 8 Mar 2016 12:58:59 -0800 (PST)
In-Reply-To: <20160308205124.GA25849@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288453>

On Tue, Mar 8, 2016 at 9:51 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 08, 2016 at 04:08:21PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> What I really want is something for git-log more like
>> git-for-each-ref, so I could emit the following info for each file
>> being modified delimited by some binary marker:
>>
>>     - file name before
>>     - file name after
>>     - is rename?
>>     - is binary?
>>     - size in bytes before
>>     - size it bytes after
>>     - removed lines
>>     - added lines
>
> If you get the full sha1s of each object (e.g., by adding --raw), the=
n
> you can dump them all to a single cat-file invocation to efficiently =
get
> the sizes.
>
> I'm not quite sure I understand why you want to know about renames an=
d
> added/removed lines if you are just blocking binary files. If I were
> implementing this[1], I'd probably just block based on blob size, whi=
ch
> you can do with:

I want to know about renames because if you're just moving an existing
binary file around that's fine, it's not adding a new big blob to the
repo.

The hook also has a facility to commit binary stuff if you add "yes I
know what I'm doing and want to commit N bytes to the repo" to the
commit message. Mostly when people do this it's an accident.

I wanted to know about added/removed lines because I was looking into
extending this non-binary files. Today at work someone committed 300MB
of text files to a branch, we could delete it in that case, but it
would also be nice to have limits on that sort of thing too.

>   git rev-list --objects $old..$new |
>   git cat-file --batch-check=3D'%(objectsize) %(objectname) %(rest)' =
|
>   perl -alne 'print if $F[0] > 1_000_000; # or whatever' |
>   while read size sha1 file; do
>         echo "Whoops, $file ($sha1) is too big"
>         exit 1
>   done
>
> You can also use %(objectsize:disk) to get the on-disk size (which ca=
n
> tell you about things that don't compress well, which tend to be the
> sorts of things you are trying to keep out).
>
> You can't ask about binary-ness, but I don't think it would unreasona=
ble
> for cat-file to have a "would git consider this content binary?"
> placeholder for --batch-check.
>
> The other things are properties of the comparison, not of individual
> objects, so you'll have to get them from "git log". But with some cle=
ver
> scripting, I think you could feed those sha1s (or $commit:$path
> specifiers) into a single cat-file invocation to get the before/after
> sizes.
>
> -Peff
>
> [1] GitHub has hard and soft limits for various blob sizes, and at on=
e
>     point the implementation looked very similar to what I showed her=
e.
>     The downside is that for a large push, the rev-list can actually
>     take a fair bit of time (e.g., consider pushing up all of the ker=
nel
>     history to a brand new repo), and this is on top of the similar w=
ork
>     already done by index-pack and check_everything_connected().
>
>     These days I have a hacky patch to notice the too-big size direct=
ly
>     in index-pack, which is essentially free. It doesn't know about t=
he
>     file path, so we pull that out later in the pre-receive hook. But=
 we
>     only have to do so in the uncommon case that there _is_ actually =
a
>     too-big file, so normal pushes incur no penalty.

All good tips / insights. I'll definitely check some of this out.
