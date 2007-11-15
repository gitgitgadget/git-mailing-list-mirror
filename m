From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: [PATCH] Extend cat-file to take multiple arguments or read input from stdin.
Date: Thu, 15 Nov 2007 11:33:38 -0200
Message-ID: <f329bf540711150533n5aeb454ay1a27e6a8a313b248@mail.gmail.com>
References: <fhghqv$98a$1@ger.gmane.org>
	 <Pine.LNX.4.64.0711150432420.4362@racer.site>
	 <fhgitt$b8d$1@ger.gmane.org>
	 <7vd4uc82g2.fsf@gitster.siamese.dyndns.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Adam Roben" <aroben@apple.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 14:33:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iseqy-0006o1-Rr
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 14:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbXKONdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 08:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756603AbXKONdk
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 08:33:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:11239 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbXKONdj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 08:33:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so620252wah
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 05:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=aGzDRAILLaDsQ95XfP6leBvtGJPPZ6DBeompqxm+Y04=;
        b=f5PpQJDYyPiTblLpVAKZ8nQzEMERTbi2ObhlaMfo6X9Ij5zQmioGr8Eb4JLYmArpsvoVVfK3gqDvUn/0xoNveVbw1JH9MjHOhbHcf9XmX2WHw1CXmaqEY8Nlyp9PLhLgIwDd8Q55trcgGQ+lRidQ3+MZgvtNzF03XNpj7Stxov8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XSqtbGekSQPy2qdA+tLJ2dUTD14neRuVZDJPE6ZkG64k5Rpf8WYTloZm3XVhhxunhQdLPtSD8pwtQy/mJD0nuC+lmed79UtAtaTSrpNh83wAD9cp0imOn+h6WQMx+mEXZ80z1wUxm6JCBMhCSYXSxaZLS3LuCHORXorj5EjecKA=
Received: by 10.115.15.1 with SMTP id s1mr728797wai.1195133618770;
        Thu, 15 Nov 2007 05:33:38 -0800 (PST)
Received: by 10.114.76.4 with HTTP; Thu, 15 Nov 2007 05:33:38 -0800 (PST)
In-Reply-To: <7vd4uc82g2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65118>

2007/11/15, Junio C Hamano <gitster@pobox.com>:
> > I suppose fast-export would just be cat-file with a different name and
> > slightly saner interface.  How about
> >
> >   type <sha1> <newline>
> >   size <sha1> <newline>
> >   dump <type> <sha1> <newline>
>
> I wondered why that looked so familiar ;-)
>
>         http://thread.gmane.org/gmane.comp.version-control.git/62295/focus=62441

So,  where has that patch gone?

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
