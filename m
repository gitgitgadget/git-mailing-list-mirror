From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 12:16:47 +1100
Message-ID: <ee77f5c20711131716l6dd1dccjcb3ff5f3a54c9359@mail.gmail.com>
References: <1194980792.4106.6.camel@localhost>
	 <ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	 <1194998142.4106.24.camel@localhost>
	 <ee77f5c20711131602m5b9042fx72689af53e24ddd2@mail.gmail.com>
	 <1194999404.4106.40.camel@localhost>
	 <ee77f5c20711131627q329d45aepe48102728cf2778c@mail.gmail.com>
	 <7vprydpr5o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kristis Makris" <kristis.makris@asu.edu>, jnareb@gmail.com,
	git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 02:17:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is6sa-0005se-0F
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 02:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761477AbXKNBQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 20:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761396AbXKNBQu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 20:16:50 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:18106 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761092AbXKNBQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 20:16:49 -0500
Received: by nz-out-0506.google.com with SMTP id s18so14031nze
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 17:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MvUZtWq/GP5PCvGsr72A/sC0Zdtwfghdy05msJUFLo0=;
        b=t1Ar9symghMrFptw0TnuNZ0yk8JrmBEbkWtk9uIaBXyNTwpvXq3yvpJ3FD6K2wI51IgOFkx3HBlTCNImVEbhfOyJrr29tEWOHoRLEm8lfBG2UyqjQbHH+A1H/Nfw8TjRvP0vCJ5SQVibSkZI4nrQcszFrYPtQ+ynN43Co510HUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XDEI3qUjt8eVHrl8CY6QXP/IrJXsu384NniOU8AEj/GE7vdjkZVUG0WcDE9xgxpiOXPu9Wfv40wlWIxu6Oixyj8F3UC0FM+CbajesYQIoF3LqIe2fJCpwiOSLjYx7T8z0qoAok4TyJMcxcVsb/UO07zrQGPoGdqbTURVRLOC1tI=
Received: by 10.142.14.20 with SMTP id 20mr16921wfn.1195003007609;
        Tue, 13 Nov 2007 17:16:47 -0800 (PST)
Received: by 10.142.142.12 with HTTP; Tue, 13 Nov 2007 17:16:47 -0800 (PST)
In-Reply-To: <7vprydpr5o.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64938>

On Nov 14, 2007 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "David Symonds" <dsymonds@gmail.com> writes:
>
> > Sure -- I've got a patch for it that I'll send shortly. It's using the
> > existing shell git-commit, so might be suitable for maint; I haven't
> > followed what's happened with the builtinification of git-commit.
>
> No, 'maint' won't get a feature enhancements.

Fair enough.

> Again, why isn't reading HEAD enough?

Reading HEAD would be fine. I guess it just seems a sensible and more
direct path to passing that information so that the hook has less to
do. It seems quite a simple thing that would be very helpful to hook
writers, with zero impact on everyone else.


Dave.
