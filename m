From: "Alexander Gladysh" <agladysh@gmail.com>
Subject: Re: List all SHA1 hashes in repo
Date: Sun, 23 Mar 2008 18:44:19 +0300
Message-ID: <c6c947f60803230844s6489422xba49a074d226702a@mail.gmail.com>
References: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com>
	 <alpine.LSU.1.00.0803231459100.4353@racer.site>
	 <540004BB-49C4-456B-ABA3-62659D85C15E@ai.rug.nl>
	 <alpine.LSU.1.00.0803231532150.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pieter de Bie" <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 16:45:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdSNZ-000070-6d
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 16:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbYCWPoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 11:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbYCWPoU
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 11:44:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:52162 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbYCWPoU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 11:44:20 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2897542wah.23
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SryXD37qQsCKcCSsOOFBcaUsQ8sEGfaZ2SVxJVng9Fc=;
        b=pRhPatP3+6/r5xHhzhqNBvwtUHkDA0n0qpW7K/vuvLZxtR/nRCxn7twwEC8FKYpI3w6tcL19OxoQM37IyQMO9EwmKThZ1IK2muqFQ664Blgbd5ohHp5AuUe2U6yC0ag89VXc5PfdNZgGHhu74oR8h0koeh6fhATDGgUcNvttw7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PBV2gLFOOp0B7fSQZWipWDVnHoM3Xry09uo16Rg9xTBHRCI3tGvG5NnDx2SbqWeot6aWzbhGPlLb7zFJBUeinSfKiELZR7I66h4bBfWnuA6QTSzNw17l5wjoQltnix39SLS19DxZAy8VulQk15F2uQcFLAnZ6tUqjPsXFKMwnD0=
Received: by 10.114.134.20 with SMTP id h20mr9826468wad.91.1206287059945;
        Sun, 23 Mar 2008 08:44:19 -0700 (PDT)
Received: by 10.115.111.4 with HTTP; Sun, 23 Mar 2008 08:44:19 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803231532150.4353@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77919>

> > > > The git rev-list --all gives nice list, but, as I understand, that
>  > > > is only commit objects, and there are much more of SHA1 hidden
>  > > > inside.
>  > >
>  > > Just add --objects.
>
> > I thought --all --objects only shows reachable objects?
>
>  Ah yes.  But usually the objects in packs are reachable...
>
>  So you're right, it does not really show _all_ objects.  But it shows many
>  objects, and is pretty easy (which I think was the original poster's real
>  question).

Yes, this is a perfect solution. Thank you!

Alexander.

P.S. Sorry for double-posting, Dscho, I forgot Reply to All too. :-)
