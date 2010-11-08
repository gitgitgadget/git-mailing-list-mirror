From: Brian Collins <bricollins@gmail.com>
Subject: Re: [PATCH v2] Run global hooks from the directory at hooks.dir
Date: Mon, 8 Nov 2010 05:59:35 -0800
Message-ID: <AANLkTikJACZxf6socuvXFMu7WUZ0y+s0ZRA2kYEKb19q@mail.gmail.com>
References: <1289219520-37435-1-git-send-email-bricollins@gmail.com>
	<4CD7FB37.4050107@viscovery.net>
	<AANLkTi=kFuoaV5Ur_a7FJPg_oUs3svOpq=wEVhdpuoai@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: s-beyer@gmx.net, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 08 14:59:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFSG8-0000Hn-Du
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 14:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110Ab0KHN7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 08:59:38 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60132 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000Ab0KHN7h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 08:59:37 -0500
Received: by wyb36 with SMTP id 36so3488252wyb.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3MNKsZbOY0fxOVZncUvYHf+eZ6ER4UjnRHZAcEu5ohk=;
        b=iJcmN1hENGpbsdD8tiRuT4mbEzwVtnGyZBmgUfiOBmFUMgRkllehEUp3SoSVuyIwdS
         ZC4s/oG9vHLhQo8NZO6Nb27uwilzY2FvyThGnoMZo6YpGrdAwiwei9DOSzO1UnMuyoOC
         bT0E7cFl2qb3tWat/8bMfqgC6OyouwYvPjQPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OM4z70+VbQR07wp+KZASac5NC8csg9zjrqqTcXXsuPiJV0Z2kmYfdJPurw+6MqxKWv
         RDZuCDWcpzHQRXopJfH5ni4Thf2qgBRPwH4OB7EbP57EgTvqwNCX/ptaMDStUJ9O809U
         M7SiYUb8Fmj8c065iW8lI5REHGfyPUeaJVsZ4=
Received: by 10.216.71.66 with SMTP id q44mr5412528wed.44.1289224775085; Mon,
 08 Nov 2010 05:59:35 -0800 (PST)
Received: by 10.216.233.41 with HTTP; Mon, 8 Nov 2010 05:59:35 -0800 (PST)
In-Reply-To: <AANLkTi=kFuoaV5Ur_a7FJPg_oUs3svOpq=wEVhdpuoai@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160941>

> I'm not in favor of this change, as a number of alternatives were
> suggested in the thread you cite (Gmane:
> http://thread.gmane.org/gmane.comp.version-control.git/150141).

The alternatives suggested need to be applied individually to each
repository. This can be problematic because you may want repository-specific
scripts as well. Then when you update your global hooks you have to deal
with merging with your repository-specific scripts. Using templates is not
ideal because it is system-wide and they still need to be renamed for every
clone or init.

> A few hints, just in case you deploy this code:

Thanks, I have fixed those issues.
