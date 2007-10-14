From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] Fix a crash in ls-remote when refspec expands into nothing
Date: Sun, 14 Oct 2007 23:26:05 +0200
Message-ID: <8c5c35580710141426t2fcd9c3v7cf29168b0fa5a53@mail.gmail.com>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi>
	 <1191919868-4963-2-git-send-email-v@pp.inet.fi>
	 <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi>
	 <20071009182043.GA2997@steel.home>
	 <20071010051034.GA30834@coredump.intra.peff.net>
	 <20071010212735.GB16635@steel.home>
	 <20071012040745.GC27899@spearce.org>
	 <20071012204004.GA6700@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jeff King" <peff@peff.net>,
	"=?UTF-8?Q?V=C3=A4in=C3=B6_J=C3=A4rvel=C3=A4?=" <v@pp.inet.fi>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 23:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhAyc-00064J-CG
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 23:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762723AbXJNV0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 17:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759839AbXJNV0H
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 17:26:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:13090 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759798AbXJNV0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 17:26:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1723839wah
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=H2KF+aS7b9ATDHleXkq9FmRmnBB+0PGxq/CkkY7jQvE=;
        b=blEaHMNxayOGLQcahGDFfbkzcHoYcvRBy1kavH3Y7iZQ6pgHqYcWQfe0307xV9HVG89DPfHPZkY06lu7WM8n2jyZLO+kRFjOrAB0vFnjxvpS/6QU7GtdmliXwaNphNf4xYRphgUEfUhk759DM7AlNSLCGjCTxD6kmOHrY3uvZVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o8vT8S3Z1dCAN4YcyoyqZeCWJEQC6K/0fSxqrqc9GSdwPIjlOPkJ24xb0uWoOvY4bCXXmWPxoVbRpVSxugidpyGdDoIdVhFDXgLoWt/WI0v3+fskXsZPgwLEG+726vkxEOqH9K++0rcMUaOWANv99Qzuli4i7iW9bgQqqPmBWvI=
Received: by 10.114.197.1 with SMTP id u1mr6183746waf.1192397165146;
        Sun, 14 Oct 2007 14:26:05 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sun, 14 Oct 2007 14:26:05 -0700 (PDT)
In-Reply-To: <20071012204004.GA6700@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60907>

On 10/12/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> Shawn O. Pearce, Fri, Oct 12, 2007 06:07:45 +0200:
> > I think the above patch is the only thing to do here.  Perhaps Alex
> > can write up a formal patch and send it to back to the list and CC
> > Lars Hjemli <hjemli@gmail.com> so he can put it into the patch queue.
>
> here you go
>

Thanks. I've replaced the tip of q/vj/fetch-t (in
git://hjemli.net/pub/git/git) with this patch.

-- 
larsh
