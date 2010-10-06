From: fREW Schmidt <frioux@gmail.com>
Subject: Re: Git over SMBFS
Date: Wed, 6 Oct 2010 09:12:18 -0500
Message-ID: <AANLkTi=Mee1zUK1vX3GTVYfGaVH2dNOr2Phpu=NdrLTm@mail.gmail.com>
References: <AANLkTik9U_jr6r6BuUcRrk8pjQTacKDY7YbqWnfrCLmD@mail.gmail.com> <4CAC0AEA.6050502@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Kai Blin <kai@samba.org>
X-From: git-owner@vger.kernel.org Wed Oct 06 16:12:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Uje-0000BJ-NL
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 16:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758990Ab0JFOMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 10:12:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59389 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab0JFOMk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 10:12:40 -0400
Received: by qwh6 with SMTP id 6so629175qwh.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=kzddq31sikOyIKCi8kRxOAXhggRTwwRKwpTtRFUfpbI=;
        b=kamb5zbuxoDpQnfS0gzSixga86dQB/M5RXHE5WdovCmL36XOMYsevNaCpbIqrRVRQJ
         so86M08prMDl7bXtncPfGJriR1nzgOGYdKa2E3b3Qxo+xHdnxBIejy4siM1OpZAaQ23y
         RdpalC9pMfSlB24Et154Qb0DbZUminQ5jwt4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EJwed5FKaZJBGzfZtN2bpAMu8a2J/w4VArYjz5GB1oYP9MIQyqpW6rlhgoE1uePDtb
         OouoLrlQ/eLYFeFVtYTSruPydvUc3qgXN8hVA9zmQUMAcESTZrTvgdGaYXWGRg162o4t
         QipT+0kxLy9VIYVEMA+y1fxbF/uyQNt+NTlz4=
Received: by 10.224.45.139 with SMTP id e11mr9568929qaf.79.1286374359220; Wed,
 06 Oct 2010 07:12:39 -0700 (PDT)
Received: by 10.224.67.80 with HTTP; Wed, 6 Oct 2010 07:12:18 -0700 (PDT)
In-Reply-To: <4CAC0AEA.6050502@samba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158288>

> > A coworker of mine is working on a project that is running on a
> > windows server.
>
> Please tell me you're not really using smbfs as the filesystem but
> you're actually using the cifs kernel module. smbfs has been deprecated
> years ago and is unlikely to work correctly against servers more recent
> than Win NT 4.0.

Yeah, sorry, it *is* cifs.
--
fREW Schmidt
http://blog.afoolishmanifesto.com
