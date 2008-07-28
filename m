From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: theirs/ours was Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Mon, 28 Jul 2008 22:10:50 +0200
Message-ID: <bd6139dc0807281310j16b4ef5alf9738ec0f3270ba0@mail.gmail.com>
References: <bd6139dc0807280754x76b6ffedg6bf756dfce23f1e3@mail.gmail.com>
	 <20080728185604.GA26322@sigill.intra.peff.net>
	 <alpine.DEB.1.00.0807282008470.8986@racer>
	 <7vproxrcvu.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:12:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZ4W-0008Eg-GJ
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbYG1UKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbYG1UKv
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:10:51 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:19713 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbYG1UKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:10:51 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5943284wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 13:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mlxLgpi0vcpIm9dCmYC/YSeSvNQbWgGLZE0hiVN1XIE=;
        b=q8EAhn9hFoE+SCVyoZwJ8qOM8kRlL7uBUmK1Cgyzk2UFCd+SI1W8miHoHmovpVwDNh
         5q1EQMTZY2B5AFWAT7slruthLhQWoqGCd6fiMCoSq0jp5Nb/QlNZSIewFa8XQkRcQd6D
         5/7VKEpvWwo5Rrqk/HUSDeES9b3X17h3LoEa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=aI3hLXMokeLw+8gDRWeRJZ6i3+DsiDNmqdQgXPoKhgdp/4O8wg0U5lB3m7CSWU0wPz
         NLKA7RVXkJmuve6gzaKkneOGhtzoJ/Qh6pL7u7YWd300LIu6tm76IA5mB68JdxVh/emS
         3DykyYJvHN+EglnbSPd+pPWQclI/GUikYWVEk=
Received: by 10.142.177.7 with SMTP id z7mr1752449wfe.15.1217275850089;
        Mon, 28 Jul 2008 13:10:50 -0700 (PDT)
Received: by 10.142.104.10 with HTTP; Mon, 28 Jul 2008 13:10:50 -0700 (PDT)
In-Reply-To: <7vproxrcvu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90498>

On Mon, Jul 28, 2008 at 22:07, Junio C Hamano <gitster@pobox.com> wrote:
> That reminds me of:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/89178
>
> to one of whose messages I sent a response today.

Mhhh, but the proposed strategy there was in response to the 'insane'
git-merge-theirs version, not to the 'exact opposite of
git-merge-ours' that I refer to now, yes? Do you have any particular
feelings wrt to that?

-- 
Cheers,

Sverre Rabbelier
