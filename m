From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] git-web--browse: improve browser support under OS X
Date: Wed, 13 Feb 2008 19:13:24 -0500
Message-ID: <76718490802131613h713be217s51ff85a0714df5ff@mail.gmail.com>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
	 <7vve4wb3h7.fsf@gitster.siamese.dyndns.org>
	 <76718490802120840r4a45c016k4cccf321f68893ce@mail.gmail.com>
	 <200802130755.20884.chriscool@tuxfamily.org>
	 <7vk5l8o65o.fsf@gitster.siamese.dyndns.org>
	 <CE42C4F4-1E6B-4300-9FD9-29F7E17B4F27@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Christian Couder" <chriscool@tuxfamily.org>, git@vger.kernel.org
To: "Pieter de Bie" <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Feb 14 01:14:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPRjk-0000ZS-HQ
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 01:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759483AbYBNAN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 19:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760344AbYBNAN0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 19:13:26 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:62024 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759042AbYBNANZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 19:13:25 -0500
Received: by wa-out-1112.google.com with SMTP id v27so316191wah.23
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 16:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Htv94bmHQeMToD1yrW5gjqcaUdHeWcdLe4ENBRj+FMg=;
        b=SexyhN1nyj1SLoNVRx79BEWOwMXhVhqNNJsDma7aWF7Gge+ibf6ItkDVLW1SmkQJWWpU+DLkrgWoApdoYh9H5j3TIv5+Xp6xRxoYEpBcX846Mti6mWuYKIxcKVJwaOPy2v3/sa+CX/gHsl3qV2Kfmrp+BkvFv4fWwKrOxO09ihA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NmOiqY5z+h0BoPA9Dlr6dLrIOQurLpzgoZUSRNftaGTmcwKekdFYACof1Q0e4B263sSpp9vHrwDdqtU2PgbC/5aPYhCW+pFRY8m9ukEbkqTVcm1P/pBfwYk4RF1B389Y78rG2bcCu/EbaeRkKiB9NG8vcr+hjm+zLz080EtQ/J0=
Received: by 10.114.150.1 with SMTP id x1mr647255wad.145.1202948004446;
        Wed, 13 Feb 2008 16:13:24 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Wed, 13 Feb 2008 16:13:24 -0800 (PST)
In-Reply-To: <CE42C4F4-1E6B-4300-9FD9-29F7E17B4F27@ai.rug.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73831>

On Feb 13, 2008 5:46 PM, Pieter de Bie <pdebie@ai.rug.nl> wrote:
> When I SSH to my mac, the SECURITYSESSIONID variable isn't set, but
> open will succeed in displaying the page.
>
> Not sure if that is a valid concern though; how often would you do a
> remote login to your mac to display a webpage?

That is quite odd, but I've confirmed it under 10.5.2. In 10.5 I can
ssh to another Mac and /usr/bin/open a document. If I have a GUI login
already established on that Mac, I can see (via screen sharing) the
application is launched and the document handled. But here's the odd
part -- if I *don't* have a GUI login on that Mac, the application for
the document is *still* launched, but I guess it's running in some
sort of headless mode. I don't recall 10.4 operating this way.

But this is neither here nor there. AFAIK, SECURITYSESSIONID is unique
to OS X and it reliably indicates that the user is sitting in front of
the OS X GUI.

j.
