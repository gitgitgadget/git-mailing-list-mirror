From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 00/16] Subtree clone proof of concept
Date: Sat, 31 Jul 2010 23:14:09 -0500
Message-ID: <AANLkTinMBAikByLfOi5sXbcRfCsYtYqMCNSTykRofQyo@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 01 06:14:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfPwl-00013F-0B
	for gcvg-git-2@lo.gmane.org; Sun, 01 Aug 2010 06:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954Ab0HAEOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Aug 2010 00:14:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43189 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab0HAEOa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Aug 2010 00:14:30 -0400
Received: by ywh1 with SMTP id 1so976727ywh.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 21:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kyUYG9J42vxLQwrKq7oOTRCps35wmnq1yaVjy4SPrkY=;
        b=dkAoQp+WZWLv0cvc7efCB9XbO0gW7JbsU7eBbWDNXtXpESb+mGscC0yAV0sHyJh+18
         2ASIEdaBVJvbY7rYUz34zmyi4kSKlHg70y+6K3aeGWXDq4KuCxrS2P0/bA8yqUL9Lk8W
         viplGFEI0YRlzN+Hx1WJin4sbqDm5YykO5TR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iRIjpAfAu9/pzP2CCi6Xb1TrHJMKWVrWwUNlM7+fEYAzguBT3ExGTxOSWFAhXeUiO7
         7a3TqiSJBXADOmk/hI6E3wTrv1vxfMr6tYodbICq+J9gQCS+KiQ/kO8s6LKTu7ZsCsnc
         wMwAwgy/bV8/FS2RAyshaw5Bdv1s8Uc4Y+q3U=
Received: by 10.150.63.16 with SMTP id l16mr5130342yba.153.1280636069188; Sat, 
	31 Jul 2010 21:14:29 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Sat, 31 Jul 2010 21:14:09 -0700 (PDT)
In-Reply-To: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152367>

Heya,

2010/7/31 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> With this, I can clone Documentaion/ from git.git, update and push.

Very nice!

> Space consumption is 24MB (58MB for full
> repo). =C2=A0Not really impressive, but if one truely cares about dis=
k
> space, he/she should also use shallow clone.

Can they be combined to create the fabled narrow checkout?

--=20
Cheers,

Sverre Rabbelier
