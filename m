From: Benson Margulies <bimargulies@gmail.com>
Subject: Re: On MacOS, 1.7.2, git svn clone seems to fail silently
Date: Fri, 30 Jul 2010 22:32:23 -0400
Message-ID: <AANLkTikwi=hwqoEsJ-VQvMh7Z8h-WvjwrxgS05sc6-wz@mail.gmail.com>
References: <AANLkTimxqC3oax=Q0EppAb-Q7AzHshRkV=H=6dJDNhqY@mail.gmail.com>
	<20100731013509.GG5817@burratino>
	<AANLkTikwTqQpVO5SMUgqPr04=kAh570zT_RWdxjipid9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 04:32:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of1sE-00069A-NW
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 04:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab0GaCcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 22:32:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40778 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536Ab0GaCcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 22:32:24 -0400
Received: by wyb39 with SMTP id 39so1762063wyb.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 19:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=7KreEKtXNYa0Q6h3IJf+CrO6ELyDsh0Iu2pt6XAK2kQ=;
        b=F+D8FjIGzcE8GeyBkuljyc9ra+FOqKf8VbqEIeYiMBzfI5Iii3G2dXpp6Qw7cZQ1Hx
         O6LRc47xgQoFirks+GQzgpbWW9WKj5BgJmdwYRffqhPg8viO6in6qy6NeGGY9PAZ5Cox
         0U4+NvBVRH7p1Mn/JjPtOqkAJ0ATy6umfa2i8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=Gi7/dUXlQqLc80rUwmoCK+//Y0LIwt/MxCc6poXJ2aRSP8Ugw3r9Z8zojFlnv8WLGe
         Z69rSM6CD9RJuiKuMzP9zWg0Osp+EGEcbC+U3ciFwl9B7np3zjVRUwk0H3it0KRf5bNb
         W8kPcQypz8TyZzK/mya95v5SDMM7nd6+QHwvc=
Received: by 10.216.203.71 with SMTP id e49mr2411303weo.60.1280543543168; Fri, 
	30 Jul 2010 19:32:23 -0700 (PDT)
Received: by 10.216.155.17 with HTTP; Fri, 30 Jul 2010 19:32:23 -0700 (PDT)
In-Reply-To: <AANLkTikwTqQpVO5SMUgqPr04=kAh570zT_RWdxjipid9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152290>

Hello everyone.

There's a problem here, but not even remotely (pardon) the one I thought it was.

The right URL in this case with -s is
https://gate.svn.sourceforge.net/svnroot/gate/gate.

Note the extra /gate on the end.

It would be nice if this was diagnosed in fashion ("Dear user. That
doesn't look like a stdlayout svn directory) but the injury is mos def
self-inflicted.
