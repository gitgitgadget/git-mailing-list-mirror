From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] errors: "strict subset" -> "ancestor"
Date: Sat, 3 Nov 2007 18:14:06 +1100
Message-ID: <ee77f5c20711030014x23ac6206rec81fe5968992147@mail.gmail.com>
References: <20071103023944.GA15379@fieldses.org>
	 <A4169B7B-C05B-4CA0-B41B-E1E2D71491B6@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 08:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoDD5-0003pk-9R
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 08:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844AbXKCHOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 03:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbXKCHOH
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 03:14:07 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:27389 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbXKCHOG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 03:14:06 -0400
Received: by rv-out-0910.google.com with SMTP id k20so994695rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m58XIcZidBv//oV9QPqrdZAuDPNXvA4cG/RMkm/zlXA=;
        b=ofJrgIG0P0uLmMEb8cZU3gIYUNDGLmsfjrCzgcOmrRMHFximEr3B6f/7CVeSMMp18+KcB4QkkHvfG/cfrc2UAgXQJoBzousw3GZ2WOdD2CycBBPM9PClreUdSbljTbQSxCfACwyv4YcSm53npe12CkZIuGFyuVHRlgZeQ9bhX+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hbBDkEq09OC/oruREefusbSYeIXV/ofktiCbtnxZ/xBpIgARLZ+yUeoYAP8m6T5Roxh2PXOBX1ryDsVohWRrtW7HaNIx5LhbODSOQSdXdSCkn/oicmPUPt/hvhkv+BlC+XnAvLkWtemt0o2Aib95WgxypKkW8mtAJh0E/r7UeE4=
Received: by 10.141.29.18 with SMTP id g18mr1313699rvj.1194074046181;
        Sat, 03 Nov 2007 00:14:06 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Sat, 3 Nov 2007 00:14:06 -0700 (PDT)
In-Reply-To: <A4169B7B-C05B-4CA0-B41B-E1E2D71491B6@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63208>

On 11/3/07, Steffen Prohaska <prohaska@zib.de> wrote:
>
> On Nov 3, 2007, at 3:39 AM, J. Bruce Fields wrote:
>
> > diff --git a/send-pack.c b/send-pack.c
> > index 5e127a1..b74fd45 100644
> > --- a/send-pack.c
> > +++ b/send-pack.c
> > @@ -297,9 +297,9 @@ static int send_pack(int in, int out, struct
> > remote *remote, int nr_refspec, cha
> >                                * commits at the remote end and likely
> >                                * we were not up to date to begin with.
> >                                */
> > -                             error("remote '%s' is not a strict "
> > -                                   "subset of local ref '%s'. "
> > -                                   "maybe you are not up-to-date and "
> > +                             error("remote '%s' is not an ancestor of\n"
> > +                                   " local  '%s'.\n"
>
> Two spaces in a row after local and before '%s'.

So? That's presumably to align the remote and local strings.


Dave.
