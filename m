From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Suggestion: make git checkout safer
Date: Fri, 5 Jun 2015 17:49:04 +0700
Message-ID: <CACsJy8Ch7myCC8s-=0yRvQYT_Rwrz97ZAW3mU2KQxVdac6vcbw@mail.gmail.com>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net>
 <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net>
 <loom.20150603T114527-151@post.gmane.org> <20150603194756.GB29730@vps892.directvps.nl>
 <loom.20150604T124827-124@post.gmane.org> <5570B1AC.2060108@web.de> <loom.20150605T113129-339@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 12:49:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0pC0-0008TY-NF
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 12:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754190AbbFEKtg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 06:49:36 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34623 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752975AbbFEKtf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2015 06:49:35 -0400
Received: by iebmu5 with SMTP id mu5so20055430ieb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 03:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oELCj03ZX8pR7dl7LTGp7hhnTR4Bt4eGizqtw+T9big=;
        b=nlZOMFB+yh6rgmAwG4bmRZzFhLSY4IEact6/PgIKdiMwwd51bExKeMISGTD32QMr9P
         mvG5ZwEaC/qrpJ4A2jtxeH0s5td8ZD03z5PZigIiof+8t5dQtriooSbFsC6P3mI8WmfV
         AayLz6C5LvshrJvnKwZPolfMt3TjXSC+ynhi6LrkjGIjIN1qjj2OCjamb7MserUOp3WO
         YA1zmoA5p12ManNfn5xgP5mD3Ba0TWHfUSk7oBPStarfS8R/ufFSkRA05c73ZNjrRp5h
         NSvo97Vzx7DUkq9OMEUb7zg36Ued3m7gdVPQu5fByW6IK1sO2Ja3R+QOc6znJWgO/hPY
         NVug==
X-Received: by 10.50.4.66 with SMTP id i2mr40741388igi.40.1433501375313; Fri,
 05 Jun 2015 03:49:35 -0700 (PDT)
Received: by 10.107.6.9 with HTTP; Fri, 5 Jun 2015 03:49:04 -0700 (PDT)
In-Reply-To: <loom.20150605T113129-339@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270825>

On Fri, Jun 5, 2015 at 4:32 PM, Ed Avis <eda@waniasset.com> wrote:
> Torsten B=C3=B6gershausen <tboegi <at> web.de> writes:
>
>>Do you think you can write a patch to improve the documentation ?
>
> Here is my attempt, but it is only a starting point.
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-check=
out.txt
> index d263a56..ee25354 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -3,7 +3,7 @@ git-checkout(1)
>
>  NAME
>  ----
> -git-checkout - Checkout a branch or paths to the working tree
> +git-checkout - Overwrite working tree files with a given branch

Maybe "switch branches or reset working tree files"?
--=20
Duy
