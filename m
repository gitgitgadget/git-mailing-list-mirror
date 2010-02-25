From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Re: git gui create desktop icon currently does not work
Date: Thu, 25 Feb 2010 08:53:57 +0100
Message-ID: <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com> 
	<20100223230238.GD11271@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 08:54:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkYYG-0001Ld-Fh
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 08:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275Ab0BYHyX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 02:54:23 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:57939 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab0BYHyV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 02:54:21 -0500
Received: by wwf26 with SMTP id 26so1794202wwf.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 23:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rl4V7TOShoZMIrUnPzG8B6AsiRVZgTv5/zBLlaZu+j8=;
        b=PMrNfBE1F1DWqegeM8Xq1t55s1knWN7EPX3yjjXAL34l50WOxV1kEJYAgEb8T6otQy
         DbOy1NcP7BaSEDU0zRt0TS9ftCutXa+Tj2dzciCTOAJ33XRZNa830p2rcVJHJnVHEB2j
         qse1H1MFRpd/3iursCaEGQKJ+5sJKG1k3z+Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WcgbFHVBpQUCszGEPLLA6LZ1EqS+2twtFGs7x6xsjBWpaOxPZ6KiBTTTXsA6AYVvcf
         Otcof7jFdSJndz9K26BjPJBC9YDtVKJdUQrttd5oc8u2LAh0guLwM6WAC9OAVhM5uY3K
         xALVfNk2fRw68jGR/XX3Dbt8XksRqTd1SJCfY=
Received: by 10.213.37.14 with SMTP id v14mr572886ebd.28.1267084457963; Wed, 
	24 Feb 2010 23:54:17 -0800 (PST)
In-Reply-To: <20100223230238.GD11271@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141032>

On Wed, Feb 24, 2010 at 12:02 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote=
:
> On Tue, Feb 23, 2010 at 11:54:40PM +0100, Giuseppe Bilotta wrote:
>> On Tue, Feb 23, 2010 at 11:49 PM, Heiko Voigt <hvoigt@hvoigt.net> wr=
ote:
> [...]
>> > From 5c22c39d530ffb308826629d974048d30cd32e53 Mon Sep 17 00:00:00 =
2001
>> > From: Heiko Voigt <hvoigt@hvoigt.net>
>> > Date: Tue, 23 Feb 2010 10:40:14 +0100
>> > Subject: [PATCH 1/2] git-gui: fix usage of _gitworktree when creat=
ing shortcut for windows
>> >
>> > Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
>> > ---
>> > =A0git-gui/lib/shortcut.tcl | =A0 =A02 +-
>> > =A01 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/git-gui/lib/shortcut.tcl b/git-gui/lib/shortcut.tcl
>> > index 79c1888..8cad0e2 100644
>> > --- a/git-gui/lib/shortcut.tcl
>> > +++ b/git-gui/lib/shortcut.tcl
>> > @@ -16,7 +16,7 @@ proc do_windows_shortcut {} {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0[info nameofexecutable] \
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0[file normalize $::argv0] \
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0] \
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 [file normalize [$_gitworktree]]
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 [file normalize $_gitworktree]
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} err]} {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_popup [strcat=
 [mc "Cannot write shortcut:"] "\n\n$err"]
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> Ouch. Yes, I think your patch is obviously correct.
>>
>> (I'll go sit in a corner with my 'TCL Dunce' cap on for a while ...)
>
> No problem obviously nobody else saw this, but please test your patch=
es
> in the future. That could have avoided this one.

You're right, although finding a Windows installation on which to test
git is nontrivial for me. (I did mention this particular part was
untested when I submitted it.)

> One thing which is missing from my patch is the cygwin part which, as=
 I
> saw from your original patch, has the same problem.

Also, I'm wondering: does the Windows part actually need a  [file
nativename $_gitworktree], or is this automatically handled by the
shortcut creation code?


--=20
Giuseppe "Oblomov" Bilotta
