From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: Question about commit message wrapping
Date: Mon, 12 Dec 2011 09:41:32 +0100
Message-ID: <CAH6sp9NwyxZi6KR4U96=sWdiqCseyTLEDoHdw=y9hUx2kHwOpg@mail.gmail.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com>
	<m3zkf1hnh9.fsf@localhost.localdomain>
	<E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com>
	<201112102030.15504.jnareb@gmail.com>
	<CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?Q?Sidney_San_Mart=C3=ADn?= <s@sidneysm.com>,
	git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1S8-0000Jr-9X
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990Ab1LLIle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Dec 2011 03:41:34 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59709 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1LLIld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2011 03:41:33 -0500
Received: by qcqz2 with SMTP id z2so3352055qcq.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 00:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vn4sZ+2HOZSx2tjxbDvLPkuqz7BnLrOSeWYiHOKvg9I=;
        b=HythEDNlwIGI8D1p9icQkquxT0EpTOjvL2wg+iU9kHse/tlkj7Yo2bigGnDmGjMB83
         RVfZIUwJ8V7ZzLvzuLz0hRnujUGRicy4IIIXVa2RLpj0aVSFWpJrdtdLgpBMDro7B/od
         IItTInwP5as31MFdPhh4KCLgo4Zj+9khENZDo=
Received: by 10.229.65.85 with SMTP id h21mr4107976qci.215.1323679292542; Mon,
 12 Dec 2011 00:41:32 -0800 (PST)
Received: by 10.224.76.82 with HTTP; Mon, 12 Dec 2011 00:41:32 -0800 (PST)
In-Reply-To: <CAH5451kGn72tLAwdvQFBjSyHSL0rUmaPZrbL7Z-KfHWN-HAuCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186898>

On Sun, Dec 11, 2011 at 11:00 PM, Andrew Ardill <andrew.ardill@gmail.co=
m> wrote:

>> Additional and the more serious problem with wrapping on output is
>> related to backward compatibility. =C2=A0If you have commit message =
that is
>> wrapped e.g. to 80 characters, and you wrap on output to 72 characte=
rs,
>> you would get ugly and nigh unreadable ragged output
>
> For what it's worth, I do a lot of reading emails on my phone, which
> force wraps line-length to the width of the display (not a set number
> of characters).
> This is always less than 80.

Good point.

>
> Emails on this list are almost exclusively sent pre-wrapped to 80
> character line lengths.
> The result is exactly the kind of ragged output you used in your
> example. Changing this behaviour may break backwards compatibility,
> but it is already broken for 'future' compatibility.

I am starting to think that we need to somehow keep the current
behavior, but override at smaller widths. Maybe even use format=3Dflowe=
d
in format-patch. On the other hand, the fundamental use with git is to
communicate code, and I'm not sure how that [cw]ould be handled.
