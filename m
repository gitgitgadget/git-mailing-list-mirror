From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: About git pretty
Date: Sat, 21 Feb 2009 17:31:31 +0200
Message-ID: <94a0d4530902210731s79ed8996od57619487de0e58f@mail.gmail.com>
References: <94a0d4530808221624m26034923pbc1f97cb4c4203d8@mail.gmail.com>
	 <20080823000336.GB14684@leksak.fem-net>
	 <94a0d4530808231157y3d36fc23q4617787214a02ea1@mail.gmail.com>
	 <alpine.DEB.1.00.0808241948390.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vfxom1n54.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 16:33:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Latqh-0006aX-O4
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 16:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbZBUPbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Feb 2009 10:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753359AbZBUPbc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 10:31:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:34254 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbZBUPbc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Feb 2009 10:31:32 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2225818fgg.17
        for <git@vger.kernel.org>; Sat, 21 Feb 2009 07:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fYU4p3eYy5tZBeNifyNNCLMOegcc/fKTe6FUrJSuaCI=;
        b=Yk/eRymCkmnfDv7ZyOut2r6IWS8nw+Na7obXtGce1LAuEFQUNat4mwVTCo8M6fDwMS
         bkiU6OO2bRGKlEX72n7Jjm2c7VWcASluDw+7gn+4JDXKoxTf9xkMnovJ5XluJuehO47v
         Du1cxb05XnOojrkBmQSucrQCS/AMagdZiDWdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N/qCW+gtxaSE/6/9yFZNwe/OirEvTp8ag+k3/jA3fBi2w5TpX9zogrtAmqnEdQPdLR
         UXrtmCawQLQe624kxqodm+C+ZE2kH7JueUt2qi0wAkDzOoEZhk+89mAjoK5kGlxktFF8
         bYE437s6RI9WqeGfBcS6D1oKEPeCIhKxn6wLc=
Received: by 10.86.70.3 with SMTP id s3mr1746147fga.78.1235230291046; Sat, 21 
	Feb 2009 07:31:31 -0800 (PST)
In-Reply-To: <7vfxom1n54.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110963>

On Sat, Aug 30, 2008 at 6:30 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> On Sat, Aug 23, 2008 at 3:03 AM, Stephan Beyer <s-beyer@gmx.net> wr=
ote:
>>>
>>> > Felipe Contreras wrote:
>>> >> Hi,
>>> >>
>>> >> Please read aloud the following commands:
>>> >> git log --pretty=3Dshort
>>> >> git log --pretty=3Dfull
>>> >> git log --pretty=3Dformat:%s
>>> >>
>>> >> It is just me or 'pretty full' doesn't exactly convey the meanin=
g of
>>> >> the action to execute?
>>> >
>>> > But "pretty short" and "pretty format" is. :)
>>> >
>>> >> How about:
>>> >> git log --format=3Dshort
>>> >> git log --format=3Dfull
>>> >> git log --format=3Dcustom:%s
>>> >>
>>> >> If you like the idea I can work on a patch.
>>> >
>>> > Because --pretty=3D<format> is an option taken by many git comman=
ds
>>> > including git plumbing (e.g. rev-list), many scripts will rely on
>>> > "--pretty" and they all would have to be changed. And --pretty ex=
ists
>>> > since Jan 2005 (see 9d97aa64).
>>>
>>> Well, it might be difficult, but that doesn't mean it should not be
>>> done. Just like the 'git-*' removal, there could be a period for
>>> transition.
>>
>> Of course it could be done. =C2=A0But I do not deem it necessary. =C2=
=A0In the
>> balance gain/pain it comes out as not worth the hassle on this guy's
>> calculator.
>
> On the other hand, as an undocumented synonym without deprecating nor
> conflicting with existing set of options in any way, I do not think i=
t is
> wrong per-se to support something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log --format=3Dshort
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log --format=3D':%h %s'
>
> in addition to existing --pretty. =C2=A0It should be fairly obvious a=
nd trivial
> to make handle_revision_opt() pretend as if the user said --pretty, a=
nd
> for the latter one silently prefix "tformat" while doing so.
>
> I won't be doing such a patch myself, though.

I've submitted a patch for that.

--=20
=46elipe Contreras
