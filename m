From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 19:08:04 +1300
Message-ID: <46a038f90711132208r4daf477cle54f2feb95852cdb@mail.gmail.com>
References: <1194980792.4106.6.camel@localhost>
	 <ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
	 <1194998142.4106.24.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Symonds" <dsymonds@gmail.com>, jnareb@gmail.com,
	git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: "Kristis Makris" <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Wed Nov 14 07:08:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsBQm-0000nD-DK
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 07:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbXKNGIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 01:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbXKNGIJ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 01:08:09 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:37167 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbXKNGIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 01:08:06 -0500
Received: by an-out-0708.google.com with SMTP id b36so12522ana
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 22:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YylsWpqWC9eR/hf9FXAts8+p4Q1Y3/h/iD78C9eu/EQ=;
        b=jcv15alXdfdTg8LvVtpgV/bTQzcSAVHRHbvARRdlY3SQ72FS/XfOq68V+2luCzxVL6nUM5bQa+bR5FjYU94hgvtAseGqbwR9CvZaxeAbz1wkInhlxD7OHiHmdhiBTk+jR5KGGsdITESzZV2vEAOux1KRxKfPgobCINbaMZDTFik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OGNblp2U/GWAH858Gja3yPVQLYjh4M1SeA31KRM7PVx7SOviOH3Hx3fBRhGHSUGHQ+tghkUpjxouelDMHmVJyJyRocWg09FnHlmyEfdHub+E1zIiRtd3Wi2MonjLA20A0DfXXhHycdqqIzj4jJ1NOuayL5t9qNs9S//LcSyxNU0=
Received: by 10.100.31.3 with SMTP id e3mr11017158ane.1195020484679;
        Tue, 13 Nov 2007 22:08:04 -0800 (PST)
Received: by 10.100.228.13 with HTTP; Tue, 13 Nov 2007 22:08:04 -0800 (PST)
In-Reply-To: <1194998142.4106.24.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64952>

On Nov 14, 2007 12:55 PM, Kristis Makris <kristis.makris@asu.edu> wrote:
> It isn't a centralized bug-tracking system necessarily. Because
> different developers may used different, custom bug-tracking systems,
> with custom hooks in their own local Git repositories that integrate
> with only their own bug-tracking systems. And perhaps we can add the
> support in the Scmbug Git frontend to integrate with a centralized
> bug-tracker only on push operations if desired.

I disagree somewhat here. In git, local commits are extremely
lightweight, and as a developer I don't want anything remarkable to
happen on those, even locally. It's pushing (which is actually
publishing!) that makes those commits relevant.

Even if I have a local or distributed bugtracker, any purely local
commit is "draft".

And this is regardless of centralised or distributed -- that's a
matter of policy around the repo I'm pushing to. The distinction that
matters is local vs published. Local commits get removed, rebased,
redone, discarded a whole lot.

> But we can't explore any of these issues, discussed in the thread below
> too, unless we can extract what's needed from the hooks.

I concur with the chorus that chants "HEAD"... try with `git show
HEAD` for starters...

cheers,


martin
