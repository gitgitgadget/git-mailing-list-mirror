From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: [MinGW PATCH] git clone was failing with 'invalid object name HEAD' if ran from cmd.exe directly
Date: Mon, 6 Aug 2007 15:32:56 -0700
Message-ID: <a1bbc6950708061532t45fb0cf4w716971260b0640ae@mail.gmail.com>
References: <BD28FA320B7749FFBE3135FE92380BCE@ntdev.corp.microsoft.com>
	 <Pine.LNX.4.64.0708061134380.14781@racer.site>
	 <a1bbc6950708061455v459182cei3fb6b3b518d4b176@mail.gmail.com>
	 <Pine.LNX.4.64.0708062255420.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:33:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIB8W-0002Bs-Au
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 00:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762842AbXHFWc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 18:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762271AbXHFWc7
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 18:32:59 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:17418 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbXHFWc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 18:32:57 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1240448rvb
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 15:32:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ikoIX+e87HLm6eMYDvLd1YGgXcdQIRFL5IDe5dulaqUr0y+4STva3u/ddmKYW10yfg9zN0m9r8JmiYWAVIBY37xmpQbq25ShdXwMBpUAF8Z+QK1kVZY+3qSln5SeAeF8fcy9boWTw+mAVUY9l7urJUoeZTGiZ6oRvjNkgcIQUWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WeQRCi0N7SSfFDCZGkjgRBs6BETkCxzjnUjkxZ8+89zojERS2wdcZ/gxehffi7ycWHqjyTtzGZuDgPwy8NdCwynva3nh0eFcmIIwJeBgj/eQb2hJ/NhHcOpxxbVYD2KH/H+xcM66sQJuD/Z0zDxHOHerliDPAfO06j/GQIWywr0=
Received: by 10.140.201.1 with SMTP id y1mr2284616rvf.1186439577020;
        Mon, 06 Aug 2007 15:32:57 -0700 (PDT)
Received: by 10.141.2.18 with HTTP; Mon, 6 Aug 2007 15:32:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708062255420.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55178>

On 8/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Does it mean that fork of a fork does not work on repo.or.cz?
>
> Yes, at the moment it does not work.  Therefore I set up
> git/mingw4msysgit.git, for the time being.

That's too bad.
I was thinking about adopting distributed dev model for MinGW port of Git:
we all would fork off mingw.git on repo.or.cz and then we would pull
from each other instead of exchanging patches thru e-mail.
Personally I don't like email patch exchange process.

Can this problem on repo.or.cs be fixed? Did Petr reply?

- Dmitry
