From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Oddities cloning over http
Date: Wed, 11 Apr 2007 11:28:35 +1200
Message-ID: <46a038f90704101628o12d966e6je6e5cfd5a5ee576d@mail.gmail.com>
References: <46a038f90704100540y33c64a9au762fd927fb906f3d@mail.gmail.com>
	 <598D5675D34BE349929AF5EDE9B03E27E536AE@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 08:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbPlS-0002FV-Bq
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 01:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbXDJX2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 19:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435AbXDJX2h
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 19:28:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:27418 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbXDJX2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 19:28:36 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2059891wxd
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 16:28:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t4Xid9uPbdYqUdA0Ib9UVoUBUTsY5zhH7c0I8Rwy0D6WHmQjBx8lv683vGYDHDB976A+dQ/nR0qe99EhSuKcFjNGYbJ1trLSC6oWcZN2bch/lgZWEHAeePtG/eKahoh6K+AZw3ax4kqOkZ7iqIBYwQ3cAeSSQt83+Vov9pgtJm4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aetRBsE/JJ7R+Y6eV05RJYbGITvW7fq1XN6pTGiTJBUq6xsb146NddlzXgFr09igbceqwfGvFbXIIbloB98FNkNUoBrlYvyNkZ0DeAUXtVB1LsTRwfWl7RBZTveG/XfXqCm6PAcCigtdFfsQ0T1ELoRcKo8oXk7/pPxJ4r9gJxU=
Received: by 10.90.92.7 with SMTP id p7mr6166969agb.1176247715968;
        Tue, 10 Apr 2007 16:28:35 -0700 (PDT)
Received: by 10.90.120.11 with HTTP; Tue, 10 Apr 2007 16:28:35 -0700 (PDT)
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27E536AE@az33exm24.fsl.freescale.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44199>

On 4/11/07, Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com> wrote:
> I've seen this behavior when the server repo files don't have the same
> owner/group as the one you're running the server with. That happened to
> me after I edited the config files.

Ok - at least in my case, this seems to be related to problems
fetching HEAD on the server, probably because apache doesn't allow
symlinks. What I don't quite follow is where is the best place to
check for this. The logic is a bit muddy.

cheers,


martin
