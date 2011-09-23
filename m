From: Brandon Casey <drafnel@gmail.com>
Subject: Fwd: permission to re-license strbuf subsystem as LGPL
Date: Fri, 23 Sep 2011 10:01:35 -0500
Message-ID: <CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
References: <CA+sFfMeRDQiqGhO9Y=k3tEnzdXjMx59huFE_fx6Y14cJxj1J=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 17:01:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R77G5-0008Ck-5g
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 17:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab1IWPBh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 11:01:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58928 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab1IWPBg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 11:01:36 -0400
Received: by fxe4 with SMTP id 4so3899981fxe.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=FANIB+jD7dDvAyzMTDGlFzlLrOzWxH5tGfNziPluLmM=;
        b=QBMmCmDhjI6KY4FXhLsbPZX2EqtDCLrCljGQb4iTZvOhBrtq3k4kbBB4r+z+if8jAH
         CsJFIVyEix9POnnk+sUaP5GjfNtwndnp3YzQSKkIGV3PQhK9g6bRdlbvnQxCiU3K3f+u
         vt0WFrf5an33MHoGm4WJw66zF6eToer0M7oig=
Received: by 10.223.63.8 with SMTP id z8mr5169683fah.84.1316790095336; Fri, 23
 Sep 2011 08:01:35 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Fri, 23 Sep 2011 08:01:35 -0700 (PDT)
In-Reply-To: <CA+sFfMeRDQiqGhO9Y=k3tEnzdXjMx59huFE_fx6Y14cJxj1J=Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181970>

Oops.  I forgot to include the git mailing list on the email below.  I
intended to include the git mailing list for two reasons.  1) so that
when people replied giving there permission it would become part of
the public record, and 2) because maybe someone had already done this
and they could speak up before I duplicated their effort.

The following people have already given their consent:

   Jeff King   (LGPL)
   Avery Pennarun   (LGPL)
   Jonathan Neider   (LGPL, ZLIB, Expat, BSD)
   Johannes Schindelin   (LGPL, BSD)
   Linus Torvalds   (LGPL)
   Alex Riesen   (LGPL)
   Marco Costalba   (LGPL)
   Lukas Sandstr=C3=B6m   (LGPL, BSD)
   Michal Rokos   (LGPL, BSD)
   Thomas Rast   (LGPL, BSD)

The following have not yet responded (the email just went out last nigh=
t):

   Pierre Habouzit
   Ren=C3=A9 Scharfe
   Junio C Hamano
   Kristian H=C3=B8gsberg
   Johannes Sixt
   Frank Li
   Shawn O. Pearce

Jonathan Nieder suggested using a more permissive license than LGPL.
BSD seems to have the most support.  If the remaining contributors
agree, then I'm fine with licensing under BSD.

Anyway, here is my original email requesting permission to re-license
strbuf et al so that it can be made into a library...

---------- Forwarded message ----------
=46rom: Brandon Casey <drafnel@gmail.com>
Date: Thu, Sep 22, 2011 at 11:21 PM
Subject: permission to re-license strbuf subsystem as LGPL

To those who have contributed to git's strbuf subsystem,

I'd like to turn git's strbufs into a library. =C2=A0So with your conse=
nt
I'd like to re-license the code in strbuf.c and strbuf.h, and any
compat/ dependencies as LGPL so that I can create a strbuf library.
Just skimming through strbuf.c, I'm thinking the other files that may
be needed include ctype.c, compat/snprintf.c, and as little of
wrapper.c as necessary (hopefully only xread). =C2=A0I think all of the
authors are included in this email. =C2=A0The reason for LGPL, of cours=
e,
is so that it can be linked with non-GPL code.

Please offer your consent to re-license your contributions under LGPL
by replying to this email.

All comments welcome.

Thanks,
-Brandon

p.s. sorry for the mostly cut-n-paste email for those who also
received my email about archive-zip
