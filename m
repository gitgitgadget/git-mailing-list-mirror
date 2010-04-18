From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] Documentation/urls: Rewrite to accomodate 
	<transport>::<address>
Date: Sun, 18 Apr 2010 09:29:54 +0530
Message-ID: <i2gf3271551004172059sb3abbafcz2feb9eed14e596aa@mail.gmail.com>
References: <1271552047-sup-9523@kytes> <20100418025940.GA2249@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 06:00:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3LgF-0003ne-Qe
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 06:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815Ab0DREAR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Apr 2010 00:00:17 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:33835 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab0DREAP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Apr 2010 00:00:15 -0400
Received: by gxk9 with SMTP id 9so2365783gxk.8
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 21:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=QJ6jQbkSGUZeFD4yfBrfGMSm9m+16iojWjC7qB67834=;
        b=x4BRFbGfXgy1WkF8LS3C9WY/+v3HDIz3LxdJx3t8ZSlGEbwm7NzmrbPrPTpasAxIzB
         e3lwtR7GdHY3om0QrPmbFPCB/bvLZWvRJqg/aknUizNMoY+uku0xtR3GlvbCaS49SiaK
         L8O1cHyC8XbrUbFweAqhoalgQJibpjbiXuQUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lKe9Auu7YYhn00hgVD6EpDr7Gu0fUeYm8G0svmI82ei8DUAej8nLec4Ak/zqPE3bIt
         LN4Eb5ZKMC3d/JuYc180TdLe2RfLFd/KC3K/r79xvxu66SRUdT42oDr2HPxOaI6fcvka
         f7gZJ9ZQ4xsZefIrzVxgne/AdRi/6jVz8pmJE=
Received: by 10.90.69.14 with HTTP; Sat, 17 Apr 2010 20:59:54 -0700 (PDT)
In-Reply-To: <20100418025940.GA2249@progeny.tock>
Received: by 10.91.154.4 with SMTP id g4mr2102096ago.26.1271563214191; Sat, 17 
	Apr 2010 21:00:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145210>

Hi,

> Hmm: if it is not built in to the git binary, is it right to call the
> support native? =C2=A0I don=E2=80=99t mean to say HTTP support is a s=
econd-class
> citizen (with http-backend on the server side, it isn=E2=80=99t any m=
ore), but
> it is possible that remote-http is not installed on a system. =C2=A0A=
lso, it
> is a good example to introduce remote helpers with.

By "native", I meant that no special remote helpers are necessary (it
would be with svn, for example). Does the technical detail of whether
the support is built into the main Git binary need to enter the
documentation?

Thanks for the review! :) I'll post a fixup patch soon.

-- Ram
