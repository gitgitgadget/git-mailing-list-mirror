From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT experimental branches updated
Date: Mon, 3 Sep 2007 10:32:47 +0100
Message-ID: <b0943d9e0709030232r5a98ecdeja936a022bd1646c@mail.gmail.com>
References: <20070903002029.GA31957@diana.vm.bytemark.co.uk>
	 <b0943d9e0709030129y2ced4f61jaf42c07a7798f47a@mail.gmail.com>
	 <20070903090121.GA5051@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 11:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS8Ig-0007fx-8I
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 11:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbXICJct convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 05:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbXICJct
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 05:32:49 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:27789 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbXICJcs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 05:32:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so916113rvb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 02:32:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k9pq7vBeC5ZgoeSPyacUsVJMrx6ksNqYpcu1Rv3DLolXC1bv87UJdrLcMjbGJgYoSONI8untT/fpom/8jXtAEMv/HG3Pqb/yfjtDKiaB2DbFvwZ2oSKrAABTYJ2bkZdElem25tGZ4D0QIFsy5C738cI6L9pAxICftqh9c1whQmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CNhd20avBiY81q6EaAq6HZOS9rp4TQQV/WeBYxiqM+Jp+a0lSBvMn5opGovLgP/eB6CFbgNppdOn2lpsgnIG0+oNoi0A42YiKxtVv7ixexHaC17/jYxe6IgpF/GFqsnSlMxBsxdMK+GhQXHIN9sPbG+vDhL6OZiYiTQamQ/2Xas=
Received: by 10.141.171.6 with SMTP id y6mr1886150rvo.1188811967541;
        Mon, 03 Sep 2007 02:32:47 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Mon, 3 Sep 2007 02:32:47 -0700 (PDT)
In-Reply-To: <20070903090121.GA5051@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57461>

On 03/09/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-09-03 09:29:18 +0100, Catalin Marinas wrote:
>
> > BTW, would an extension to 'stg import' to import patches from
> > mailing lists (NNTP or maybe just mbox) directly be useful? There i=
s
> > support for mbox importing anyway and it would need a procmail
> > filter to generate the mbox and just a regex filtering in 'import'
> > to apply the StGIT patches only.
>
> I don't think I'd use that function -- it's very convenient to just
> manually copy the patch mails I want to a separate mbox, which I then
> pipe to git-am. (Yes, I know, I should be using "stg import", but "st=
g
> assimilate" is just too useful.)

I usually save them to an mbox as well (but use stg import). Until
recently, when I started merging your 'safe' branch :-).

--=20
Catalin
