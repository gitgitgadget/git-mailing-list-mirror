From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: Re: [PATCH 6/9] update 'git-rm' bash completion according to the
 man page
Date: Sat, 8 Aug 2009 22:33:12 +0200
Message-ID: <20090808223312.75ba3d10@eleanor>
References: <9f50533b0908080156t7cfd05ebg3e5d29f7d2260c25@mail.gmail.com>
	<7vljludr2d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 22:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZsgE-0005KA-FT
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 22:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbZHHUiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 16:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZHHUiJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 16:38:09 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:46560 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbZHHUiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 16:38:08 -0400
Received: by ewy7 with SMTP id 7so1917418ewy.18
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=dhSBW4ZovNH0Llh6UJIIDeOyTFAb9l+8aWfJlI3hpmo=;
        b=cqJm3tXY9uswkg3WK0huI9iLJOzmNzZsdWi2oJpWJsazUJpZwuyqdLvC6i830IjdH0
         YmnzWuoYEWdnUaJj0F6AW56DwazpmGjuq1N5HKpJ2z+wjOJRgpYwcKBqhIXl/6mXhLGn
         8+2FLHjHgH2r4xvtDDdrpmH83Iy3gyGYihXU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=cIuiyONSjPldGhVn4U1hEb8qcLhzn6sbMQBTpfgSq1p7oBhQrwA1uHgimgTL56Uh8b
         y0rZjCheotnOZDSLcungkx40924H+7hYpT1AWvLdxBBg0qajZFPxYzWU7g1cYCk/6JqO
         av4zvKzghuJHcEZYh4CEMQ81Mc9uZLUAeLpyc=
Received: by 10.210.20.6 with SMTP id 6mr3147108ebt.59.1249763887700;
        Sat, 08 Aug 2009 13:38:07 -0700 (PDT)
Received: from eleanor (cxr69-1-87-88-216-137.dsl.club-internet.fr [87.88.216.137])
        by mx.google.com with ESMTPS id 28sm4484992eye.14.2009.08.08.13.38.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 13:38:07 -0700 (PDT)
In-Reply-To: <7vljludr2d.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125305>

> > -		__gitcomp "--cached --dry-run --ignore-unmatch
> > --quiet"
> > +		__gitcomp "--force --cached --dry-run
> > --ignore-unmatch --quiet"
> 
> I thought not completing --force to allow a dangerous operation was a
> conscious decision.
For me, completion as always been a reminder for options I forgot (or I
think they exist) and I use short options when I know them because it is
easier to type. So IMHO '--force' is a useful option that deserve to be
complete. 

But if you make a conscious decision in the past to not complete
'--force', I won't fight :-) and I will just add a comment in the
git-completion script for the guys like me who think it is missing.

Best regard 

Emmanuel
