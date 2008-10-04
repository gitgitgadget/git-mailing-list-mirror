From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Forcing progerss output for clone
Date: Sat, 4 Oct 2008 23:42:15 +0200
Message-ID: <81b0412b0810041442i3aa29628lf66ef9b188fe8ce7@mail.gmail.com>
References: <85647ef50810031301k641c5f24n65fb213c2b481e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Constantine Plotnikov" <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 23:43:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmEuN-0002jo-HH
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 23:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbYJDVmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753595AbYJDVmR
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 17:42:17 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:53444 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbYJDVmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 17:42:17 -0400
Received: by yw-out-2324.google.com with SMTP id 9so343491ywe.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=x+BeR8+d40lBIJ3vGlq7jGmsA1Py6iDqLZ1yo9pR5Sc=;
        b=pKzOZS2wD1oXTumil0F93NLQVXX4kmDNeyitGiFxy48T9xWGv6Z3YkELitrNX7owht
         RsaB2B186ya4XuK60eF06gfJJW3Lo1J+JXM0Xpca2wUPwEGX3zGsYOrFSsC+wVJoY9+2
         zUAM+WV7r5dl42fgcAPw38J3/o++psKdzNu7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MCD25ZYRC0bX7DCgrO+t/b7MdnT1EgykYmUpXu52VHQ+ShNch4PPcRF1MImZ9fryEC
         gpQMWjC/0uGH0FNOEZnSSWB07fc/XXb74Dk1vkAAzovtK6/oaGDslsut40atdIne8+X8
         QeW+e824lNcVaFnhDl6iyAxvRSuGX9l9fGW6A=
Received: by 10.100.140.15 with SMTP id n15mr3244375and.69.1223156535614;
        Sat, 04 Oct 2008 14:42:15 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sat, 4 Oct 2008 14:42:15 -0700 (PDT)
In-Reply-To: <85647ef50810031301k641c5f24n65fb213c2b481e7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97479>

2008/10/3 Constantine Plotnikov <constantine.plotnikov@gmail.com>:
> Is there a way to force a progress output on stderr for git clone
> preferably using options or environment variables?

No, but "-v" option is not used for anything yet, so you are free to
implement it.
