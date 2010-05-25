From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCHv5 GSoC] gitweb: Move static files into seperate 
	subdirectory
Date: Tue, 25 May 2010 10:00:49 +0530
Message-ID: <AANLkTikaS0m8VJ6hpSA2-pefN1w8Y5J64rr6xNMj1B3q@mail.gmail.com>
References: <1274714564-7553-1-git-send-email-pavan.sss1991@gmail.com>
	 <AANLkTilqa8HAs9jHJQ5KxWic1IYOZxCj10f11KBRMA-b@mail.gmail.com>
	 <201005250237.53529.jnareb@gmail.com>
	 <201005250514.39980.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue May 25 06:30:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGln7-00034l-JZ
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 06:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab0EYEaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 00:30:52 -0400
Received: from mail-yw0-f182.google.com ([209.85.211.182]:54480 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab0EYEau convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 00:30:50 -0400
X-Greylist: delayed 47796 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2010 00:30:50 EDT
Received: by ywh12 with SMTP id 12so26968ywh.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 21:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yBEz1RxAkSK+WI68lSn9AiDEs2ZLg/5S+zBIBTzt1vY=;
        b=cSxM1ILHG1EH8I1Sqt+wBWCNpwuhoefMCZg8GQdJ2fY/TF6/8omqILEoacf/U+g8lh
         8XMHGYgyXW6rjTxXHZLJCRZ8VJ1suftipD/CQacYJ/dYK7BfrH9Qfz3ViSW+HVGgJ+ex
         vD3s43+/EFuwRopwExs9FVqJn6A/+H41jpdpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j7zISSJ+ed9Fp6vGk8u76r+Oz+VlKQbUh5AVkjoEod6xlYmMNU5YCZysTPPzLpilHi
         QLZuIFGFunoDBEPi+TEAVk1aiz1xSt0OMW7Q8vTiJjUquOQBc2M5z3Yq6W6UKf1i5hvl
         wDqx9j0gIrZyFOswAQ2E749Xu5rXOSXzx9ExQ=
Received: by 10.90.203.8 with SMTP id a8mr3217975agg.138.1274761849106; Mon, 
	24 May 2010 21:30:49 -0700 (PDT)
Received: by 10.90.84.5 with HTTP; Mon, 24 May 2010 21:30:49 -0700 (PDT)
In-Reply-To: <201005250514.39980.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147660>

2010/5/25 Christian Couder <chriscool@tuxfamily.org>:
> On Tuesday 25 May 2010 02:37:50 Jakub Narebski wrote:
>> On Mon, 24 May 2010, Pavan Kumar Sunkara wrote:
>> > On Tue, May 25, 2010 at 1:35 AM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> >> On Monday 24 May 2010 17:22:44 Pavan Kumar Sunkara wrote:
>> >>> =A0gitweb/{ =3D> static}/git-favicon.png | =A0Bin 115 -> 115 byt=
es
>> >>> =A0gitweb/{ =3D> static}/git-logo.png =A0 =A0| =A0Bin 207 -> 207=
 bytes
>> >>> =A0gitweb/{ =3D> static}/gitweb.css =A0 =A0 =A0| =A0 =A00
>> >>> =A0gitweb/{ =3D> static}/gitweb.js =A0 =A0 =A0 | =A0 =A00
>> >>
>> >> The patch is supposed to move git-favicon.png and git-logo.png in=
to
>> >> gitweb/static but it doesn't.
>> >>
>> >>> =A0diff --git a/gitweb/gitweb.css b/gitweb/static/gitweb.css
>> >>> similarity index 100%
>> >>> rename from gitweb/gitweb.css
>> >>> rename to gitweb/static/gitweb.css
>> >>> diff --git a/gitweb/gitweb.js b/gitweb/static/gitweb.js
>> >>> similarity index 100%
>> >>> rename from gitweb/gitweb.js
>> >>> rename to gitweb/static/gitweb.js
>> >>
>> >> Only gitweb.css and gitweb.js are moved into gitweb/static [...]
>> >
>> > I don't understand why the binary files aren't moving into static/=
 dir.
>> > I haven't faced this type of problem before. Give me some time to =
figure
>> > it out.
>>
>> You have found a bug in git. =A0When you do a pure rename of a binar=
y
>> file, it doesn't show as a pure rename patch:
>>
>> =A0 $ git init
>> =A0 $ echo foo > foo
>> =A0 $ echo -e "bar\0" > bar
>> =A0 $ git add .
>> =A0 $ git commit -m 'Initial commit'
>> =A0 [master (root-commit) 4bd35b8] Initial commit
>> =A0 =A02 files changed, 1 insertions(+), 0 deletions(-)
>> =A0 =A0create mode 100644 bar
>> =A0 =A0create mode 100644 foo
>> =A0 $ mkdir sub
>> =A0 $ git mv bar foo sub/
>> =A0 $ git commit -m 'Moved to sub/'
>> =A0 [master 00356a5] Moved to sub/
>> =A0 =A02 files changed, 0 insertions(+), 0 deletions(-)
>> =A0 =A0rename bar =3D> sub/bar (100%)
>> =A0 =A0rename foo =3D> sub/foo (100%)
>> =A0 $ git show -C -C --raw --binary --stat
>> =A0 commit 00356a5ec458fa64ab3eca2c23ebc53e9f2d54ba
>> =A0 Author: Jakub Narebski <jnareb@gmail.com>
>> =A0 Date: =A0 Tue May 25 02:23:26 2010 +0200
>>
>> =A0 =A0 =A0 Moved to sub/
>> =A0 ---
>>
>> =A0 :100644 100644 080090e... 080090e... R100 =A0 =A0 =A0 bar =A0 =A0=
 sub/bar
>> =A0 :100644 100644 257cc56... 257cc56... R100 =A0 =A0 =A0 foo =A0 =A0=
 sub/foo
>>
>> =A0 =A0bar =3D> sub/bar | =A0Bin 5 -> 5 bytes
>> =A0 =A0foo =3D> sub/foo | =A0 =A00
>> =A0 =A02 files changed, 0 insertions(+), 0 deletions(-)
>>
>> =A0 diff --git a/foo b/sub/foo
>> =A0 similarity index 100%
>> =A0 rename from foo
>> =A0 rename to sub/foo
>>
>> As you can see there is not
>>
>> =A0 diff --git a/bar b/sub/bar
>> =A0 similarity index 100%
>> =A0 rename from bar
>> =A0 rename to sub/bar
>>
>> and that adding '--binary' option doesn't help

Jakub is right. It isn't working for me too.

> I tested current master, next and pu with this script:
>
> $ cat test_move_binary.sh
> #!/bin/sh
>
> rm -rf test_binary_dir
> mkdir test_binary_dir
> cd test_binary_dir
>
> git init
> echo foo > foo
> echo -e "bar\0" > bar
> git add .
> git commit -m "Initial commit"
> mkdir sub
> git mv bar foo sub/
> git commit -m 'Moved to sub/'
> git show -C -C --raw --binary --stat
>
> And I get:
>
> $ ./test_move_binary.sh
> Initialized empty Git repository in
> /home/christian/work/git/test_binary_dir/.git/
> [master (root-commit) e4c2beb] Initial commit
> =A02 files changed, 2 insertions(+), 0 deletions(-)
> =A0create mode 100644 bar
> =A0create mode 100644 foo
> [master 4fd23ac] Moved to sub/
> =A02 files changed, 0 insertions(+), 0 deletions(-)
> =A0rename bar =3D> sub/bar (100%)
> =A0rename foo =3D> sub/foo (100%)
> commit 4fd23ac43186d31879d7e9dc98b74ce9a7382558
> Author: Christian Couder <chriscool@tuxfamily.org>
> Date: =A0 Tue May 25 05:10:00 2010 +0200
>
> =A0 =A0Moved to sub/
> ---
> :100644 100644 aae0a5b... aae0a5b... R100 =A0 =A0 =A0 bar =A0 =A0 sub=
/bar
> :100644 100644 257cc56... 257cc56... R100 =A0 =A0 =A0 foo =A0 =A0 sub=
/foo
> =A0bar =3D> sub/bar | =A0 =A00
> =A0foo =3D> sub/foo | =A0 =A00
> =A02 files changed, 0 insertions(+), 0 deletions(-)
>
> diff --git a/bar b/sub/bar
> similarity index 100%
> rename from bar
> rename to sub/bar
> diff --git a/foo b/sub/foo
> similarity index 100%
> rename from foo
> rename to sub/foo
>
> so it works fine for me. Which version are you using?

It's not a problem with the version, it's a problem with your system.
echo -e didn't create a binary as expected. You can tell it by seeing
this line:

bar =3D> sub/bar | 0

rather than this

bar =3D> sub/bar | Bin 5 -> 5 Bytes

Change your script to copy a binary file into bar instead of using
'echo -e 'bar\()' and you will see the difference.

So, Jakub what should I do ?
Should I manually add the diff lines for png files ?

Thanks
- Pavan
