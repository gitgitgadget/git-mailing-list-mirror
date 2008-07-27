From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Fix some remaining old-style stg id calls
Date: Sun, 27 Jul 2008 09:24:35 +0100
Message-ID: <b0943d9e0807270124q34d40782o59859d94602ffad7@mail.gmail.com>
References: <20080713114047.18845.34899.stgit@localhost.localdomain>
	 <20080725004430.12440.49829.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 10:25:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN1ZQ-0000tf-MF
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 10:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbYG0IYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jul 2008 04:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbYG0IYh
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 04:24:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:54027 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYG0IYf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2008 04:24:35 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2617797waf.23
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xBoGKmfqLKQC6Si6+LWCd0zjD2uQfTBqinNfVGgDvCc=;
        b=nX8jvmxhhNEKEtF/1OF+v4qLHUr4yfs3kvGs5MUqp+xz24M2GO9Xk60cp1UP/o3dOS
         wr8SFqjytfl8MouPKHOgzJ7mL2wZZJHjITzKuAF3NxwP2AaDUFDBfU/fM7a0OFlJi1R6
         URcQrVAl804uICdl16oLiaUbRZrTfbt7wKgX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IJq7yc1pIE/O/BXU8cN6KRUuLpWEughCFAVP07QYZ1gv6DqTYz0wR1MQRFrmQ9eLeO
         mRvPnHInbk1XK979MUJnZhIGhryzPeRSbR95uVcCFHOkz/slDUGNFQ+4NkNna7Hr/eyE
         CeBPHNQdFfcr7ZlBZVECROdENBM1PXFG2BTos=
Received: by 10.115.92.2 with SMTP id u2mr3780218wal.33.1217147075536;
        Sun, 27 Jul 2008 01:24:35 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sun, 27 Jul 2008 01:24:35 -0700 (PDT)
In-Reply-To: <20080725004430.12440.49829.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90325>

2008/7/25 Karl Hasselstr=F6m <kha@treskal.com>:
> You'll want to add this (just squash it into your patch). The calls
> were failing, but since both sides produced the empty string on
> stdout, the test was happy anyway.

Thanks, that's why I haven't noticed it.

--=20
Catalin
