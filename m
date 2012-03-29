From: Jeremy Ramer <jdramer@gmail.com>
Subject: Re: Currently checked out branch is not bold in gitk when using ssh X-forwarding
Date: Thu, 29 Mar 2012 10:34:36 -0600
Message-ID: <CALykgB0a+dazZn7rdeiUVcXDa58=fydQVwe_-fq-_jqxeUY4PQ@mail.gmail.com>
References: <CALykgB0LCjDsMYSB1jAxBmPxsf-f6XDDFv+1nmtvCLP65ex5vw@mail.gmail.com>
	<4F6BB0EC.2080209@gmail.com>
	<4F6BBD8D.1050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDIJ9-0004wa-QG
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 18:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759063Ab2C2Qej convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 12:34:39 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53368 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963Ab2C2Qei convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 12:34:38 -0400
Received: by bkcik5 with SMTP id ik5so2157808bkc.19
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lg4l2RGs1YFLp4aFdl5NBKbYnkNgdBB14i535gq/iyc=;
        b=tHHMX535IjEjqqoZ/EiQvSzspYhT84XIB5rsO/4BOR50dlsc8ZRQRHqliFsm+8NTTR
         z40KBYy9bHK7F9Loi3puzYb70eUv0Sk5AahDXwn/AIde7RbSH/GO1wRMdLCvQO6zczQQ
         5vGpKc1f39elNYUP2Q8zU+UyT2TilWBm35YjfOgJ2BjHG4g8yDBZ+LgJqyQ7ZM+xWerI
         lAsRo/mkHRiUCwatQzj7gd/gjV0FbEVlHxJm2K767MXl24nWoYbg3yHqHDq3tCzI3+5q
         YsLt6ivxDhgnBTad/qVhsaDV/+oqRVaZgTpsUmPMd5c/DKNuw4a7sZCBUUFzitbCFDZd
         RRow==
Received: by 10.204.132.72 with SMTP id a8mr14302344bkt.42.1333038876705; Thu,
 29 Mar 2012 09:34:36 -0700 (PDT)
Received: by 10.204.36.135 with HTTP; Thu, 29 Mar 2012 09:34:36 -0700 (PDT)
In-Reply-To: <4F6BBD8D.1050905@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194268>

On Thu, Mar 22, 2012 at 6:02 PM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
> On 3/22/2012 6:08 PM, Neal Kreitzinger wrote:
>>
>> On 3/22/2012 4:10 PM, Jeremy Ramer wrote:
>>>
>>> However, when I log in from my newer Ubuntu 11.11 laptop (ssh -X
>>> buildserver) and start gitk the currently checked out branch is
>>> not displayed in bold font. In fact, all the fonts are a little
>>> ugly, though it is the lack of bold that is the hardest to work
>>> with.
>>>
>> FWIW, my theory is that is has something to do with your fonts. Just
>> a simple end user observation. I'm not a gitk programmer.
>>
>> Maybe you don't have your fonts set for what-you-want in gitk. Maybe
>> you don't have the fonts installed/setup on your ubuntu box for
>> what-you-want in gitk.
>>
>> I assume gitk uses the fonts that you tell it to, or that are
>> available.
>>
> Hint: the bold version of a font is its own font. =A0You could have t=
he
> non-bold font installed, but not the bold font. =A0Here's a link on h=
ow to
> install fonts: http://karmak.org/archive/2004/06/ttfonts.html?lang=3D=
en
>
> *If* that is the reason for your lack of bold-ness in gitk.
>
> Also, I see from my install log that it does do something with fonts:
>
> =A0DEST /usr/share/git-gui/lib
> =A0 =A0INSTALL 644 tclIndex
> =A0 =A0INSTALL 644 about.tcl
> =A0 =A0INSTALL 644 blame.tcl
> =A0 =A0INSTALL 644 branch_checkout.tcl
> =A0 =A0INSTALL 644 branch_create.tcl
> =A0 =A0INSTALL 644 branch_delete.tcl
> =A0 =A0INSTALL 644 branch_rename.tcl
> =A0 =A0INSTALL 644 branch.tcl
> =A0 =A0INSTALL 644 browser.tcl
> =A0 =A0INSTALL 644 checkout_op.tcl
> =A0 =A0INSTALL 644 choose_font.tcl
>
> I'm not sure how closely gitk and git-gui are tied together.
>
> Hope this helps some more.
>
> v/r,
> neal

It does seem to be a font issue. The strange thing is that the fonts
work correctly when I do it locally on my laptop and when I do it
locally on the build server. But when I use the ssh x-forwarding the
fonts seem broken. I've tried installing several font packages with no
luck.

I have found a workaround that resolves my issue for now. I changed
the font used in gitk to "fixed" (Helvetica is the default selection,
but doesn't appear in the list when I try to change the font). With
fixed the bold checked out branch shows up properly.

Thanks!
Jeremy
