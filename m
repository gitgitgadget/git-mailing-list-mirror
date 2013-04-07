From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers/test-bzr.sh: do not use grep \s
Date: Sun, 7 Apr 2013 04:02:54 -0500
Message-ID: <CAMP44s06=KCDfQuK1t2ZURoOzmF69pDXF0G6eji6EsiMAoBLbQ@mail.gmail.com>
References: <201304071048.31790.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 11:03:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOlV6-000297-Td
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 11:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760826Ab3DGJC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Apr 2013 05:02:56 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:42632 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757489Ab3DGJC4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 05:02:56 -0400
Received: by mail-lb0-f175.google.com with SMTP id o10so4895276lbi.34
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=i0vjdXtVT0We8YTzjm5HxWKPg36qlXjvycX+cDBgyV8=;
        b=VCns6ArqCNQn/RZECAX5J1GU3K+vGMwN1VMstXNiOi/0abfN0NLUr1p/mTr2GiGIjH
         MFKGhoRg3PSjFK/CmymaxJH8x3ENxiL1w0PlUryUFNlXtvy0ZhDXnO6iHkvAhHx8EknT
         kwboWKKKQCbonRxqsSC4vOTFbliqPknKk1TMs5F2YrZCT/ANohVk/dpW5I5wtYUNxEE0
         ZKBz+QnRodtwKQHjm+ewY93ipC0OpZMM2902YxM7b2Xl352ZaTBpRUrTXeQqP7Yshp1X
         SzHNxU1mCdZyeVgbjvRYQtNEcE2yrM+A6NaQV2bojbL8lAzLhFgFZ/kKr+t5WIOXguwi
         fBew==
X-Received: by 10.152.147.36 with SMTP id th4mr9632625lab.19.1365325374574;
 Sun, 07 Apr 2013 02:02:54 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 02:02:54 -0700 (PDT)
In-Reply-To: <201304071048.31790.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220300>

On Sun, Apr 7, 2013 at 3:48 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> Using grep "devel\s\+3:" to find at least one whitspace
> is not portable on all grep versions:
> Not all grep versions understand "\s" as a "whitespace".
>
> Use a literal TAB followed by SPACE like this [  ] instead.
> The + as a qualifier for "one or more" is not a basic regular express=
ion:
> use egrep instead of grep.

If "\t" is not possible, I would rather use [:space:].

Cheers.

--=20
=46elipe Contreras
