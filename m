From: "Sebastian Schuberth" <sschuberth@gmail.com>
Subject: Re: git merge with tkdiff fails (extra operand)
Date: Mon, 28 Jan 2008 15:05:12 +0100
Message-ID: <bdca99240801280605i55f3df00na0eea23488d26e17@mail.gmail.com>
References: <fnk90t$gkq$1@ger.gmane.org>
	 <alpine.LSU.1.00.0801281309240.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 28 15:06:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJUcN-0000If-6c
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 15:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944AbYA1OFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 09:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757478AbYA1OFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 09:05:16 -0500
Received: from hs-out-0708.google.com ([64.233.178.241]:20879 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756133AbYA1OFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 09:05:14 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1566605hsz.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kx2BL9sUtioQ1eOdoqKWhVrlneZ7Ihfyh0NzKxcWtSk=;
        b=AxQlafCdcL0cxmj+Ekta3Ut0+2q3bygkSyrYWaFGXTgNZubisPnPjZptqVWU672qsYqflqdiVBCbO2z7SPYXuXZ4mnN3I/knoKwaouE/SXwoXmlb7VxBNAjdofoY6DJf/m8SwPRlCSC0ooMW9nWkAbFQXDy1hPbuIorbGV1Aj/4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BrK9dZE/EKv03MngXi48LZnOM0q7z7mG6HIqqLuns0wKJrGcz9q4qaSxkp5+27DlcE+aZu6eBb1L2gu+1WR5f+h+izm4YFrqs737sXHUUtByH33+Kv4lsq5qyzucLYV7t70scgpPNsFsE9zAhmzorXpZH0UdlbETxUrnvzAXiFg=
Received: by 10.141.79.12 with SMTP id g12mr3451457rvl.87.1201529112988;
        Mon, 28 Jan 2008 06:05:12 -0800 (PST)
Received: by 10.140.134.7 with HTTP; Mon, 28 Jan 2008 06:05:12 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801281309240.23907@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71888>

> > I'm running Git 1.5.3.7 under SuSE 10.0. After pulling and getting a
> > merge conflict, "git mergetool" by default is configured to run tkdiff.
> > Unfortunately, tkdiff starts with an error:
> >
> > diff failed:
> > diff: extra operand
> > `Amira/QxViewer.cpp.REMOTE.28414`
> > diff: Try diff --help for more information.
> >
> > I'm not sure whether the error is with the tkdiff integration into Git,
> > or with tkdiff itself (as it refers to the help for "diff").
>
> It seems that tkdiff calls diff with arguments that diff does not like.
> What version of tkdiff do you use?

I'm running TkDiff 4.0.2 (and "diff (GNU diffutils) 2.8.7").

> P.S.: to make sure that it is tkdiff, I would search for this line in
> tkdiff:
>
>         set g(debug) f
>
> and change the "f" to "t".

I cannot find this line in my version of tkdiff ... in fact, the
string "debug" does not occur anywhere in the file.

-- 
Sebastian Schuberth
