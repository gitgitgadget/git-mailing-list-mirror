From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH] Write new giturl(7) manpage
Date: Mon, 29 Mar 2010 22:35:12 +0530
Message-ID: <f3271551003291005rf2d2e57p90dad68e451e1ff3@mail.gmail.com>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com> 
	<alpine.LNX.2.00.1003291140270.14365@iabervon.org> <20100329155523.GA31829@LK-Perkele-V2.elisa-laajakaista.fi> 
	<fabb9a1e1003290859p25be2d7aqc7dcb46f3ec7ba4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 19:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwIPD-0007Ys-2V
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 19:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab0C2RFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 13:05:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52659 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab0C2RFd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 13:05:33 -0400
Received: by gyg13 with SMTP id 13so1563011gyg.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=rWyGwC72V2KRXyRa0m171dBwedyTBHCSaYz1EWpSVDY=;
        b=v6St00BhnFmrdFwkp3pllLYbWiQR8cV7SIN283jC3yo+Yslf3iSxDgW+s9Z4ktDdE1
         5g9GByY/BpQvEmi9En178Egbs619VYeCzU2VCdgPZaBq5lFTkwJDW359BcEHruedFOu1
         060FGOsZOEOBibUB46fzwkkGhbL6w+2dwHTms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=aLQnASrWfa4qUulnYYPdDVz60ltvhmo2ebjC/3aAWPOw2Sz+vyN5GZ+VJt62lqsfto
         00ftA08h2d0W4Bi2pzztp3qYx3Fu9ZX6ANlTwp86AgvO9WQLcejqqEwkNlknbyMq/h8E
         uACspZRHjX008R3HwKEVNNFxj8/kgHWDC+OWY=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 10:05:12 -0700 (PDT)
In-Reply-To: <fabb9a1e1003290859p25be2d7aqc7dcb46f3ec7ba4f@mail.gmail.com>
Received: by 10.90.59.25 with SMTP id h25mr2410043aga.108.1269882332234; Mon, 
	29 Mar 2010 10:05:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143500>

> One useful way of answering questions like this is to find the commits
> that added the <transport>::<address> syntax (probably easiest with git
> blame), and at the commits that touched urls.txt (probably with git log),
> and see if the reading the messages makes it obvious. I'd guess (without
> actually looking myself) that it was just overlooked.

Got it.

> Yup, my bad for not updating urls.txt (mainly because I didn't know it
> existed :P). I think Ramkumar's patch [0] to fix that is a step in the
> right direction :).

Thanks :) I've prepared a second revision, which is a complete rewrite
of urls. In the meantime, could you review this patch?

-- Ram
