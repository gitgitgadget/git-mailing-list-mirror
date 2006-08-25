From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH/RFC 1/x] gitweb: Use git-diff-tree patch output for commitdiff
Date: Fri, 25 Aug 2006 19:32:36 +0200
Message-ID: <e5bfff550608251032p53ba203fl27af782c765f929f@mail.gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
	 <7v3bbmhoa2.fsf@assigned-by-dhcp.cox.net> <eck1em$p8b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 25 19:32:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGfXw-0003lf-KH
	for gcvg-git@gmane.org; Fri, 25 Aug 2006 19:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWHYRci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Aug 2006 13:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWHYRci
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 13:32:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:44660 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751443AbWHYRch (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Aug 2006 13:32:37 -0400
Received: by nz-out-0102.google.com with SMTP id n1so654952nzf
        for <git@vger.kernel.org>; Fri, 25 Aug 2006 10:32:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oso7BbvHPL7q4/xP/p23KEFj0V3pxnkK/OIeNCKL3keHpYaQbuclBkSoOzqGUUl6YKSn2UPOfhCNtQ3CvmBC27PNqIsYVUDqQZl0b8GjEEf2ze+zCONRUnCyrV0WNFeH/9wcTJ/jVbkVs7G04Ecbzr2QiyV9Qz5d14d7/mJdUFg=
Received: by 10.35.49.1 with SMTP id b1mr5473003pyk;
        Fri, 25 Aug 2006 10:32:36 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Fri, 25 Aug 2006 10:32:36 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <eck1em$p8b$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26001>

> >>    Empty patches (mode changes and pure renames and copying)
> >>    are not written currently.
> >
> > That's quite bad.
>
> This can be easily changed. Question: what format? Current "gitweb diff

I don't know if has always been like this, but I don't see on gitweb
(http://www.kernel.org/git/?p=qgit/qgit.git;a=shortlog) the diff of
the patch I've just pushed.

The patch is "Fix correct permissions on this excutable script",
currently the HEAD of qgit repo. The content it's only a file mode
change in helpgen.sh, so it' an 'empty' patch.

I've done something wrong or it's gitweb that does not show this info?

Thanks
Marco
