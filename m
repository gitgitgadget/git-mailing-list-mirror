From: Angus Hammond <angusgh@gmail.com>
Subject: Re: [PATCH 1/2] Change error messages in ident.c Make error messages
 caused by failed reads of the /etc/passwd file easier to understand.
 Signed-off-by: Angus Hammond <angusgh@gmail.com>
Date: Thu, 10 May 2012 20:57:03 +0100
Message-ID: <CAOBOgRaAv=BoopuepHzBjDyMf-JVbmabwaGipczAtCjeUPtepw@mail.gmail.com>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
	<7vpqabn7o1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 21:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSZU8-00035z-NP
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 21:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760777Ab2EJT5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 15:57:07 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:65244 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758564Ab2EJT5G convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 15:57:06 -0400
Received: by lahd3 with SMTP id d3so1384329lah.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1sfFtbdlWiK71KPWFYT+j6Kw7BSheEySdTFBXyx6dXc=;
        b=YoelbkQqLa7JggMxjqX1wVuYaFvQBEWkzzMEXOB7LwKJLvtlMBZo8PvuK1g6bCSIAB
         1Fml4dqwo5roezH7vzUfdiMb4ZjsjHJWPMPlj1kzenOBc+8hSXKHh0kKmSVKfLbkGnLD
         Sbrvn/0h196RJerAJJ0tan9csEEsB6pE+nnjlinH9TVFrI3tb8X9imSy5CHxySHpQh9q
         yLDmvga810zVf3zuUTjLlpO5GV6SJgZjhdunpHxKlXxeT+qqMTvPAaYU+tQxeFI0vOqu
         PaBFgJDTJrxxZfShEBLOqjs6E0IOP67I2w48GMDIW11YBalghqD500fAv57WrC7Tq52Q
         8fnA==
Received: by 10.152.111.200 with SMTP id ik8mr2812903lab.15.1336679823912;
 Thu, 10 May 2012 12:57:03 -0700 (PDT)
Received: by 10.114.5.169 with HTTP; Thu, 10 May 2012 12:57:03 -0700 (PDT)
In-Reply-To: <7vpqabn7o1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197623>

On 10 May 2012 20:43, Junio C Hamano <gitster@pobox.com> wrote:
> They are one of the oldest and humorous messages we have in the syste=
m,
> and more importantly, users will see them only once on a badly config=
ured
> system. =A0If there is no real-life reason (e.g. "if we do not change=
 this
> message, Nuclear reactors will start misbehaving"), I would rather ke=
ep
> them as they are for hysterical raisins.
I'm not too worried either way, just tried to knock the patch out
quickly because it came up and this seemed like the logical solution.
In all honesty though, whilst I don't have a problem with unix humour
being in git, I do have a bit of a problem with it being in error
messages since when these are displayed it means that a users system
is preventing them from using git for whatever reason, and at those
times there's a good chance you're worried about fixing that problem,
not laughing at a joke made by Linus several years ago.

Just my 2 cents. It's probably not worth too much bother since it'll
only ever show up very rarely.
Thanks
Angus
