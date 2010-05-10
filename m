From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Instead of rebasing, etc....?
Date: Mon, 10 May 2010 10:49:46 +0200
Message-ID: <AANLkTikikb5rKfxBlqrNfgLQhKRYKZ_e-760vWEMLKQ1@mail.gmail.com>
References: <loom.20100507T003055-527@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Mon May 10 10:50:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBOgo-0002i5-OK
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 10:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab0EJIuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 May 2010 04:50:08 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:55798 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535Ab0EJIuH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 May 2010 04:50:07 -0400
Received: by qyk13 with SMTP id 13so5762436qyk.1
        for <git@vger.kernel.org>; Mon, 10 May 2010 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Dztiu2zAXNm4EYyaCJjp/EQ4x6hkUv0dDOLTnlEjseg=;
        b=EXQRhUZuuQnnUhrQGsDhyVgNVrzFVPZYBJoNp0SuOYZ0SQ3NIUXZjpUvNK21oK4X6y
         8cKr2rTe9TZTZIowORCwjrfAXJLd3m/J5579eMHEHHyTiA+l12T213BccGgnwJifW99B
         9T/z6vgSqqFLT17dWv6XLVrVVMl3RigjSYNcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GuhC3rFUO37pboPHX08Ntm+lfBaRauqoMtWwrsHgOpnxtdgEO3b97U+1ZzL6sUsVZn
         CttORAK9bqR91CK4cTyC5RRtHN2P9IV3TefOOV74qyuadSuTDxlUpFVp/k8bWzw4ua3Q
         qZMbmNFJx0JkKM9/VoXyUe65Hrw6+KnH19PKI=
Received: by 10.229.181.142 with SMTP id by14mr2957671qcb.18.1273481406168; 
	Mon, 10 May 2010 01:50:06 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 10 May 2010 01:49:46 -0700 (PDT)
In-Reply-To: <loom.20100507T003055-527@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146774>

Hi,

> Of course then I want to push dev and move origin/dev to refer to it.
> So I delete and recreate origin/dev. =C2=A0That's essentially like
> rebasing, and all the advice says "don't do it." =C2=A0How bad is tha=
t,
> really, if it's my own development branch?

If I understand correctly, you want a non-FF push. Simply develop on
dev and `git push origin +dev:dev` to force a non-FF push. It's not
bad at all if your branch isn't public and others aren't pulling from
it.

-- Ram
