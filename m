From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sat, 19 Mar 2011 23:47:33 +0700
Message-ID: <AANLkTi=iMZWTG8DJWSrkjzNR6FFkc_mo_epQLNfkwZiV@mail.gmail.com>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
 <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com> <AANLkTi=EQhtOM3dR8V5dxP=AfNxWuSFoTbvzL36q3rXL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?B?cnllbnVzIOKXhw==?= <ryenus@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 17:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0zJz-0000av-BX
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 17:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529Ab1CSQsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 12:48:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49420 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473Ab1CSQsF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 12:48:05 -0400
Received: by wwa36 with SMTP id 36so5963883wwa.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=O38n1uUn5cPKWXtoT6NLby/j2hHWFx91zqrlZSwSvEE=;
        b=hYb6WTCDGMiDGrMK5KkzGMXzjD2GmJtMlxSS6l95QhTzzP6HB+KiNlkt+SNGZ6WQej
         Zmy61FVb+ncjJ87pZ1jKf6fjn+9OM9lQCEKPgDN3wP9o0RxBME+AJVVRD5uQqcWjZpks
         hs7ttTncTKIqFGIjTsQowsmLEQQ7ldRxhqGRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h20SUXFvon88ERc2uTbkAnMQG+wMupgEixCWRS1dG221KFscRBGLq54rHY5VlwE/t3
         Mg8Eo1vHGI4WX6jCF4It/VOwbJDJ+uPuhnE5sT/e5ahfdQxlPZk0AQbqavB9c+NasBFu
         SCD2nDM2mk4DT82IgQ26hTDpxqFIYL8CS7rMM=
Received: by 10.216.24.132 with SMTP id x4mr3691829wex.81.1300553283158; Sat,
 19 Mar 2011 09:48:03 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Sat, 19 Mar 2011 09:47:33 -0700 (PDT)
In-Reply-To: <AANLkTi=EQhtOM3dR8V5dxP=AfNxWuSFoTbvzL36q3rXL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169450>

On Sat, Mar 19, 2011 at 11:43 PM, ryenus =E2=97=87 <ryenus@gmail.com> w=
rote:
> OK, I've been away for a while and didn't notice latest replies :-) d=
o
> you mean find is not used elsewhere in git?

That's what 'git grep find *.sh' told me. Anyway I suppose our
testsuites cover all commands quite good so we would notice if any
other commands still use 'find'.

> Anyway, looks like checking for both MinGW and Cygwin still applies.

I don't use cygwin so I don't know if cygwin users are happy with
that. But it looks ok (unless some users decide to move find to
another place)
--=20
Duy
