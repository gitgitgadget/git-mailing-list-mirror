From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: combined diff does not detect binary files and ignores -diff attribute
Date: Mon, 23 May 2011 18:55:07 -0400
Message-ID: <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
	<4DDA618E.4030604@drmicha.warpmail.net>
	<BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
	<20110523181147.GA26035@sigill.intra.peff.net>
	<20110523201529.GA6281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 00:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOe1q-0007VZ-JL
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 00:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591Ab1EWWzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2011 18:55:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55972 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852Ab1EWWzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 18:55:08 -0400
Received: by pwi15 with SMTP id 15so2792043pwi.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+wR42ZR1gfbqTzdbDbaeJmiyQdhK2LrNh4c6ZTopBnA=;
        b=MAehJHBCNXHJMV1TKXF+aUU0lLZ2e6ApB2G9+n3vX+RlUncdLDsD8S/tiKG8Fkgcv+
         ioFBeu1Oa5cAK0dES37rF/pba7fdRWB3B/BCSNaduOBOHVymYjSTdakMMB1OJZG0Uduy
         MzxyZpLvELxO3E37KTbXjTMIM8H6sii/SXcCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=emvbD20VJiUmezW5+meaFsVH2Up1hqWsNYxgmSj/75npymQVP/g2gRjmyUFUiPdHnw
         FY3XWNwUYQfUMvPrxkUQaA4+0jChiJdM70i9jr4layisKZXztPzn6il0CTmaJF1CL4hu
         S7sIblEFE24LJORKPL/M0IeobieBlIUIHrumY=
Received: by 10.142.122.8 with SMTP id u8mr856715wfc.283.1306191307953; Mon,
 23 May 2011 15:55:07 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Mon, 23 May 2011 15:55:07 -0700 (PDT)
In-Reply-To: <20110523201529.GA6281@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174285>

On Mon, May 23, 2011 at 4:15 PM, Jeff King <peff@peff.net> wrote:
> It turned out not too bad:
>
> =C2=A0[1/5]: combine-diff: split header printing into its own functio=
n
> =C2=A0[2/5]: combine-diff: calculate mode_differs earlier
> =C2=A0[3/5]: combine-diff: handle binary files as binary

Tested-by: Jay Soffian <jaysoffian@gmail.com>

In a real-world merge, png's were correctly shown as "Binary files
differ". I also tested with "*.xib -diff" and that worked as expected.

However, custom diff drivers (still) don't work. :-)

Also read the patches and they LGTM.

> =C2=A0[4/5]: refactor get_textconv to not require diff_filespec
> =C2=A0[5/5]: combine-diff: respect textconv attributes

Didn't test explicitly, but don't see anything obviously wrong.

Thanks Peff,

j.
