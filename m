From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [git subtree] documentation and new --squash mode
Date: Mon, 1 Jun 2009 06:39:56 +0530
Message-ID: <2e24e5b90905311809h751eff3en7f5a87f1e5a6ab03@mail.gmail.com>
References: <32541b130905301136i2d9ec05ew9ba54c6ca746af15@mail.gmail.com>
	 <slrnh24bff.n9t.sitaramc@sitaramc.homelinux.net>
	 <32541b130905310942x3ca98b0ibbed8598f4ba6e56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 03:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAw2U-0000sZ-J7
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 03:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbZFABJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 21:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753246AbZFABJ4
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 21:09:56 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:46973 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZFABJz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 May 2009 21:09:55 -0400
Received: by an-out-0708.google.com with SMTP id d40so15317712and.1
        for <git@vger.kernel.org>; Sun, 31 May 2009 18:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KrLEnPx4cCpTey85zAR3shVTl4/zW3Ji+o3KXXKz6gE=;
        b=txSax1oazKSWJKWtZnkjCZZ91ygQW0j4P30AWNCjJtjSXRDLZ241Eocy36w3Wh8dlF
         6L0zcVeZf2JqmIYsgeJNEUDohCyR9HpWrSXQy0w2d36J8OFY+lT+qdsbit4I7ydERMIl
         nPTEqRhOUrp8AOq5yj5DxA0RP9ddrpiu2HhIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qpWCTRf7xyn6WAhDVHc99gGCZIowtAkyu3fCPyR1hGswiINnThozI3+NTlvUcMHgtt
         6L4SW2iUOjwL2SFl9X81/qt7PM4cRdlYT0Tsb71T4XS5LwaDQ2xQ5nOKtwjfxw+vSUK5
         Vt5vl8Ug9nZMBx7QxlF9ESzKVhibLP0OzjsSc=
Received: by 10.231.40.4 with SMTP id i4mr1453274ibe.18.1243818596681; Sun, 31 
	May 2009 18:09:56 -0700 (PDT)
In-Reply-To: <32541b130905310942x3ca98b0ibbed8598f4ba6e56@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120437>

On Sun, May 31, 2009 at 10:12 PM, Avery Pennarun <apenwarr@gmail.com> w=
rote:
>
> On Sun, May 31, 2009 at 3:12 AM, Sitaram Chamarty <sitaramc@gmail.com=
> wrote:
> > As I understand the documentation (and past emails, snippets
> > of IRC traffic, etc) git subtree will help me do precisely
> > what I want -- a simple way to deal with this all-too-common
> > SVN-ism. =A0If not "simple", at least
> >
> > =A0- simpler than submodules, and
> >
> > =A0- no need for advance planning [1] about what parts will
> > =A0 =A0be subprojects.
>
> Well, I don't know that I'd go so far as to advise against advance
> planning :) =A0But git subtree does make it easy for you to change yo=
ur
> mind later, that much is true.

Agreed, and that's good enough for me.

> You might still have some troubles if you rename subdirectories a lot=
;
> perhaps I don't understand it correctly, but the so-called file
> move/rename detection in git doesn't seem to be implemented
> everywhere. If you extract the history of a subdirectory that was
> previously renamed, you'll get only the history since it was renamed.
> (Which might be fine with you. =A0You can certainly still merge it ba=
ck
> in afterwards.)

Did not know this; thanks -- will keep an eye out.

> Also, git-subtree might have bugs yet. =A0Watch out for that :)

:)

> git-subtree is certainly easier to use than filter-branch, IMHO. =A0P=
lus
> it helps you merge things back in afterwards, which filter-branch
> doesn't particularly.

All in all it does look like it will fulfill my purposes.  I will
probably use it myself a bit before telling people to use it of
course.

Thanks,

Sitaram
