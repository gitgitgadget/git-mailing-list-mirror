From: "Fernando J. Pereda" <ferdy@gentoo.org>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Mon, 21 May 2007 20:17:55 +0200
Message-ID: <20070521181755.GA4696@ferdyx.org>
References: <20070520181447.GA10638@ferdyx.org> <7vd50uj29r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705211355181.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 21 20:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCSP-0004Jf-Ch
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757732AbXEUSSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 14:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761568AbXEUSSH
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 14:18:07 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:38033 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757732AbXEUSSE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 14:18:04 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1029816ika
        for <git@vger.kernel.org>; Mon, 21 May 2007 11:18:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=OLV1L9KfK1/y8V24XOLWKWGEYmFEfNlDwoZLMMsBoFHgCfovZHFkS3mKSz7hOhdurORattgs0dZzoMkgtR23gXYqHZyR8CdgHUq0NHaNAF/P1HABffEXPsGPEoAPyoWyCpfeoLg9S/zrUTWxY+hvcpKfhOGMEGOVOQvq47ycZmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent:sender;
        b=dTqRIqaWUhFn51tYMb8I2mdPi4nJ8wGpOmXdBe54qW11OyHUxjftWkftyeTUm6G8ILAGffjFsYM9O9yBcBSyMLBISHElMbsDL1Ad2YxffXJKg8Vhw0LQsZZ/Sf+NyIo+IH//lq9cbbM1M5Gv+hH4x6VYu5rg2NM7Z/9Qdrd1xEc=
Received: by 10.65.222.11 with SMTP id z11mr6004628qbq.1179771482569;
        Mon, 21 May 2007 11:18:02 -0700 (PDT)
Received: from posidon.ferdyx.org ( [213.96.222.170])
        by mx.google.com with ESMTP id a29sm7045980qbd.2007.05.21.11.17.57;
        Mon, 21 May 2007 11:18:00 -0700 (PDT)
Received: by posidon.ferdyx.org (nbSMTP-1.01-cvs) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	ferdy@gentoo.org; Mon, 21 May 2007 20:17:58 +0200 (CEST)
Mail-Followup-To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705211355181.6410@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48036>

On Mon, May 21, 2007 at 01:56:31PM +0100, Johannes Schindelin wrote:
>
> Should we not just stop when split_maildir() or split_mbox() returns =
-1?=20
> And yes, we'd probably need a second variable to do take the return v=
alue.
>

Sure, I'll send a new patch with that.

- ferdy

--=20
=46ernando J. Pereda Garcimart=EDn
20BB BDC3 761A 4781 E6ED  ED0B 0A48 5B0C 60BD 28D4
