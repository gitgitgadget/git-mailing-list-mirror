From: Gergely Buday <gbuday@gmail.com>
Subject: Re: removing a commit from a branch
Date: Wed, 4 May 2011 10:55:01 +0200
Message-ID: <BANLkTi=pVMrK8PM8s9MagN12FxMZ_=uAVw@mail.gmail.com>
References: <BANLkTimtpvVRU=1iCbrteyHixaWGuVKDjQ@mail.gmail.com>
	<20110504084502.GC8512@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 04 10:55:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHXrR-00051Y-Re
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 10:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab1EDIzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 04:55:03 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48367 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab1EDIzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 04:55:02 -0400
Received: by pvg12 with SMTP id 12so405264pvg.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=clX8VpSOwlCjV6pUOcuL6FcNE4KKIF8qx92sRi+bjDE=;
        b=eFE2U/+BcNxPPDpr07jRJxBL8ajbF91sE29rxCXXRn+rAjPxuZVypyZgvwdvqAU9HB
         drPvXFsmFqwbHm3MMqY7oUJDQVm1IHjPIkGshdvsBgqhbPFH8S/tSY33WL8m6hdsF0sy
         YDXh82RST3LGiQssHSvQ8mDIoHJBVBxnZLyxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qw51V3SjlsVqGRDwCx1ksWVNCP3KP8Q5qBMYd/iIeNGUvBjueGL1ce4+Lx7G4bvLyB
         UJXbn2DWZXrDhxodRJllRs8QIvwP6vR5jlfwso6Yie2IU7xovEW0/k9664BmDzRlKwzn
         qa8mDf0t74NlHN6KJoOfS5lpn5HS1iWFzal9k=
Received: by 10.142.154.13 with SMTP id b13mr466581wfe.161.1304499301450; Wed,
 04 May 2011 01:55:01 -0700 (PDT)
Received: by 10.142.128.16 with HTTP; Wed, 4 May 2011 01:55:01 -0700 (PDT)
In-Reply-To: <20110504084502.GC8512@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172728>

> Removing it will involve rewriting history, which can create headaches
> for people who have built on that history (they will need to rebase
> their commits on the rewritten history).

I did not push to any other repo yet, so this should be OK.

- Gergely
