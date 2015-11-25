From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v4] blame: add support for --[no-]progress option
Date: Tue, 24 Nov 2015 22:33:49 -0600
Message-ID: <CAOc6etYBT_PBknCMuSr4=ARke-sNY8-YrO9yp20v7NkzDwrsMQ@mail.gmail.com>
References: <1448327277-29385-1-git-send-email-eantoranz@gmail.com>
	<5653FC4D.4090201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 05:34:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Rmg-0003ni-Iz
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 05:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbbKYEeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2015 23:34:19 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32886 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299AbbKYEdu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2015 23:33:50 -0500
Received: by pabfh17 with SMTP id fh17so45666599pab.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 20:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3jmv7KPB0bLML/jkgjcWVUigFubqFmBspVlhnjEsl4o=;
        b=uHaH58xW9IVSQ+yki0E1Hx508oyY6nDKOWqH7JGaanDit2nipb7QjVENx1lrvVIiHX
         xDqplyy3lXQeE7y1oyzhsWwVd+CNCJh4meyr0Utpl3FOh+3c9Spz5krFmH4ve6203W0w
         mK7oGfvkElXvmAm2bZgzh7f5KWn/JmCMOPFdPVEblC1n2Pw+xcDyyzP8g+ewN4H3sKa9
         M199n3SzKT5I3+hbkpy5bFaarsWy6adK5jy1borvL7aswwAm3zlWzSvzWzQLne2WVfQT
         UhjZTprJJ2eZVT86IVQ6YG3xH0qDVFcpfU8AjmPETMi6Oq4K+c/0YYWk0P1ORsMLLaK5
         ooRQ==
X-Received: by 10.98.16.133 with SMTP id 5mr28110310pfq.150.1448426029730;
 Tue, 24 Nov 2015 20:33:49 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Tue, 24 Nov 2015 20:33:49 -0800 (PST)
In-Reply-To: <5653FC4D.4090201@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281676>

On Mon, Nov 23, 2015 at 11:57 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> Minor remark: The '*' should be close to the variable: "struct progre=
ss_info
> *pi"

Nice catch, Torsten. I had already caught it as the standard... that
one slipped by.

Was waiting for more comments to show up, but none so far so I'll send
another version with this adjustment.

Thanks again!
