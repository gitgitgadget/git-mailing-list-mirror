From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 2/2] Remove dead code after direct graph drawing
Date: Sat, 21 Oct 2006 21:33:14 +0200
Message-ID: <e5bfff550610211233i1af1c6a5nf2d50a6759dab061@mail.gmail.com>
References: <200610191613.19142.Josef.Weidendorfer@gmx.de>
	 <200610200111.26259.Josef.Weidendorfer@gmx.de>
	 <e5bfff550610202335rcb83ea8mf7ec2dd79ec6dd90@mail.gmail.com>
	 <200610211740.26128.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 21:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbMat-0005rB-AO
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 21:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422841AbWJUTdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 15:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422847AbWJUTdQ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 15:33:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:50593 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1422841AbWJUTdP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 15:33:15 -0400
Received: by nz-out-0102.google.com with SMTP id z3so465920nzf
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 12:33:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ph10BJsQ9HnPXOi5+MvgZnArgS8MqYwhAiOqdrOCfTlE3FI4vSrLVPfsUxWl9FsGntELlLGwQ/q4Ic/hW8aaaLTYZ0gr2Htm9dXvEEiut9ER3NktohK7iY1iRsa4xsJRsZmCoM7DN20jHoHwJ7HeyRPRgK0fi/SioXNFv2RVFQM=
Received: by 10.35.115.18 with SMTP id s18mr3255006pym;
        Sat, 21 Oct 2006 12:33:14 -0700 (PDT)
Received: by 10.35.42.4 with HTTP; Sat, 21 Oct 2006 12:33:14 -0700 (PDT)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200610211740.26128.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29665>

>
> On the first pass down, the memory increases by around 26 MB,
> which could by correct, as you do setupData() lazy (no idea what
> this function does...).

Populates the list view item and calculates (only calculation not
drawing) the graph of the item (see Git::updateLanes() )

> >
> > I'm not sure it depends on your patch though.
>
> Can you compare with/without my patch?

Yes. You are right, I have a memory increase also without your last patch.

>
> How did you check for leaks in the past?
> Did you try valgrind (memcheck or massif)?
>

I tried with valgrind but with little success due to a lot of noise
from qt libraries. Perhaps I was not using it right.


Sorry for the noise

Marco
