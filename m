From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 16:34:27 +0100
Message-ID: <8aa486160711230734l30a3e907rac5aee11f3518e88@mail.gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	 <8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
	 <7v4pfe7g4e.fsf@gitster.siamese.dyndns.org>
	 <200711231018.49322.jnareb@gmail.com>
	 <7vejehux3y.fsf@gitster.siamese.dyndns.org>
	 <8aa486160711230213q6038037epe2cbd0240db8b612@mail.gmail.com>
	 <7vabp5uhke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 16:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvaYO-0007d5-Ij
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 16:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbXKWPeb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 10:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbXKWPeb
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 10:34:31 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:2363 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753772AbXKWPea convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2007 10:34:30 -0500
Received: by rn-out-0102.google.com with SMTP id s46so4289791rnb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 07:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ohVuCpsA0MXFTMd2Bj1E1N+rju2SsTY+1u6uhQjiJ9Y=;
        b=gV3esmah0dXrYXzLAr2t/AR7aDc77eOQ/mn8YRSLzWRjezxZvJ2r0brSTOk9yv+2+06znyXSKZvXiQf1QvxBNZgmjZrfXwL/0egWLVWRRH6PWpLAvENuFJl/8A9V42r6ENzv2fcrce9+pZkvFgeb7DR572MRxmbRb0ICA3BLOy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MSoWofaQDzminvlnVnknoI9M+/zwCvPqqLrzJKLQ28t5BymNfHWOHBhtKZ11ZR1vEtlMLORyLKvCfjoTDI7XnFHfHKKnkYf5UUoOx7lIC+0IjL0QFyM2acn4qon+75NRkfZJgd+6KaqUkd2CULoL9c/8eV9oJGsmwPGrbKcinUE=
Received: by 10.150.205.13 with SMTP id c13mr890675ybg.1195832067896;
        Fri, 23 Nov 2007 07:34:27 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Fri, 23 Nov 2007 07:34:27 -0800 (PST)
In-Reply-To: <7vabp5uhke.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65903>

On Nov 23, 2007 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> > OK. So git push will never understand bundles.
>
> Why not?

Sorry, I misunderstood you, because pushing to an existing
bundle loses information, and that is also inconsistent with pushing
to regular repositories.

>  Because you will not code it?
>
> I am not opposed to the notion of "pushing to a bundle to
> update it."  I am just saying that "pushing to create" only for
> bundle and not regular repository is very inconsistent.

Santi
