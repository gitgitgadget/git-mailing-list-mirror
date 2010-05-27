From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] Support building on systems without poll(2)
Date: Thu, 27 May 2010 10:43:35 +0200
Message-ID: <AANLkTikoFSMmAyCYPoejTObEmCMv4TmTDx7P4sdWcOJy@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org> 
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mduft@gentoo.org, jrnieder@gmail.com
To: Jonathan Callen <abcd@gentoo.org>
X-From: git-owner@vger.kernel.org Thu May 27 10:44:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHYh8-0005jA-H5
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 10:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616Ab0E0In5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 04:43:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59630 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587Ab0E0In4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 04:43:56 -0400
Received: by gwaa12 with SMTP id a12so1713634gwa.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=in2gACNzZEM9vmXAPl5p5bvm6HqzeYCvuHdSuxsiTvE=;
        b=KWBbGnEPOiA4rTx1FlX3yA5O0YFBSIE0WrX4LBJiQsyQw6FU2/d48tbHLrkFaxa9HH
         xOw8zRQjPXGgDtzvH7kGQFQ4IPxhrIxFN9DZnoqpLx7JtYDTSKmh/bzhwt47UTbtaUNR
         pw0Pyau3xmAK4IF5jJeaRMYCLNyToT6qwzEAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FQYqefYUSMK3lPlxzwOweq4uT3PmBPujPHHEB84rwA+8csoPTsxUn6ogvOAq/roGa3
         CkUGGAZPdx3aM31LVbmK64er/emK/z2QC+9X4F1L+9MYNhT2UMpmujd5umbrG078fxcs
         ufuaEqvtNgJdfvzGMwsnrw+UX+jgkZvy548HA=
Received: by 10.150.160.8 with SMTP id i8mr9983538ybe.395.1274949835526; Thu, 
	27 May 2010 01:43:55 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Thu, 27 May 2010 01:43:35 -0700 (PDT)
In-Reply-To: <1274948384-167-2-git-send-email-abcd@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147837>

Heya,

On Thu, May 27, 2010 at 10:19, Jonathan Callen <abcd@gentoo.org> wrote:
> Some systems do not have sys/poll.h or poll(2). =C2=A0Don't build
> git-daemon, git-upload-archive, or git-upload-pack on such systems.

I thought git-upload-pack is required for push support in git?

--=20
Cheers,

Sverre Rabbelier
