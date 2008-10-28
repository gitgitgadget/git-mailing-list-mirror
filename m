From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Gitk/Cygwin bug: phony local changes
Date: Tue, 28 Oct 2008 16:27:36 +0100
Message-ID: <81b0412b0810280827o2ccca3bfw127877782f5a0909@mail.gmail.com>
References: <83bpx62hbn.fsf@kalahari.s2.org> <837i7s3ga4.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Hannu Koivisto" <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Oct 28 16:29:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuqVD-0003hG-O7
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 16:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbYJ1P1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 11:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbYJ1P1k
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 11:27:40 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:3986 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbYJ1P1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 11:27:39 -0400
Received: by an-out-0708.google.com with SMTP id d40so210312and.103
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 08:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fapjdY+s0Ur2/Pnsu/rzt5eYhFyVLKk6nBTW9aG8wl8=;
        b=f4ewe5PEcYsqsWQvSwYRm/zZPmftNz+F++pBkPjDN9B9TLnFct9DRn4UDMT6sMtlsE
         UgOrNoKEppbu4PsUh+VkelbgDvG0H2fNM1DdoOTK9/AtfsctEhDdrBo0EmYjsr9jqIva
         52rrklQxB4j0g3Dn+9JIIx20yTFoNib8DZ+HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FvmapOe7DzC7ZeIdYIALgGdCy6L15LWk1Aj0BjsMqectu6S8N9XK0opwDjhLN5PRh9
         ZDlQ/fjPnV9bZOitbFXi+tq6x1PSwW8G08pfaadr3lesrg+tsaxAnASyWLmxBjc8mzL3
         a81GQsH7WlT8ITpH5uDhb23Bek/MlO5xzSNJM=
Received: by 10.101.68.19 with SMTP id v19mr7228160ank.62.1225207656593;
        Tue, 28 Oct 2008 08:27:36 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Tue, 28 Oct 2008 08:27:36 -0700 (PDT)
In-Reply-To: <837i7s3ga4.fsf@kalahari.s2.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99298>

2008/10/28 Hannu Koivisto <azure@iki.fi>:

> I used bisect to find which commit introduced this bug and the
> result is:
>
> 7faee6b8de836904227ee98dc3d2c4c75b0ef3a1 is first bad commit
> commit 7faee6b8de836904227ee98dc3d2c4c75b0ef3a1
> Author: Mark Levedahl <mlevedahl@gmail.com>
> Date:   Mon Oct 13 00:33:31 2008 -0400
>
>    compat/cygwin.c - Use cygwin's stat if core.filemode == true
>

Could you try the patch from Junio's "Re: [PATCH] Only update the
cygwin-related configuration during state auto-setup" mail and see
if it changes anything?
