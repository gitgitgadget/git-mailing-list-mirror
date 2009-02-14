From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] send-email: handle multiple Cc addresses when reading 
	mbox message
Date: Fri, 13 Feb 2009 19:42:16 -0500
Message-ID: <76718490902131642y62b81bfat129cfbeda7957ff8@mail.gmail.com>
References: <1234566313-36478-1-git-send-email-jaysoffian@gmail.com>
	 <20090214003113.GB7769@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 01:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY8dF-0006ky-Fr
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 01:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbZBNAmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 19:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbZBNAmS
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 19:42:18 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:48730 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbZBNAmR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 19:42:17 -0500
Received: by rv-out-0506.google.com with SMTP id g37so871108rvb.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 16:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cFPWQeguLujafm9w1L4A5sy50gk9P8jXLYNaHXlvfkU=;
        b=BsrXni+YC6zTc9JNVy+kvAjkD4Z0T6hVOEzDFFNpoMvY/rVorBQWp/sDeqnmqXdR07
         kOc9az5QqLLsGGGnW+/3ILUyQv2xiY6fipaZ7G/4dkRhFxO1T2A5mn0C4rN5htKqZ9A1
         coYRc2D4PKxRfyd12FHNMESAgoF4cGQaVfhPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XeRhMOmORvsl4YjcmYbiPU6szaPJiNyupw/Ab43tIAmw6f7ol4tBWvfH8cF6OzfvV9
         7sIqfu/egMKFPD4Uradd/ImujKEjH+2jwtzo9fwhvz02qmGUJ8h9cRH/fuywCkHjJaeO
         bkZED0bWGLi/h4fDx+KwOYyhwowiBwM/aReqY=
Received: by 10.141.100.15 with SMTP id c15mr1409333rvm.52.1234572136715; Fri, 
	13 Feb 2009 16:42:16 -0800 (PST)
In-Reply-To: <20090214003113.GB7769@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109793>

On Fri, Feb 13, 2009 at 7:31 PM, Jeff King <peff@peff.net> wrote:
> I don't know what the right solution is. I am certainly not volunteering
> to rewrite; I am very happy just using my actual MUA to send patches. :)

It is quite ugly, and I have thought about rewriting it.

But to be quite honest, I have become very discouraged over the last
two weeks about submitting patches. What seems at first to be a simple
change has required multiple revisions over frankly what feels to me
like nit-picking.

It goes like this:

Me: Notice wart
Me: Cut wart off (i.e. submit patch)
Reviewer: Sorry, you didn't cut that wart off to my standards, unless
you can do it better, I'd rather have the wart.

I dunno, maybe I'm too sensitive and don't have the fortitude for
contributing to git.

Or maybe I'm just venting on a Friday.

j.
