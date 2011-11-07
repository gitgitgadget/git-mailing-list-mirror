From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] Documentation/gitignore: explain how to un-ignore
 part of a directory
Date: Mon, 7 Nov 2011 17:23:27 +0700
Message-ID: <CACsJy8BND-fg0YoUiSpYo1KiNjt604uQ395+KMTK-E6QP7oSdw@mail.gmail.com>
References: <20111107080449.GA30448@elie.hsd1.il.comcast.net> <20111107081132.GD30486@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Blake <eblake@redhat.com>,
	Johannes Sixt <j6t@kdbg.org>, "Y.G." <yamomo1@hotmail.com>,
	Eli Barzilay <eli@barzilay.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 11:24:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNMN5-0001zJ-Dn
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 11:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab1KGKYB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 05:24:01 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36159 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab1KGKX7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 05:23:59 -0500
Received: by bke11 with SMTP id 11so3441582bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 02:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gZJAINe9wSsD9tPnHi9wZQUleXnEpCJkRYt9Kgn2JiU=;
        b=dPuxmu3iNzUIu8R2Qs04r9FMeX0XkNv2z04uVd4QstMAM1anIygX0RPx8r9C4PFw3Y
         C08egzmKR9oiVDAocX3iIU8bZbikDqRvCfM+DmrMCmyuyyndqX/z90wEZ1J1lt2KdTJs
         edkOmJ6Blrj0hyMEk+2GvE+b9TeU5XMhQYTCE=
Received: by 10.204.147.215 with SMTP id m23mr18354448bkv.84.1320661438149;
 Mon, 07 Nov 2011 02:23:58 -0800 (PST)
Received: by 10.205.134.1 with HTTP; Mon, 7 Nov 2011 02:23:27 -0800 (PST)
In-Reply-To: <20111107081132.GD30486@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184971>

2011/11/7 Jonathan Nieder <jrnieder@gmail.com>:
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 5 Apr 2011 23:15:54 +0200
>
> Trying to whitelist a single file pattern in a directory that I was
> otherwise content to ignore, if I try
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/m4/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0!/m4/virt-*.m4
>
> then 'git add' will keep warning me that I have to use -f. =C2=A0That=
 is
> because ignoring a directory is much different than ignoring all file=
s
> in a directory, when it comes to later negation patterns:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/m4/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0!/m4/virt-*.m4
>

gitignore.txt is also referred in sparse checkout. And (un)fortunately
the former also works in sparse checkout. I don't know, may be you
could put this in a subsection or something reference-able so we could
mention in sparse checkout document that this part of gitignore.txt
does not apply to sparse checkout?
--=20
Duy
