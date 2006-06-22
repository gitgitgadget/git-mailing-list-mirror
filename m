From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Incremental CVS update
Date: Fri, 23 Jun 2006 07:36:00 +1200
Message-ID: <46a038f90606221236j2c5c9692yecef924aa769c1c9@mail.gmail.com>
References: <9e4733910606220526o14ebe76ala4d327f012a0e8f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Keith Packard" <keithp@keithp.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 22 21:36:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtUyF-0003HO-UD
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 21:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWFVTgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 15:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbWFVTgE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 15:36:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:41053 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751534AbWFVTgC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 15:36:02 -0400
Received: by ug-out-1314.google.com with SMTP id a2so664079ugf
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 12:36:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LYRr1ttWgongEji7yp/hyiJ9oSBtbWgZ0TqW756TNH/r/XI4fcSxwh1285nOen3qk6nVIIf1tVNN8PXyu8DF+Ra65Y6UBpIaMVq6Dc+AKduEL42d3WZOICDubi+EiLFyeGQvcNCRIVJm7oixu4Ug/cA+8weHvt1P94nhH0a0nE0=
Received: by 10.78.179.12 with SMTP id b12mr753401huf;
        Thu, 22 Jun 2006 12:36:00 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Thu, 22 Jun 2006 12:36:00 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606220526o14ebe76ala4d327f012a0e8f5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22359>

On 6/23/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> cvsps keeps it's incremental status in ~/.cvps/*. parsecvs might want
> to keep it's status in the .git repository and use tags to locate it.
> You could even have a utility to show when and what was imported. By
> keeping everything in git it doesn't matter who runs the incremental
> update commands.

Jon,

what cvsps keeps is a cache of what it knows about the repo history,
to ask only for new commits. Now, cvsps will always write to STDOUT
the full history, and git-cvsimport discards the commits it has
already seen, based on reading the state of each git head.

So cvsps + git-cvsimport don't keep any extra data around, and I am
100% certain that parsecvs don't need that either.

cheers,


martin
