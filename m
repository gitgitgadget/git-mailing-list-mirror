From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Tue, 28 Sep 2010 23:35:38 +0200
Message-ID: <AANLkTincfqV08juL0LPi4k_neCemqeS=13XSBgEq6FPK@mail.gmail.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org>
 <AANLkTikSxpXJkeneWbJQ_2g32w1bV-CEdyk2_5G2Xd+u@mail.gmail.com>
 <201009282313.48278.j6t@kdbg.org> <AANLkTikpDwEJR8rAk+R0auXN5y-G1Cd4z8djoL0VzTYw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 28 23:36:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hqI-00009W-N7
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab0I1VgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 17:36:00 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62357 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab0I1VgA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 17:36:00 -0400
Received: by qyk36 with SMTP id 36so7323950qyk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=3K23Ir88HphJzfe8G6/c2dkk21mbRTiX5u74w9C4/Aw=;
        b=DwqzmO+xu6n+awDE4UEBrRzv4p0gc7aFmSEgagvA5ZaQArk3fc9b2Lqzn4PjlMEmWS
         mMSB964cEihyNBAln0mMxGZZOTomXSobBsV8QKEInWXRJ4cFjwPaY03urHChFGlLQfHq
         l+NdxjiNWYBpyzSju3WJ1Al/gK73DzuXMpPQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=BZtOHDlHwBp3R4RyjJD1NQaZyYkK/SsZ0xrpYfGD3B+KNhU4vZSySpFqEFge8nX70E
         in+esERceH/VR+bnef8p+rf97htvjMRMLHlBHdMrDPWSNrUBJMaNYhKD3ui4zAM7ytXn
         KVVGjYDBbUSKL67Mw3KJEVsc/CEYJlvI6aPoY=
Received: by 10.224.54.68 with SMTP id p4mr450454qag.114.1285709759285; Tue,
 28 Sep 2010 14:35:59 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Tue, 28 Sep 2010 14:35:38 -0700 (PDT)
In-Reply-To: <AANLkTikpDwEJR8rAk+R0auXN5y-G1Cd4z8djoL0VzTYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157479>

On Tue, Sep 28, 2010 at 11:20 PM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
> On Tue, Sep 28, 2010 at 11:13 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> On Dienstag, 28. September 2010, Erik Faye-Lund wrote:
>>> On Tue, Sep 28, 2010 at 10:52 PM, Johannes Sixt <j6t@kdbg.org> wrot=
e:
>>> >> =A0 =A0 =A0 mingw: do not crash on open(NULL, ...)
>>> >
>>> > This one is bogus, and as it stands, it must have my Ack removed.=
 :)
>>> > Needs the same fix in mingw_fopen as mingw_freopen. (There remain=
s an
>>> > unprotected dereference of filename.)
>>>
>>> I believe the version in for-junio already has this fix squashed in=
=2E
>>> The following hunk, taken from
>>> http://repo.or.cz/w/git/mingw/4msysgit.git/blobdiff/4e93566b07dcf47=
ecb6484d
>>>225418c04c1eedee6..b18500977d88b13803ecc60cf383538139ec09d8:/compat/=
mingw.c
>>> shows that it is... Or are you thinking of something else?
>>>
>>> @@ -346,7 +346,7 @@ FILE *mingw_fopen (const char *filename, const =
char
>>> =A0 =A0 =A0 if (hide_dotfiles =3D=3D HIDE_DOTFILES_TRUE &&
>>> =A0 =A0 =A0 basename((char*)filename)[0] =3D=3D '.')
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0^^^^^^^^
>> This can crash, too.
>>
>
> Ah, indeed. Thanks for pointing that out! I'll send out a new version=
,
> with this squashed on top:
>

And now that I assemble it, I all of a sudden understand where your
complaint came from. The issue wasn't in the original patch, it was
introduced when the patch was applied.

Basically, I introduced a similar crash-bug to the one this patch
fixes in the original hide-dotfiles patch, and my this patch was
written against junio's master, which doesn't contain that newer bug.

I also seem to remember there being some controversy over the
hide-dotfiles series, whether or not it was in git's scope to allow
hiding non-dotgit files at all etc. So, perhaps what makes the most
sense would be to eject the hide-dotfiles stuff out of for-junio, and
rework it on top, going through the main git mailing list? That series
did get quite a bit messy as patches were applied a little too quickly
IMO.
