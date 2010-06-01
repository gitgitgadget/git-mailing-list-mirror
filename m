From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/8] Documentation/cherry-pick: describe passing more than 
	one commit
Date: Tue, 1 Jun 2010 11:29:32 +0200
Message-ID: <AANLkTikHODw5irE-84bkztWhUKgP8v1PG9zTW1Ea6WRs@mail.gmail.com>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org> 
	<20100531194240.28729.50475.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:29:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNnK-0000dH-8n
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab0FAJ3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 05:29:53 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54583 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab0FAJ3w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 05:29:52 -0400
Received: by mail-vw0-f46.google.com with SMTP id 11so751297vws.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JhpftOoRpqRdzvTIl9V/gty9O66t6T1LoYV2yB0kLo8=;
        b=hLJfNFV7gRhhSkx6jfCqQT7OUVitqj9rqM8OxCMe4JxEt2iW20Tn69evGvkrTq1a8Z
         TWat+ZBgPKRvjs97axQY4FoWWH2cQRBnMBy1AONzc1r3OD0baW1puY5WW/ppflPo8/g+
         3UUT6NJYqq/F/iMEiMIXw4Aa+HqX7Gun+Jf00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YLcG9l9oytSNGdq1Cr+bZzvJAeuqibY1hsuJQT5Ce2kQsYkaHW9OecMEzT+QZ3u0r9
         sqWi0QZpXm9XMQ3sBQYRkUBTUXt2G/8mZ7Lf5EGm+LTYP8bILvBDBh9cnccJgAq0HtXQ
         7mK7BVXNiRIjUeOntgNQmuvIyWrRUL4LzUL9I=
Received: by 10.224.115.27 with SMTP id g27mr2141391qaq.311.1275384592101; 
	Tue, 01 Jun 2010 02:29:52 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Tue, 1 Jun 2010 02:29:32 -0700 (PDT)
In-Reply-To: <20100531194240.28729.50475.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148101>

Hi,

Christian Couder <chriscool@tuxfamily.org> wrote:
> =C2=A0-n::
> =C2=A0--no-commit::
> - =C2=A0 =C2=A0 =C2=A0 Usually the command automatically creates a co=
mmit.
> - =C2=A0 =C2=A0 =C2=A0 This flag applies the change necessary to cher=
ry-pick
> - =C2=A0 =C2=A0 =C2=A0 the named commit to your working tree and the =
index,
> - =C2=A0 =C2=A0 =C2=A0 but does not make the commit. =C2=A0In additio=
n, when this
> - =C2=A0 =C2=A0 =C2=A0 option is used, your index does not have to ma=
tch the
> - =C2=A0 =C2=A0 =C2=A0 HEAD commit. =C2=A0The cherry-pick is done aga=
inst the
> - =C2=A0 =C2=A0 =C2=A0 beginning state of your index.
> + =C2=A0 =C2=A0 =C2=A0 Usually the command automatically creates some=
 commits. =C2=A0This
> + =C2=A0 =C2=A0 =C2=A0 flag applies the change necessary to cherry-pi=
ck the named
> + =C2=A0 =C2=A0 =C2=A0 commits to your working tree and the index, bu=
t does not make
> + =C2=A0 =C2=A0 =C2=A0 the commits. =C2=A0In addition, when this opti=
on is used, your
> + =C2=A0 =C2=A0 =C2=A0 index does not have to match the HEAD commit. =
=C2=A0The cherry-pick
> + =C2=A0 =C2=A0 =C2=A0 is done against the beginning state of your in=
dex.
> =C2=A0+

Avoid re-wrapping the text so it's easy to see the changes that you
have introduced in subsequent blames- you've just changed the word
"commit" to "commits".

> +Examples
> +--------

Style nitpick: shouldn't the word "Examples" be in all-caps?

-- Ram
