From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 10/18] git notes merge: Handle real, non-conflicting notes merges
Date: Wed, 29 Sep 2010 16:20:54 +0000
Message-ID: <AANLkTingYp89fY9QxzmdJgF587C29cArxyBU--QcBY5G@mail.gmail.com>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
	<1285719811-10871-11-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 18:22:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0zPv-0008PO-F8
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 18:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab0I2QV6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 12:21:58 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45621 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab0I2QV5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 12:21:57 -0400
Received: by gxk9 with SMTP id 9so332127gxk.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8p9s9AtChI/onCRoTFvLyMtNO1rANtOiRGXsGfFOuEQ=;
        b=WyE3qAEMb9WZ2rf3eggIuYqrkiVbvixuCZZcdSrKcCwgOHrOg73wXq5DTsUvjFwHnh
         Sd5vpjOEsKSqtp0/yn2y/VPs8Zc8OYvO9KTFUfrCmuE856snwfo4Es65Fv/IoOSENNCz
         5XJSXQ1xQUskm67O2z3qtmDaXEhp+WWK/ItzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zj51eMUZDAzHozlsjOPJa6yLr5kXS9yKv8rxJJcKi0xydUhtTaILx+8MWwgTn29ejW
         ktFnMkvrJdDQtQtvAqBf3mbo3eLScnaSPRgcvS+IaXj7kHoEotoaqBX0n1CDI0PyQClB
         xqdcKCBLfsKCkUr9mmVe11qQIvEABv9mgXSVQ=
Received: by 10.231.80.213 with SMTP id u21mr1210156ibk.173.1285777254833;
 Wed, 29 Sep 2010 09:20:54 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 29 Sep 2010 09:20:54 -0700 (PDT)
In-Reply-To: <1285719811-10871-11-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157584>

On Wed, Sep 29, 2010 at 00:23, Johan Herland <johan@herland.net> wrote:

> + =C2=A0 =C2=A0 =C2=A0 o.commit_msg =3D msg.buf + 7; // skip "notes: =
" prefix

Don't use C99 comments.
