From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Wed, 12 Aug 2009 16:53:26 +0700
Message-ID: <fcaeb9bf0908120253p192125a4mbb6a0838fc90f10e@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-2-git-send-email-pclouds@gmail.com> <1250005446-12047-3-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-4-git-send-email-pclouds@gmail.com> <1250005446-12047-5-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-6-git-send-email-pclouds@gmail.com> <1250005446-12047-7-git-send-email-pclouds@gmail.com> 
	<1250005446-12047-8-git-send-email-pclouds@gmail.com> <1250005446-12047-9-git-send-email-pclouds@gmail.com> 
	<4A826FD4.5080201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 11:54:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbAWt-00025H-Ij
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 11:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbZHLJxq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 05:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbZHLJxq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 05:53:46 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:38308 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbZHLJxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2009 05:53:45 -0400
Received: by yxe5 with SMTP id 5so5487759yxe.33
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6iuuieaBlPox7+/LK5MwhuVGZOT4VxkFMjHPR6w06gM=;
        b=sSZXhDw/mn5Mnv9GyoqK2QO5W8+xIi0A9/DhmO7XVq3ztpJiDvL/TuXpDYOlctW5NP
         wQ2KmCbWPJ92OR2yUR9CEgQ4pV4j2YUo7X+dFJpSWC8ETR3iCC3n/NoMIFNhjVJmevXB
         hPMe6saZd6p2eKgldS0xJnI/fRSr6znzxJJSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wvKsyw+EI+wN7j+ZGDhw2Xn5glP5W/js3Jv0rn7bdm3k6E8RIFC8y/Bmxlfc+4sM9W
         7OcJTpmbGQi0IErIMZ0b2YQs39wjZnmKsiujoDz1txuExXGD8hOWTZupGuUg54t9RMmw
         ia3TyZTVbAFEDyHlZ5goRc948JYV6QSApyXUc=
Received: by 10.100.45.13 with SMTP id s13mr6659516ans.193.1250070826092; Wed, 
	12 Aug 2009 02:53:46 -0700 (PDT)
In-Reply-To: <4A826FD4.5080201@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125689>

2009/8/12 Johannes Sixt <j.sixt@viscovery.net>:
> BTW, the name .git/info/sparse is perhaps a bit too technical in the =
sense
> that only git developers know that this feature runs under the name
> "sparse checkout". Perhaps it should be named
>
> =C2=A0 .git/info/indexonly
> =C2=A0 .git/info/nocheckout
>
> or so.

I did not like the name "sparse" either. Another option is
=2Egit/info/assume-unchanged.
--=20
Duy
