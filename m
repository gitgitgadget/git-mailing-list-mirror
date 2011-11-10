From: Nathan Broadbent <nathan.f77@gmail.com>
Subject: Re: Bash tab completion for _git_fetch alias is broken on Git 1.7.7.1
Date: Thu, 10 Nov 2011 16:52:33 +0800
Message-ID: <CAPXHQbP4yCzZ96WEKuHsV_8Pny0MRzcLOY7qi5W3_L_5CnY0vA@mail.gmail.com>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
 <CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com>
 <7vehxgu0fy.fsf@alter.siamese.dyndns.org> <4EBB78C7.101@viscovery.net>
Reply-To: nathan.f77@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 09:53:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROQNX-0007UK-Qd
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 09:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933598Ab1KJIwz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 03:52:55 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49109 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab1KJIwy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2011 03:52:54 -0500
Received: by vcbf1 with SMTP id f1so2144998vcb.19
        for <git@vger.kernel.org>; Thu, 10 Nov 2011 00:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ggwWGS6H2XLlf1u8Aji9S6deMX2AZESYZW5EaOIcbvk=;
        b=opubw9TqOrMREbbaXGvUto3cYLAoQku0J8LbNiDxvJwM///0dSIIcSL9u9w1F9+lyt
         7nwbvuUx+/avjGDZV/wsViFVXPz7ZBmnaxFk803dZKNIsAzIDB+X3/aFu3hG5v0q88q1
         mQ4ngNMw4q3hW1yHz2KGGkn+NYkvE200lwL28=
Received: by 10.52.37.165 with SMTP id z5mr10842747vdj.117.1320915174048; Thu,
 10 Nov 2011 00:52:54 -0800 (PST)
Received: by 10.52.184.229 with HTTP; Thu, 10 Nov 2011 00:52:33 -0800 (PST)
In-Reply-To: <4EBB78C7.101@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185222>

So, this is a feature, not a bug... Tab completion for aliases is
really useful. It's important enough to me that I won't stop until
I've found a solution.
I can appreciate that _git_fetch is not currently meant to be called
directly, but we found a way to utilize it when it previously worked.
Perhaps the scope of these completion functions could be expanded to
allow for aliases? I'll attempt to submit a patch if someone can give
me approval.


Thanks,
Nathan


On Thu, Nov 10, 2011 at 3:09 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>
> Am 11/10/2011 4:21, schrieb Junio C Hamano:
> > Nathan Broadbent <nathan.f77@gmail.com> writes:
> >
> >> Dear git mailing list,
> >>
> >> I'm assigning the `_git_fetch` bash tab completion to the alias `g=
f`,
> >> with the following command:
> >>
> >> =A0 =A0 complete -o default -o nospace -F _git_fetch gf
> >>
> >> The tab completion then works fine in git 1.7.0.4, but breaks on g=
it
> >> 1.7.7.1, with the following error:
> >
> > We have been cooking for 1.7.8 and have the first release candidate
> > 1.7.8-rc1; could you try it and report what you find out?
>
> It looks like _git_fetch is not meant to be called directly. All git
> completions must go through _git.
>
> See also this post:
>
> http://thread.gmane.org/gmane.comp.version-control.msysgit/13310/focu=
s=3D13335
>
> -- Hannes
