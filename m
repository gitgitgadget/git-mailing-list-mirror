From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Tweak t3102-ls-tree-wildcards to run on Windows
Date: Thu, 12 May 2011 19:19:59 +0700
Message-ID: <BANLkTino-zmbRqNat-TO8YcQHCrMr4A06A@mail.gmail.com>
References: <4DCB9C42.5070806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu May 12 14:20:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKUsd-0003TB-LO
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 14:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940Ab1ELMUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2011 08:20:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38923 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897Ab1ELMUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 08:20:30 -0400
Received: by bwz15 with SMTP id 15so1237815bwz.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=+LhW7utWTy7Q3pP0+rKaThuCfBLsxPcK59Lpciw4SXk=;
        b=DvWjWbdQ12sds1cj48qdQpi+Eu8Vm5BwFAIi91UtzKaRf5SShIc4Lx+LiQsfQpBaa/
         jTY2bKOh9H51yQdUzHuZdbl1j7R5JLQrYWGqb3J9DDw4cqx/WkOSWYpu1nUoizyyFli0
         x/pxQW6re5jSzEaHWT/YMYpjgxiLatHshKW8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d8CvgrFWBHvSpGdEI4kzKOK3pZeTdq30sldBQU9eCnr4w7nnroHzBavO8rcyK9WJVi
         yOp3JICo/K5xHzEtXQqBf36Yb7YzbX9NIHp873ioXMiWyMlm/jzDiQUwdGa8c/1z8J7l
         8w1j4xBdD9h2RAiw7ZTS6co5ATsTqApdb7pPE=
Received: by 10.204.45.152 with SMTP id e24mr139995bkf.47.1305202829166; Thu,
 12 May 2011 05:20:29 -0700 (PDT)
Received: by 10.204.53.13 with HTTP; Thu, 12 May 2011 05:19:59 -0700 (PDT)
In-Reply-To: <4DCB9C42.5070806@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173465>

2011/5/12 Johannes Sixt <j.sixt@viscovery.net>:
> From: Johannes Sixt <j6t@kdbg.org>
>
> The test case fails on Windows, because "a*" is an invalid file name.
> Therefore, use "a[a]" instead.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> =C2=A0Regarding the change from * to [], I do not know whether the re=
sult
> =C2=A0still tests the same thing. Please advise!

The result is correct. Whatever pattern you throw at ls-tree should be
interpreted literally, no magic at all.

Acked-by: me.
--=20
Duy
