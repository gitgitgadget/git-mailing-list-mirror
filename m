From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3] fast-import: add 'ls' command
Date: Fri, 11 Feb 2011 23:47:08 +0100
Message-ID: <AANLkTimReMYu7QYZEuunmH6WqUz=C0nOnAZHzB6cddXt@mail.gmail.com>
References: <20110211224339.GA9973@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 23:48:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po1mY-0007Tn-Og
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 23:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758416Ab1BKWrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 17:47:49 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33821 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392Ab1BKWrt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 17:47:49 -0500
Received: by iyj8 with SMTP id 8so2903706iyj.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 14:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=k0R3UkdTcntpwMmFsdRtaLdHlldj8aQU2gtSLXNZeEw=;
        b=dyH1WuGiBj6rhPaArOvMo0wf64W+MSdw0PKriZLM1zxie5U3T25LN17lgAYZtxTlv+
         wZpr2mtc7ToAsh3bp0K4Wk04W/1r42RAUf9Q8tM8BCAJiIINgvEYAWpXvL9lJp0wKBaF
         MpBMbrlwsRZNAyeuO1vlnJvSLEndf6eVFIaUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uM2jlSNbSpXXsn3On2/Phcr368BlCiY5mkpbLNJpRqOy0RMue51X5/yHCnIyqD9IWl
         PtFw6iuZLjyAhcLh86s14DHlUAzISI/UMKE0PSlaR3G8Q8zYWY2DxoBbHC910yJlotTg
         lQA59aDW/fvCfOgxqtXD/rnkza6gnrD5qHt7w=
Received: by 10.231.36.7 with SMTP id r7mr789563ibd.136.1297464468479; Fri, 11
 Feb 2011 14:47:48 -0800 (PST)
Received: by 10.231.11.132 with HTTP; Fri, 11 Feb 2011 14:47:08 -0800 (PST)
In-Reply-To: <20110211224339.GA9973@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166576>

Heya,

On Fri, Feb 11, 2011 at 23:43, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Introduce an "ls" command to read directory entries from the active
> commit or a named commit. =C2=A0This allows printing a blob from the =
active
> commit or copying a blob or tree from a previous commit for use in th=
e
> current one.

Useful addition I think. What happens if you ask it for a path that is
not a directory?

--=20
Cheers,

Sverre Rabbelier
