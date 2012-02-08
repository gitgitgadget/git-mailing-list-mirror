From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/4] Deprecate "not allow as-is commit with i-t-a entries"
Date: Wed, 8 Feb 2012 11:03:46 +0700
Message-ID: <CACsJy8DSM3kPXJ4oYexCLs5qp6YdZ4Mf9RrGo78a0tHkRaTe4g@mail.gmail.com>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com> <7v8vke38a1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 05:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruyla-000350-B6
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 05:04:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab2BHEES convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 23:04:18 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:62317 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab2BHEER convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 23:04:17 -0500
Received: by werb13 with SMTP id b13so73040wer.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 20:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=f4O+vppwEmkiZforV49mz8t1tcY797/91188xWlyhTA=;
        b=X4l8cMV9ecLJWNRz97dFTxG0n/JjY/n/LmACq6+PdBVFqNBLKDizD5iH8HeROiLyWR
         1g2l3cKxb+zftktYwxV0hWgycPpDuuZKqFNrAub/YGjHUV1RTOv5qUWZDEooRdx/hUAe
         A9Ygk1qYzIDGe9C7CeKXOhnmjXXS1IfcqBZbs=
Received: by 10.180.19.97 with SMTP id d1mr38265431wie.12.1328673856313; Tue,
 07 Feb 2012 20:04:16 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Tue, 7 Feb 2012 20:03:46 -0800 (PST)
In-Reply-To: <7v8vke38a1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190219>

2012/2/7 Junio C Hamano <gitster@pobox.com>:
> But when I said "let's admit that this is just fixing an UI mistake, =
no
> configuration, no options", I really meant it. =C2=A0Without the back=
ward
> compatiblity "For now please do not fix this bug for me and keep bein=
g
> buggy until I get used to the non-buggy behaviour" fuss, which we nev=
er do
> to any bugfix.

Ahh I missed something again. Your patch looks good too.

> That is how we are planning to handle "git merge" update to spawn edi=
tor
> in interactive session in the next release. There is no "Please keep =
the
> buggy behaviour" option; only an environment variable to help when we
> mistake a scripted use as interactive, whose support is not going awa=
y
> because it is not about "until I get used to the new behaviour".
--=20
Duy
