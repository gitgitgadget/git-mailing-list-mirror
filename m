From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] fetch: align new ref summary printout in UTF-8 locales
Date: Thu, 6 Sep 2012 22:36:17 +0700
Message-ID: <CACsJy8D3VyFk+0PTeeXTN-Js9x7p+a+2vW+trry8-6q+9=m2xg@mail.gmail.com>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
 <1346755175-31468-1-git-send-email-pclouds@gmail.com> <504796A5.4070700@gmail.com>
 <5047A602.1020802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9e8X-0007QN-3c
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 17:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674Ab2IFPgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Sep 2012 11:36:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63065 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab2IFPgs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 11:36:48 -0400
Received: by mail-iy0-f174.google.com with SMTP id k25so2179097iah.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=59uxiC/w2XuezJkjvZ9XcJLB1tB2ybrXlE/w9X+XrrY=;
        b=aEXTJ5esyyOoCoe4+RN1iIqjY8s3+wDVEwspO43zs0l95awLTvPcD/zuMfHtxoi0Xs
         G7OeR/Z6d3FS5ZIQVFZfWgnPvImFWIvGa89mv2dbEo8ZaRgiXyLC85UviVZ6xyx7+lCQ
         b10Z93s67Wc9tnNgAzxy7u3Djkcm7YlcaBCytIUKEWGcSFJ3J5tf+61QKKWq5iLBQytW
         3e30mmr2XA4gDg21KqhGnW72L66xCAL1Ly5w7R7rHCSnQQCh75IOZoNPgmOXLBe+cnk0
         SruDd1h1kmGlRSSa0VuWiQsNA3GYUdJGq+rSpTyF/+W6AX6UI8B/VtRwgJ6/AQl/948M
         NnlQ==
Received: by 10.50.13.200 with SMTP id j8mr3535716igc.48.1346945808498; Thu,
 06 Sep 2012 08:36:48 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Thu, 6 Sep 2012 08:36:17 -0700 (PDT)
In-Reply-To: <5047A602.1020802@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204899>

On Thu, Sep 6, 2012 at 2:20 AM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
>> Will that work for non-ASCII encodings?
>> For ISO-8859-x we can say strlen() =3D=3D strwidth(),
>> but for other encodings using multibytes that doesn't work, does it?

BTW if you are interested in supporting non-utf8 output, you may want
to look at 1452bd6 (branch -v: align even when branch names are in
UTF-8 - 2012-08-26), which assumes branches are in utf-8. So you have
to convert them to output charset before printing.
--=20
Duy
