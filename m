From: Dilip M <dilipm79@gmail.com>
Subject: Re: how to reset to remote repo
Date: Mon, 23 Feb 2009 17:44:58 +0530
Message-ID: <c94f8e120902230414v33d36acelc3dc39861646539a@mail.gmail.com>
References: <20090223105546.GA7425@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 13:16:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbZja-0006EJ-Dj
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 13:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537AbZBWMPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Feb 2009 07:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbZBWMO7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 07:14:59 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:13255 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbZBWMO7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Feb 2009 07:14:59 -0500
Received: by yx-out-2324.google.com with SMTP id 8so768791yxm.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=kHJPFPHy9Vd6fAJdvnXfUTq5VWHc6Y6gBLKcv1+HRYA=;
        b=AgHXKy7JMYIKzsHQBq7ZBZa7v/UI04MJHrhsF80VT0jc/uKhkq9RdpcbnNKfvxLHfP
         Y0pLj9gE60qGaNP7tahbQTqBVl30zALltiYbL2u9OpK5WUi+rY9I0Gg88zkmepbmg/IZ
         IccB6PR33RT4QpC4jXHUUlBbq4FuKjkWuzrRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=fEJWBLXzDEToZDeVEXia3qH9/13ilcV52kcHS/y8eMXe+2Oru3SbwLK/nqNQjiDq6Z
         9rCxDbsF1E5Wpto7d7EQTARalPmimGt0JJCyaWJ9ZbrIzYdgOAp999ynkQaeLdH+NOf0
         XE1FvXWMLCJpw73DX4liv8sU0rQMd+5En6SQo=
Received: by 10.100.6.16 with SMTP id 16mr1500872anf.151.1235391298078; Mon, 
	23 Feb 2009 04:14:58 -0800 (PST)
In-Reply-To: <20090223105546.GA7425@b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111132>

git reset --hard HEAD

-- BR, Dilip




On Mon, Feb 23, 2009 at 4:25 PM, bill lam <cbill.lam@gmail.com> wrote:
> I cloned some public git repos and made some local patches. Later I
> pulled updates again and that merged with my patches. Now I want to
> throw away my patches, how do I get a clean working repo that is a
> 100% clone of the remote repo?
>
> --
> regards,
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> GPG key 1024D/4434BAB3 2008-08-24
> gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
> =AD=F0=B8=D6285 =B1i=D2=E9  =B6=B0=C6F=BBO=A4G=AD=BA=A4=A7=A4G
>    =E7~=B0=EA=A4=D2=A4H=A9=D3=A5D=AE=A6  =A5=AD=A9=FA=C3M=B0=A8=A4J=AE=
c=AA=F9  =ABo=B6=FB=AF=D7=AF=BB=A6=C3=C3C=A6=E2  =B2H=B1=BD=B8=BF=AC=DC=
=B4=C2=A6=DC=B4L
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
