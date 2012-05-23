From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 13:56:11 +0200
Message-ID: <CAMP44s0X3G_eL6R4i+arLEPS3B5DzeXoFEqax_GDi-TQ+LVzFQ@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl>
	<CAOnadRGBi0+Zno_eqzzkJjoUfXh=vEpEV5Cf_6zjOV42XPjXdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed May 23 13:56:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXAAs-0002BR-EC
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 13:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446Ab2EWL4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 07:56:13 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60424 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756755Ab2EWL4M convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 07:56:12 -0400
Received: by lahd3 with SMTP id d3so5033327lah.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 04:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oL3ATfxVEPxVf4sHfKSTDH306VN61/g6NL3oBILCN2c=;
        b=hDxQTZxLrnbcRPBj8PeJOfsb1R6ghNGZuZGi/x5WIL6sIXlkg6HYG0YiFoGssrXJr9
         RBoL5dU/oKFY6oJhpqOjZdANStfeJbd9iCYk1+LBW5VOOGH4xSUREuCvGJUcZLUfNdGo
         uFDHBoaBuVKhwaKA+/p3WAFkL5EhTdf1S/6ITF7FaKjvQ0F5c0Lriy2pZBlbTOB4Lrnd
         tjSVVIRb8tlyYgz3XYcp2geJFU4skYKkWncBJpZ0sW6iUHVbAAYrd6Opgrb5MGytVWHp
         SOIA7OjO4yHqq6AtCtFEbZ/btuEsr/KB7n1yNgNpwYCtXbQtki1O02wpPrZCdAqsvqzT
         XBqg==
Received: by 10.152.123.244 with SMTP id md20mr26962416lab.0.1337774171135;
 Wed, 23 May 2012 04:56:11 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 23 May 2012 04:56:11 -0700 (PDT)
In-Reply-To: <CAOnadRGBi0+Zno_eqzzkJjoUfXh=vEpEV5Cf_6zjOV42XPjXdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198281>

On Wed, May 23, 2012 at 12:29 AM, Ted Pavlic <ted@tedpavlic.com> wrote:
>>> =C2=A0create mode 100644 contrib/completion/git-prompt.sh
>> Hi,
>> since git-prompt is not completion related anymore, should a differe=
nt
>> directory be used?
>
> Making it even more likely that the __gitdir in one will someday not
> match the __gitdir in another...

Which is not a big deal IMO. The "bad" __gitdir() won't get worst than
the current one.

> Maybe __gitdir should live inside git-prompt and git-completion would
> include git-prompt. That would make everything backward compatible
> too. And that way there's a good answer to why git-prompt lives insid=
e
> the completion directory.

That's not bad, but still needs people to copy multiple scripts, and
edit. I prefer to have a 'git dir' or something.

--=20
=46elipe Contreras
