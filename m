From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Prevent users from adding the file that has all-zero SHA-1
Date: Tue, 20 Sep 2011 11:55:47 +0530
Message-ID: <CALkWK0n9kJtUPrpxTmtfH7kVd7CksULjt7bo3cFhOrS_NBVbMw@mail.gmail.com>
References: <1316259574-1291-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 08:26:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5tma-0004Tt-OG
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 08:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab1ITG0J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 02:26:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53401 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab1ITG0I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 02:26:08 -0400
Received: by wwf22 with SMTP id 22so305306wwf.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 23:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2EoUpdcs/AbshKFr3UHS2t+Y0aQd2spYXrPc4rw4cKI=;
        b=yEV5a1cvGPo2DBg6Pp7iZHbZBF7UKpVohedB5CU6TPXQ6qhCQeCqVLyF2RrwJl2dyZ
         Jh7HL1V13YmmqyVCT3fTx3XSrdn4yxTUFtEFCKCPuix1P9zWfF+zSKvuc8qrFoAJCCRg
         eIxXbWwgE0YC3UU8LyjC0sHEdGhctvgpCRU8g=
Received: by 10.216.181.194 with SMTP id l44mr438942wem.87.1316499967092; Mon,
 19 Sep 2011 23:26:07 -0700 (PDT)
Received: by 10.216.51.207 with HTTP; Mon, 19 Sep 2011 23:25:47 -0700 (PDT)
In-Reply-To: <1316259574-1291-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181733>

Hi Nguy=E1=BB=85n,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy writes:
> This particular SHA-1 has special meaning to git, very much like NULL
> in C. If a user adds a file that has this SHA-1, unexpected things ca=
n
> happen.
> [...]

Interesting patch.  Is it possible to write some sort of testcase?

-- Ram
