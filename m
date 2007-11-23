From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Fri, 23 Nov 2007 20:09:41 +0100
Message-ID: <200711232009.41739.jnareb@gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> <7vabp5uhke.fsf@gitster.siamese.dyndns.org> <8aa486160711230734l30a3e907rac5aee11f3518e88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Santi =?iso-8859-1?q?B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 20:10:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivdup-0003pr-2l
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbXKWTJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Nov 2007 14:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757505AbXKWTJq
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:09:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:15892 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986AbXKWTJp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:09:45 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2863348nfb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 11:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=xys/1xAVVJeo5zk+vY0MAi04GoTaJLcrePAJGgI9ahQ=;
        b=foYSYfopUPuDmW8TP0Gc7+zxGv4c8ybVH7iB63GIvooC+XUuHPl6qi9u3Z7mTsIZaj5Pe0cEI8YgAOMEy7UiEWoeSXB7fcHe5PmrIYzvtnFLYprw3Fx93QUoBBJogJKYiebLJPsfOP48gpK/Ni6xcglY2flpLLQYFkSv3WdjG3k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YrjfC6yawatgR5Nj0mUmZ6VjDbEeJhLzDMtgcCxYC5NZUUBqu4G1UPyLCgyf+n2wWYEtli73MA1ZxQkZ4Y3h7nScTdsqs1ILyJDfJ7wv1My5fpI/rcGAQzET13QJhUwjx9dveHInPRKy5jG2Z/4YktIdmC3F6C/mME0ldzgOGDU=
Received: by 10.86.4.2 with SMTP id 2mr9836285fgd.1195844983265;
        Fri, 23 Nov 2007 11:09:43 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.249.172])
        by mx.google.com with ESMTPS id j12sm3452503fkf.2007.11.23.11.09.41
        (version=SSLv3 cipher=OTHER);
        Fri, 23 Nov 2007 11:09:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <8aa486160711230734l30a3e907rac5aee11f3518e88@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65908>

On Fri, 23 Nov 2007, Santi B=E9jar wrote:
> On Nov 23, 2007 4:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Santi B=E9jar" <sbejar@gmail.com> writes:
>>
>>> OK. So git push will never understand bundles.
>>
>> Why not?
>=20
> Sorry, I misunderstood you, because pushing to an existing
> bundle loses information, and that is also inconsistent with pushing
> to regular repositories.

Pushing to regular repositories _adds_ information (adds objects
and advances refs). Junio proposed that "git push <bundle>" do the
same, which means getting refs from bundle, and adding objects
to bundle creating new bundle, which contain all the old one has,
and all what was created since then. What information would be lost?

Johannes provided alternate solution which you can use even now,
namely how to create "incremental" bundle, which has all objects
since last bundle was created. But this does not play with the way
push works with ordinary, regular repositories.

P.S. Code speaks louder than words ;-)
--=20
Jakub Narebski
Poland
