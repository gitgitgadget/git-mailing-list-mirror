From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 2/5] Add string search routines from GNU grep
Date: Sat, 13 Feb 2010 18:49:37 +0300
Message-ID: <37fcd2781002130749i1de2968cv68b785f6b5110e3@mail.gmail.com>
References: <20100213141558.22851.13660.stgit@fredrik-laptop>
	 <20100213142038.GC9543@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 16:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgKO1-0007St-0p
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 16:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757032Ab0BMP4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 10:56:45 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:56315 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756410Ab0BMP4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 10:56:45 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2010 10:56:44 EST
Received: by fxm27 with SMTP id 27so54684fxm.25
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 07:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=axEkKwgWKUTNluKZJkFb0V3VE1350y7GCRt36oVMF4A=;
        b=rIjFEJEhVi1/YYo2RGT1vmZ7b6SbUNxKc0pZKNdP9GSP6Do3uilbMhoY3cqBiwjY+B
         3F/c17K6THs2opgBno/hCYZpH3dhb7xOEas0vKQ3BxTubPy7CWYhcHO7/MFpLSJ0V0PL
         u2YxYWn6+i6HIP59CF637L6PZTxow7rqCrcCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HfSOFd1vK3vJrHHR/aB2sljx6q+39L25H2mCi8eiKD1hHm56/N7dBhXK6DeOVvgHMH
         zx4zYmB3I2kBJsVqC8CGzStdWMtG+LkEjjYW8+aM0PaGeXMI8n8i85J/yQMDR67rQkN+
         FOcQyY15tAtLG/fNkBfE7up9gLiYnW7H0o/Vg=
Received: by 10.239.190.19 with SMTP id v19mr292892hbh.171.1266076177659; Sat, 
	13 Feb 2010 07:49:37 -0800 (PST)
In-Reply-To: <20100213142038.GC9543@fredrik-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139807>

On Sat, Feb 13, 2010 at 5:20 PM, Fredrik Kuivinen <frekui@gmail.com> wr=
ote:
> @@ -0,0 +1,779 @@
> +/* kwset.c - search for any of a set of keywords.
> + =A0 Copyright (C) 1989, 1998, 2000, 2005, 2007, 2009
> + =A0 Free Software Foundation, Inc.
> +
> + =A0 This program is free software; you can redistribute it and/or m=
odify
> + =A0 it under the terms of the GNU General Public License as publish=
ed by
> + =A0 the Free Software Foundation; either version 3, or (at your opt=
ion)
> + =A0 any later version.

git uses GPLv2, and GPLv3 is incompatible with it.

Probably, you can try to find an older version that was licensed under =
GPL v2.
I've googled for kwset and found this:
http://www.opensource.apple.com/source/grep/grep-14/grep/src/kwset.c

Dmitry
