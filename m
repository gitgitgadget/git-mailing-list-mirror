From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 1/2] Re: show: suppress extra newline when showing
	annotated tag
Date: Sat, 18 Jul 2009 05:25:27 +0200
Message-ID: <20090718032527.GA16708@vidovic>
References: <20090717231622.GA13511@coredump.intra.peff.net> <20090717231834.GA13624@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 18 05:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS0Ye-0001R1-Ux
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 05:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303AbZGRDZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 23:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756971AbZGRDZc
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 23:25:32 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:20526 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543AbZGRDZb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 23:25:31 -0400
Received: by ey-out-2122.google.com with SMTP id 9so305802eyd.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 20:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=DHS8aHQZt4cZr9d4eRWDgBDFjHoQtmXI6rZZ/GFLp7A=;
        b=QLJMsHUK40lZM4inqfCIjCY+omgZSY0h3IIAVxwFOjnT1MXnmnXsVYByBL52HlMzLy
         KICZAHZyf8TSp6/+aMJpwwEpA+BXMY19sgEYHttF64C25n4Yo3K5mxnGvVVRDxDn7F1i
         LP60/HATfco7k1PMNiw2vUNhCDYWWJGtqgNrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SZup82bmjf8BP8GP6Mw1E7oQWCg9+nY0yJp3sIhMzNOaQRxh+PWesqxhNyfWsqwv+A
         1l1aihHNkd2DkpvtAsQdvf+B2Q7PsTH27L1vOejSrqDXK3TysXMgBHy1CpfCzy6nkP0e
         9OkDOGsAV/Yh1xzfG78RRweRAUKwHrGcGd5pc=
Received: by 10.210.87.14 with SMTP id k14mr1537772ebb.90.1247887530400;
        Fri, 17 Jul 2009 20:25:30 -0700 (PDT)
Received: from @ (91-164-145-221.rev.libertysurf.net [91.164.145.221])
        by mx.google.com with ESMTPS id 7sm4509105eyg.34.2009.07.17.20.25.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 17 Jul 2009 20:25:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090717231834.GA13624@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123506>

The 17/07/09, Jeff King wrote:

> However, we also add an extra newline when printing the
> tagger information. This leads to an ugly double-newline:

I can't see the double-newline.

>     $ git show v1.6.3
>     tag v1.6.3
>     Tagger: Junio C Hamano <gitster@pobox.com>
>     Date:   Wed May 6 18:16:47 2009 -0700
> 
>     GIT 1.6.3
>     -----BEGIN PGP SIGNATURE-----
>     ...

I guess you meant:

     $ git show v1.6.3
     tag v1.6.3
     Tagger: Junio C Hamano <gitster@pobox.com>
     Date:   Wed May 6 18:16:47 2009 -0700

 
     GIT 1.6.3
     -----BEGIN PGP SIGNATURE-----
     ...

-- 
Nicolas Sebrecht
