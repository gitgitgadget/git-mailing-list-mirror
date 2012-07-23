From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2 0/7] i18n for git-am, git-rebase and git-merge
Date: Mon, 23 Jul 2012 11:14:17 +0800
Message-ID: <CANYiYbFvk60NxfOTxq-xS8vt5t9xW8HLQrE_GuHGkC+u6vWfsw@mail.gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
	<7vmx2rr320.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 05:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St96O-0001nq-Oh
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 05:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab2GWDOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jul 2012 23:14:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33404 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab2GWDOS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2012 23:14:18 -0400
Received: by obbuo13 with SMTP id uo13so8833791obb.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 20:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HMK+urYRJgb8h9M+fuVCAkiPrGmYxKx09zJBSEbQvD0=;
        b=kMWCVJHL09ThKlSnABlsGQd6PLzl4yhrHjwqe5Sko15iglOtl9rhYW4C1iGCNYhITT
         sWH3JbXxpGTt10ubfi2H19xezXzrj6Ly2XjhidF7CcvchwZ/REUX/nuVmACZ78vY9vdD
         Ha8OrxqR0MZWzXi/mrruszTz/srZC6LGVNuDBbI/g4GznbC7s9fL2C9yWoJwkAkWB+L2
         EYqSJZKf0b+Ou0B1At6Z/OzuP3f3b8Lea/XMZDE+9aHAesrtIM6dCJ3AA3PPGYMtU4MZ
         mZJkx4dQ7bVX8R5+S+aTQeJa3TZxU6tVJmyLcjKD4HR3F6ibiG5f33NDGnkmReAFZSpG
         wp2g==
Received: by 10.50.181.161 with SMTP id dx1mr13159355igc.52.1343013258199;
 Sun, 22 Jul 2012 20:14:18 -0700 (PDT)
Received: by 10.50.237.38 with HTTP; Sun, 22 Jul 2012 20:14:17 -0700 (PDT)
In-Reply-To: <7vmx2rr320.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201880>

2012/7/23 Junio C Hamano <gitster@pobox.com>:
> I do not understand why many of these have Stefano's S-o-b in them.
> If you are relaying what Stefano originally wrote, then the author
> (i.e. "From: ") and the first S-o-b would say Stefano, and your
> S-o-b will follow it, but that is probably not the case.
> I'll drop the S-o-b lines for now.

It is because Stefano offers lots of help for correcting syntax errors
and misspellings in the original commit logs. Should I use Reviewed-by
tag instead of S-o-b?

And in PATCH 3/7, there is a =C6var's S-o-b, it is because the workarou=
nd
comes from =C6var's idea. Is this tag suitable? I think I should add a =
Reported-by
tag for Vincent, as he report it first in this mail:

    http://thread.gmane.org/gmane.comp.version-control.git/199042

> By the way, is there any existing test that needs to gain GETTEXT_POI=
SON
> or test_i18ncmp with this change?

I find one test case failed, and correct it in PATCH 3/7.

--=20
Jiang Xin
