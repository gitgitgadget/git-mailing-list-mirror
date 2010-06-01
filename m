From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: HELP: cannot clone a repository via http_proxy on FC13
Date: Tue, 1 Jun 2010 12:03:54 +0800
Message-ID: <AANLkTinyKoH4QiTnIbBQ60sMNZHKqtYejk-t2ygj9naK@mail.gmail.com>
References: <AANLkTimefBKp5So03RKaZRqQXePO1KY6EgMRxN0zsf8M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sylvia Liu <sylviaonlyone@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 06:04:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJIht-0003fF-3m
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 06:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837Ab0FAED4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 00:03:56 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:64449 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab0FAED4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 00:03:56 -0400
Received: by ywh9 with SMTP id 9so3209870ywh.17
        for <git@vger.kernel.org>; Mon, 31 May 2010 21:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hhdgyKlLr7Cy1+cP1FMreP67vkZ0sGBRuwSrjcDM9nQ=;
        b=JlKP40uxrgbdUTOsbEXIfWUpJyqtDjVCyj0ioiQNYcZh1hHoQRw9ZcTppz5wGrHu9d
         f3auyxdT1b7tP2yx/2N8BUQyO4y4TOOvUYsqwQgErmctzkQ0ff4Mobt4CGfRGyI1Cbf+
         1gHwoZMFB50bTeqFunmfS5EIk/nSIQtgfme5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ql93mR28fZkMjY9ZhaXbBRDE40C6KkH0BPg+Iw/BoYYJqLKQT0MKA8+BTwbLfy22LV
         zcgU+uCsRX4DJAnHkXjBE89is3sWUFmhnFB4M0W59qC/XSB3dIJmClf7E+69a+01LtP0
         RLBCs3RtF4oH7oK2Orri/TJDRCPZdhEpB80hA=
Received: by 10.231.195.16 with SMTP id ea16mr6910770ibb.64.1275365034240; 
	Mon, 31 May 2010 21:03:54 -0700 (PDT)
Received: by 10.231.33.12 with HTTP; Mon, 31 May 2010 21:03:54 -0700 (PDT)
In-Reply-To: <AANLkTimefBKp5So03RKaZRqQXePO1KY6EgMRxN0zsf8M@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148074>

Hi,

On Tue, Jun 1, 2010 at 11:30 AM, Sylvia Liu <sylviaonlyone@gmail.com> w=
rote:
> I tried this command:
> =A0 sudo git clone
> http://git.gitorious.org/meego-developer-tools/image-creator.git

Probably not related, but why sudo?

> got the error messages as follow:
> =A0 Initialized empty Git repository in
> /home/sylvia/workarea/DEV_TOOLS/test/image-creator/.git/
> =A0 error: Failed connect to git.gitorious.org:80; Operation now in
> progress while accessing
> http://git.gitorious.org/meego-developer-tools/image-creator.git/info=
/refs
>
> =A0 fatal: HTTP request failed

Can you try

  $ GIT_CURL_VERBOSE=3D1 git clone
http://git.gitorious.org/meego-developer-tools/image-creator.git

and paste the output here?

--=20
Cheers,
Ray Chuan
