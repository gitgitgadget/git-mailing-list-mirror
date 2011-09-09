From: Aneesh Bhasin <contact.aneesh@gmail.com>
Subject: Re: can Git encrypt/decrypt .gpg on push/fetch?
Date: Fri, 9 Sep 2011 16:20:10 +0530
Message-ID: <CAGhXAGSw3y=cjAHXtwycDifoBPr13AkYtLHRRXejRKue0vkz7A@mail.gmail.com>
References: <87lityxbg7.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tzz@lifelogs.com
X-From: git-owner@vger.kernel.org Fri Sep 09 12:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1yfR-0004M1-En
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 12:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758739Ab1IIKub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Sep 2011 06:50:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51940 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758727Ab1IIKua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Sep 2011 06:50:30 -0400
Received: by ywf7 with SMTP id 7so1494736ywf.19
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 03:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Y9UYBx2C9VRQf+zD4MHt2bAJsLbyt5sUNaFNKWZVUjs=;
        b=t909LCayU9jKYGVMpMToeAzncqPLQlso50YAOC7IW7RsjmxMRFDSB6a3rn6JwO9kzv
         PQpLilj6wLuFguBhas3IJJETUPI4BeDHkJhL6wRAtewNQdCZCEdzgugkHfSfHlKjfLKy
         ROAMNvNSItTsXQyZDrZZZxt/ZtxhRnjSS5KhQ=
Received: by 10.101.154.17 with SMTP id g17mr1668569ano.32.1315565430303; Fri,
 09 Sep 2011 03:50:30 -0700 (PDT)
Received: by 10.100.226.19 with HTTP; Fri, 9 Sep 2011 03:50:10 -0700 (PDT)
In-Reply-To: <87lityxbg7.fsf@lifelogs.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181046>

Hi Ted,


2011/9/9 Ted Zlatanov <tzz@lifelogs.com>
>
> I need to store some encrypted files in Git but for some clients with
> the right GPG keys, decrypt them on checkout (possibly also encrypt t=
hem
> back on commit, but that's not as important).
>
> diff doesn't have to work, this is just for convenience. =A0Can Git d=
o
> this (matching only .gpg files) or do I need my own command to run af=
ter
> the checkout/fetch and before commit? =A0It seems pretty out of Git's
> scope but perhaps others have done this before.
>

Have you looked at git hooks (e.g. here : http://progit.org/book/ch7-3.=
html).

You could do the encryption/decryption in pre-commit and post-checkout
hooks scripts respectively...

regards,
Aneesh
