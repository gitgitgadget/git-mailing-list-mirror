From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: fixing workdirs
Date: Thu, 8 Jul 2010 15:56:51 -0400
Message-ID: <AANLkTil1jhqfg-WsTq6g7tMhavG_CzJf01CBzXnd_nBx@mail.gmail.com>
References: <20100708110842.GC12789@madism.org> <7v7hl5pxt0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@madism.org>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 22:03:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWxJE-0005yl-Vn
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 22:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab0GHUCy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 16:02:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51533 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0GHUCx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 16:02:53 -0400
Received: by gye5 with SMTP id 5so685991gye.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=OkEmzZrA6Dr2NWjlim+MOy6Do5hWiiq29faZfTTtA1U=;
        b=rZiqGCuveH3HOZvWibLcmiWpUHDkG4FCu2CxXsBMomnaEtjrzkbnz6msZQqExlJn1F
         p9M2oYhWSE3uD3w33x+3AX1YNlpsjLchSOqp1RAwCWeJZsjD/UvzKWBW9OGOS+6S9dfS
         F1+heNXhxkr7BWP+HNiuhIVmfuOm746zCozUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DHmEPmIP/6K+WvDt8Q3YAjga+emDa3NueGXE0iWVE585l3snx/0wG9D/HNJxvItDGC
         o+rB9eh16PZh0b02nKLC8IdXXQeFTO2HxplLrRVBCmP9d5NmFxsfVP8sBQpKpkZZtRRd
         Yd+aBMLFQGdh2jIxT0LaJH4R5CoyABV42V5T0=
Received: by 10.150.181.3 with SMTP id d3mr994191ybf.28.1278619362506; Thu, 08 
	Jul 2010 13:02:42 -0700 (PDT)
Received: by 10.151.45.4 with HTTP; Thu, 8 Jul 2010 12:56:51 -0700 (PDT)
In-Reply-To: <7v7hl5pxt0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150608>

On Thu, Jul 8, 2010 at 3:40 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Pierre Habouzit <madcoder@madism.org> writes:
>> ... git checkout would check that no other workdir is currently "on
>> the same branch", and would refuse to checkout to a branch that is
>> already checkouted elsewhere.
>
> I am personally fine with this, but if there is no way to override th=
is
> refusal it may break some people's existing workflow. =A0I dunno.

Perhaps it would be better to refuse to *update* a particular ref if
some other worktree has it checked out?  I don't think actually having
multiple trees checked out to the same branch is a problem, so much as
what happens when they start committing.

Have fun,

Avery
